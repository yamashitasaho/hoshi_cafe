class ShopsController < ApplicationController
  # 店舗検索用のエンドポイント（Ajax用）
  def search_place
    query = params[:query] #店舗名

    # バリデーション: 店舗名が空でないかチェック
    if query.blank?
        render json: { error: "店舗名を入力してください" }, status: :bad_request # 400 Bad Request - クライアントのリクエストが不正
        return #処理を終了させる
    end

    # Google Places APIを呼び出し services/google_places_service.rb
    service = GooglePlacesService.new
    response = service.search_text(query)

    # APIエラーチェック
    if response[:error]
        render json: { error: "API呼び出しに失敗しました: #{response[:error]}" }, status: :internal_server_error
        return
    end

    # 全ての検索結果を返す
    places = response['places']

    if places.present?
        # 各店舗情報を整形
        results = places.map do |place|
            {
                place_id: place['id'],
                name: place.dig('displayName', 'text'),
                address: place['formattedAddress'],
                google_map_url: place['googleMapsUri'],
                business_hours: place.dig('regularOpeningHours', 'weekdayDescriptions'),
                phone_number: place['internationalPhoneNumber']
            }
        end

        render json: { places: results, found: true }
    else
        # 検索結果が見つからなかった場合
        render json: {places: [], found: false, search_query: query }
    end
rescue => e  # 予期しないエラーをキャッチして変数eに格納
    render json: { error: "検索中にエラーが発生しました" }, status: :internal_server_error
  end
end