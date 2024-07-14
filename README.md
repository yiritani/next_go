# Fullstack Template


## コンセプト
- Next.jsとgolang/ginを使ったフルスタック開発のテンプレート
- Next.jsでは特段何もしておらず、主にgolangのスタートアップ
- production Dockerfileはまだ未着手
- Turborepoでモノリポ化

### Frontend: Next.js
App Routerで謎のlintエラー出ている
### Backend: golang/gin/sqlc
- Framework: Gin
- SQL Builder: sqlc

ローカルでは`air`でホットリロード。

### Database: PostgreSQL

## ディレクトリ
```
├── apps
│ ├── backend     # golang/gin
│ ├── page_router # nextjs/page router
│ └── web         # nextjs/App router
└── packages
    ├── config-eslint
    ├── config-tailwind
    ├── config-typescript
    └── ui
```
