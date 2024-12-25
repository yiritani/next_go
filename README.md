# Fullstack Template


## コンセプト
- Next.jsとgolang/ginを使ったフルスタック開発のテンプレート
- Next.jsでは特段何もしておらず、主にgolangのスタートアップ
- terraformでGoogle Cloudに環境構築

### Frontend: Next.js
- ただbackendにgetリクエストするだけ
### Backend: golang/gin/sqlc
- Framework: Gin
- SQL Builder: sqlc
- ローカルでは`air`でホットリロード。
### job: golang
- ただbackendにgetリクエストするだけ


### Database: PostgreSQL

## ディレクトリ
```
├── apps
│ ├── backend     # golang/gin
│ └── frontend         # nextjs/App router
├── infra
```