# Homebrew (Backend)

## Overview

A simple Node.js + TypeScript + Express backend with PostgreSQL and Prisma ORM.

## Prerequisites

- **Node.js** ≥ 18 & **npm**
- **Docker** & **Docker Compose** (for PostgreSQL)
- **Git** (optional)

## Installation

1. Clone the repo

   ```bash
   git clone https://github.com/farxmai/homebrew-back.git
   cd homebrew-back
   ```

2. Install dependencies
   ```bash
   npm install
   ```

## Environment Variables

Create a file named `.env` in the project root with these values:

```dotenv
# PostgreSQL (for Prisma)
DATABASE_URL="postgresql://myuser:mypassword@localhost:5432/homebrewDB?schema=public"

# (Optional) if your code reads these separately
DB_HOST=localhost
DB_PORT=5432
DB_NAME=homebrewDB
DB_USER=myuser
DB_PASS=mypassword

# Express server port
PORT=3001
```

## Database Setup

Start PostgreSQL via Docker Compose:

```bash
docker-compose up -d
```

Verify it’s running:

```bash
docker-compose ps
```

## Prisma

1. Initialize (already done if you ran `prisma init`):

   ```bash
   npx prisma init
   ```

2. Apply migrations & generate client:

   ```bash
   npx prisma migrate dev --name init
   npx prisma generate
   ```

3. (Optional) Open Prisma Studio:
   ```bash
   npx prisma studio
   ```

## Running the Server

- **Development** (with auto-reload):

  ```bash
  npm run dev
  ```

- **Production**:
  ```bash
  npm run build
  npm start
  ```

## Available Scripts

- `npm run dev` – start in development mode (ts-node + nodemon)
- `npm run build` – compile TypeScript to `dist/`
- `npm start` – run the compiled app
- `npm run prisma:migrate` – create/apply migrations
- `npm run prisma:generate` – regenerate Prisma client
- `npm run prisma:studio` – open Prisma Studio GUI

## Project Structure

```
homebrew-back/
├─ prisma/
│  └─ schema.prisma
├─ src/
│  ├─ index.ts
│  ├─ prisma.ts
│  └─ routes/
│     ├─ users.ts
│     └─ characters.ts
│     ...
├─ .env
├─ docker-compose.yml
└─ package.json
```

## License

MIT © Farxmai
