## Initialize New Full-Stack Project

### 1. Create Project Structure

```bash
mkdir frontend backend
```

### 2. Backend Setup (Python + FastAPI)

```bash
cd backend
uv init
uv add fastapi uvicorn python-dotenv pydantic sqlalchemy pytest
uv add --dev ruff isort mypy
```

Create basic structure:

```bash
mkdir -p src/{models,services,routes,utils} tests
touch src/__init__.py src/main.py src/models/__init__.py src/services/__init__.py src/routes/__init__.py src/utils/__init__.py
```

### 3. Frontend Setup (React + TypeScript)

```bash
cd ../frontend
bun create vite . --template react-ts
bun add @tanstack/react-router @tanstack/react-query react-hook-form zod phosphor-react date-fns
bun add -d @types/node
bunx shadcn-ui@latest init
```

Create structure:

```bash
mkdir -p src/{components/{ui,features},routes,lib,hooks,types}
```

### 4. Root Configuration Files

**Makefile**

```makefile
.PHONY: dev-backend dev-frontend dev install test

install:
	cd backend && uv sync
	cd frontend && bun install

dev-backend:
	cd backend && uv run uvicorn src.main:app --reload --port 8000

dev-frontend:
	cd frontend && bun run dev

dev:
	make dev-backend & make dev-frontend

test:
	cd backend && uv run pytest
	cd frontend && bun run test

build:
	cd backend && echo "Backend build ready"
	cd frontend && bun run build
```

**README.md**

````markdown
# Project Name

## Quick Start

```bash
make install  # Install dependencies
make dev      # Start both frontend and backend
```
````

## Development

- Backend: FastAPI server on http://localhost:8000
- Frontend: React app on http://localhost:5173
- API docs: http://localhost:8000/docs

## Commands

- `make dev` - Start development servers
- `make test` - Run all tests
- `make build` - Build for production

````

**.env.example**
```bash
# Backend
DATABASE_URL=sqlite:///./app.db
SECRET_KEY=your-secret-key-here
DEBUG=true
CORS_ORIGINS=http://localhost:5173

# Frontend
VITE_API_URL=http://localhost:8000
````

**.env**

```bash
# Copy from .env.example and fill in actual values
DATABASE_URL=sqlite:///./app.db
SECRET_KEY=super-secret-development-key
DEBUG=true
CORS_ORIGINS=http://localhost:5173
VITE_API_URL=http://localhost:8000
```

**.gitignore**

```
# Dependencies
node_modules/
__pycache__/
.venv/

# Environment
.env
.env.local

# Build outputs
dist/
build/
*.pyc

# IDE
.vscode/
.idea/

# OS
.DS_Store
Thumbs.db
```

### 5. Basic Starter Files

**backend/src/main.py**

```python
"""FastAPI application entry point."""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv
import os

load_dotenv()

app = FastAPI(title="Project API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=os.getenv("CORS_ORIGINS", "").split(","),
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {"message": "API is running"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}
```

**frontend/src/main.tsx** (update existing)

```typescript
import React from "react";
import ReactDOM from "react-dom/client";
import { RouterProvider, createRouter } from "@tanstack/react-router";
import { routeTree } from "./routeTree.gen";
import "./index.css";

const router = createRouter({ routeTree });

declare module "@tanstack/react-router" {
  interface Register {
    router: typeof router;
  }
}

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>
);
```

### 6. Final Steps

```bash
# Copy environment file
cp .env.example .env

# Install dependencies
make install

# Start development
make dev
```

Your project is now ready with both frontend and backend configured according to the guidelines.
