class GooglePlacesService
    include HTTParty
    base_uri 'https://places.googleapis.com/v1'

    def initialize
        @api_key = ENV['GOOGLE_MAPS_API_KEY']
    end

    # Text Search（新版）で店舗を検索
    def search_text(query)
        # ↓ エンドポイント（どこに送るか）
        response = self.class.post(
        '/places:searchText',
        # ↓ ヘッダー（送り方の情報）
        headers: headers,
        # ↓ ボディ（実際に送るデータ）
        body: { textQuery: query,
                languageCode: 'ja'}.to_json
        )

        handle_response(response)
    end

    private

    # ↓ ヘッダー（送り方の情報）

    def headers
        {
          'Content-Type' => 'application/json',
          'X-Goog-Api-Key' => @api_key,
          'X-Goog-FieldMask' => 'places.id,places.displayName,places.formattedAddress,places.googleMapsUri,places.regularOpeningHours.weekdayDescriptions,places.internationalPhoneNumber'
        }
    end

    def handle_response(response)
        if response.success?
            JSON.parse(response.body)
            # JSONをRubyのハッシュに変換 {"places"=>[{"id"=>"ChIJ...", "displayName"=>"スターバックス"}]}に変換
        else
          { error: "API Error: #{response.code}" }
        end
    end
end