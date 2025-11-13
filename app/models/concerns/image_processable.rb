require "image_processing/vips" # gemを読み込む

module ImageProcessable
  # エラーの出力を行いたいのでStandardErrorクラスをImageProcessingErrorクラスに継承
  class ImageProcessingError < StandardError; end

  # 画像処理メソッド。image_ioにはparams[:post][:image]の中の一時ファイルを渡す
  # widthには横幅の最大値を渡す
  def process_and_transform_image(image_io, width)
    return unless image_io.present?

    begin

        # 画像処理
        processed_image = ImageProcessing::Vips
          .source(image_io) # 元画像設定
          .resize_to_fit(width, nil) # サイズ調整
          .convert("webp")  # 形式変換
          .saver(strip: true, # メタデータ削除でプライバシー保護
                quality: 85 # 画質
                )
          .call # 実行

          # libvipsが作ったファイルをrailsが使えるように包装する
          ActionDispatch::Http::UploadedFile.new(
            tempfile: processed_image, # 処理済みの画像データ（一時ファイル）
            filename: "#{File.basename(image_io.original_filename, '.*')}.webp", # ファイル名を "photo.webp" に変更
            type: "image/webp" # このファイルはwebp画像ですよ
          )
    rescue => e
      # ログに記録
      Rails.logger.error "Image processing error: #{e.message}"
      # ユーザーに分かりやすいエラーを raise
      raise ImageProcessingError, "画像の処理中にエラーが発生しました: #{e.message}"





    end
  end
end
