from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from app.api.gemini_routes import router as gemini_router
from app.core.config import settings
import logging
import os
import time

# -----------------------------
# Configure logging
# -----------------------------
logging.basicConfig(
    level=getattr(logging, settings.LOG_LEVEL, "INFO"),
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s"
)
logger = logging.getLogger(__name__)

# -----------------------------
# Lifespan context manager
# -----------------------------
@asynccontextmanager
async def lifespan(app: FastAPI):
    """Handle startup and shutdown tasks"""
    logger.info(f"Starting {settings.APP_NAME} v{settings.APP_VERSION}")
    logger.info(f"Environment: {settings.ENVIRONMENT}")
    logger.info(f"Gemini Model: {settings.GEMINI_MODEL}")
    logger.info(f"CORS Origins: {settings.CORS_ORIGINS}")

    yield
    logger.info("Shutting down application")

# -----------------------------
# Initialize FastAPI app
# -----------------------------
app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    description="IDDSI Chatbot API with Gemini 2.5 Flash",
    docs_url="/docs",
    redoc_url="/redoc",
    lifespan=lifespan
)

# -----------------------------
# CORS middleware
# -----------------------------
# Allow Flutter web / mobile client
allowed_origins = [
    "https://dysphagia-care.onrender.com",
    "http://localhost:3000",  # local dev
    "*",  # optional, allow all for testing
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_credentials=True,
    allow_methods=["*"],  # OPTIONS, GET, POST, etc.
    allow_headers=["*"],
)

# -----------------------------
# Request logging middleware
# -----------------------------
@app.middleware("http")
async def log_requests(request: Request, call_next):
    start_time = time.time()

    if request.url.path not in ["/", "/health"]:
        logger.info(f"Request: {request.method} {request.url.path}")

    response = await call_next(request)

    process_time = time.time() - start_time
    if request.url.path not in ["/", "/health"]:
        logger.info(f"Response: {response.status_code} - Completed in {process_time:.2f}s")

    return response

# -----------------------------
# Global exception handler
# -----------------------------
@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    logger.error(f"Unhandled exception: {str(exc)}", exc_info=True)
    return JSONResponse(
        status_code=500,
        content={
            "error": "Internal server error",
            "detail": str(exc) if settings.ENVIRONMENT == "development" else "An error occurred"
        }
    )

# -----------------------------
# Include API routers
# -----------------------------
app.include_router(gemini_router)

# -----------------------------
# Root endpoint
# -----------------------------
@app.get("/")
async def root():
    return {
        "name": settings.APP_NAME,
        "version": settings.APP_VERSION,
        "status": "running",
        "docs": "/docs",
        "environment": settings.ENVIRONMENT
    }

# -----------------------------
# Health check endpoint
# -----------------------------
@app.get("/health")
async def health_check():
    return {
        "status": "healthy",
        "timestamp": time.time()
    }

# -----------------------------
# Run app using uvicorn
# -----------------------------
if __name__ == "__main__":
    import uvicorn

    # Render sets the PORT env variable dynamically
    port = int(os.environ.get("PORT", 8000))
    host = "0.0.0.0"

    logger.info(f"Starting server on {host}:{port}")

    uvicorn.run(
        "app.main:app",
        host=host,
        port=port,
        reload=settings.ENVIRONMENT == "development",
        log_level=settings.LOG_LEVEL.lower() if hasattr(settings.LOG_LEVEL, "lower") else "info"
    )
