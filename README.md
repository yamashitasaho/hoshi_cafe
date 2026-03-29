# hoshi cafe

評価で「本当に良いカフェ」が見えるレビュー型SNS

サービスURL：https://hoshi-cafe.onrender.com

<img width="1200" height="630" alt="Group 130" src="https://github.com/user-attachments/assets/93109d46-8d39-4173-9940-bf0fa1576819" />

【ゲストユーザーアカウント】

Email : hoshi.cafe.app@gmail.com  
Password : password

---

## 目次
- [サービス概要](#サービス概要)
- [開発背景](#開発背景)
- [主な機能](#主な機能)
- [差別化ポイント](#差別化ポイント)
- [技術スタック](#技術スタック)
- [画面遷移図](#画面遷移図)

---

## サービス概要

hoshi cafe は、★5段階のリアルなスコアと地域検索で、自分にぴったりのカフェが見つかるレビュー型SNSです。  
店名と地域を入力するだけで店舗情報（営業時間・住所など）を自動補完。  
投稿のハードルを下げながら、PR投稿の有無を明示することで信頼できる口コミを実現します。

---

## 開発背景

カフェ巡りが趣味で、SNSに投稿するたびに住所・営業時間を公式サイトからコピーする作業が負担でした。  
また投稿に詳細情報がないと、見る側も店名を別途検索する必要があり、情報の断絶が生じていました。  
「発信者も閲覧者もスムーズに情報を扱えるサービスが作りたい」と考えたことが開発のきっかけです。

また近年、SNS上のPR投稿が急増し「どれが本当におすすめなのか」が見えづらくなっています。  
自身がPR案件を経験したことで、正直なレビューがしづらい状況への疑問を持つようになりました。  
本サービスでは評価の透明性を重視し、PRの有無に関わらず自由な意見を投稿できる仕組みを目指しています。

---

## 主な機能

| 機能 | 説明 |
|------|------|
| 投稿機能 | 画像・コメント・★評価・PR有無を投稿できる |
| 店舗詳細の自動取得 | 「店名＋地域」でGoogle Place APIから住所・営業時間を自動取得 |
| 地図表示 | 投稿した店舗の位置をGoogleマップで表示 |
| 投稿検索 | 地域・店名で絞り込み検索（Ransack） |
| お気に入り保存 | 気になる投稿を非同期でお気に入り登録（Ajax） |
| プロフィール | アイコン・自己紹介を表示・編集できる |
| 認証機能 | ユーザー登録 / ログイン / パスワード再設定（Devise）/ Googleログイン |
| レスポンシブ対応 | スマートフォンでも快適に使える |

### 機能デモ

| トップページ | 新規投稿 |
|---|---|
|![トップページ](https://github.com/user-attachments/assets/482237ff-1ae1-4558-829e-440e8e247def)|![新規投稿](https://github.com/user-attachments/assets/17278120-f337-4426-8377-d6bfe7d6a877)|
| アプリの説明と使える機能を紹介 | 都道府県・店名・評価・PRの有無・画像・コメントを投稿 |

| 店舗詳細の自動取得 | 投稿検索 |
|---|---|
|![店舗詳細取得](https://github.com/user-attachments/assets/99d0506f-6a15-4935-aa3c-fa176faaa0ad)|![検索機能](https://github.com/user-attachments/assets/5959dd2b-009d-453e-b9e3-07103657fa4e)|
| 店名・地域から住所・営業時間・Google Mapsを自動取得 | 地域・店名で絞り込み検索 |

| 投稿詳細 | お気に入り |
|---|---|
|![投稿詳細](https://github.com/user-attachments/assets/c688f62c-0c82-4678-924b-894b126f8bd8)|![お気に入り機能](https://github.com/user-attachments/assets/b98a8735-dc2a-4d9d-987c-325af08b0d49)|
| 店舗詳細・Google Maps・評価・PRの有無を確認・Xへ共有 | お気に入りした投稿をマイページで確認 |

---

## 差別化ポイント

**① 投稿のハードルが低い**  
店舗名と地域、評価、PR有無を入力するだけで投稿が完了。情報発信の習慣がない人でも使いやすい設計です。

**② 一目で伝わる評価設計**  
PRに左右されず、リアルな体験を★5段階で可視化。信頼できる評価に基づいてお店を選べます。

**③ PR投稿への透明性**  
PRかどうかが投稿に明示されるため、ユーザーが自分で判断可能。SNS上の広告的情報と一線を画し、信頼性を確保しています。

---

## 技術スタック

| カテゴリ | 技術 |
|------|------|
| バックエンド | Ruby 3.2.3 / Rails 7.1.3.4 |
| フロントエンド | HTML / JavaScript / Tailwind CSS |
| データベース | PostgreSQL（Render） |
| ファイルストレージ | AWS S3 |
| 認証 | Devise / Google OAuth |
| 外部API | Google Place API / Google Maps Embed API |
| 画像アップロード | ActiveStorage |
| 検索 | Ransack |
| インフラ | Render |
| 開発環境 | Docker |
| バージョン管理 | GitHub |

---

## ER図
[![Image from Gyazo](https://i.gyazo.com/cca5881d116b76a1fb4b1f44c4dedcab.jpg)](https://gyazo.com/cca5881d116b76a1fb4b1f44c4dedcab)


## 画面遷移図

[Figma で確認する](https://www.figma.com/design/DcABATuumX4IbAq62FhHYB/%E6%98%9F%E3%82%AB%E3%83%95%E3%82%A7%E3%82%A2%E3%83%97%E3%83%AA?node-id=71-4546&p=f&t=Vv5xeOXlVcbtQXJX-0)
