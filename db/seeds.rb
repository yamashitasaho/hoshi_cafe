# ユーザー作成（seed データだけ先に削除）
# seed で投入された user1～user14 を削除
User.where(id: 1..14).destroy_all
Post.where(user_id: 1..14).destroy_all

=begin
# ユーザー作成（usernameで英数のみ）
if User.count == 0 && Post.count == 0
# デプロイ時の重複を防ぐ
10.times do |i|
    User.create!(
      username: "user#{i + 1}",
      email: "user#{i + 1}@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  user_ids = User.ids

  # 日本の都道府県リスト
  prefectures = [
    "北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県",
    "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県",
    "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県",
    "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県",
    "奈良県", "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県",
    "徳島県", "香川県", "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県",
    "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"
  ]

  # カフェ名のサンプル
  cafe_names = [ "ブルーマウンテン", "アロマカフェ", "コーヒービーン", "カフェモカ", "エスプレッソ" ]

  # レビューコメントのサンプル
  review_comments = [
    "雰囲気も良く、コーヒーも美味しかったです。また行きたいと思います！",
    "スタッフの接客が丁寧で、居心地の良いカフェでした。",
    "コーヒーの香りが素晴らしく、ゆっくりと過ごせました。",
    "デザートも充実していて、友人とのお喋りにぴったりでした。",
    "落ち着いた内装で、読書をするのに最適な環境でした。"
  ]

  # 投稿作成
  20.times do |index|
    user = User.find(user_ids.sample)

    # 過去30日間のランダムな時間
    random_days_ago = rand(0..30)
    random_time = random_days_ago.days.ago

    user.posts.create!(
      region: prefectures.sample,
      shop_name: "#{cafe_names.sample}#{rand(1..99)}号店",
      body: review_comments.sample,
      rating: rand(1..5),
      created_at: random_time,
      updated_at: random_time
    )
  end

else
  puts "データが既に存在するためseedをスキップしました"
end
=end