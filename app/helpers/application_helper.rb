module ApplicationHelper
    def get_twitter_card_info(post)
      twitter_card = {}

      twitter_card[:card] = "summary_large_image"

        twitter_card[:url] = post_url(post)
        twitter_card[:title] = "#{post.shop_name} - hoshi cafe"
        twitter_card[:description] = "#{post.region}のカフェ | ★#{post.rating}"

        # 画像の有無で分岐
        if post.image.attached?
          twitter_card[:image] = url_for(post.image)
        else
          twitter_card[:image] = image_url("coffee.jpg")
        end

      twitter_card
    end
end
