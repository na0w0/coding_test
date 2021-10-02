## コーディングテスト課題
### 題材
- ブログ

### 使用した技術スタック
- Rails:  6.1.4.1
- Ruby:   3.0.2p107
- MySQL:  8.2.6

### Gem
- dotenv-rails
- devise
- devise-i18n
- devise-i18n-views
- rspec-rails
- factory_bot_rails
- faker
- rexml

### yarn
- bootstrap5
- jquery3
- popper.js
- prettier
- prettier/plugin-ruby

### 開発環境
- docker
- docker-compose

### 開発環境構築手順
```
# .envファイルをコピー
cp .env.sample .env

# コンテナをビルド
docker-compose build

# bundle installを実行
docker-compose run web bundle install

# webpack installを実行
docker-compose run web webpacker:install

# マイグレーションを実行
docker-compose run web rails db:migrate

# コンテナをバックグラウンドで起動
docker-compose up -d

http://localhost:3000 にアクセス

# コンテナ起動中はdocker-compose exec web を利用する
```
