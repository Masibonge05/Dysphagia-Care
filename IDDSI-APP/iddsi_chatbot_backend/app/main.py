from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from app.api.gemini_routes import router as gemini_router
from app.core.config import settings
import logging
import time

# Configure logging
logging.basicConfig(
    level=getattr(logging, settings.LOG_LEVEL),
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

logger = logging.getLogger(__name__)


# Lifespan context manager for startup and shutdown
@asynccontextmanager
async def lifespan(app: FastAPI):
    """Handle application startup and shutdown"""
    # Startup
    logger.info(f"Starting {settings.APP_NAME} v{settings.APP_VERSION}")
    logger.info(f"Environment: {settings.ENVIRONMENT}")
    logger.info(f"Gemini Model: {settings.GEMINI_MODEL}")
    logger.info(f"CORS Origins: {settings.CORS_ORIGINS}")
    logger.info(f"Server running at http://localhost:8000")
    logger.info(f"API Documentation: http://localhost:8000/docs")
    
    yield
    
    # Shutdown
    logger.info("Shutting down application")


# Create FastAPI app with lifespan
app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    description="IDDSI Chatbot API with Gemini 2.5 Flash",
    docs_url="/docs",
    redoc_url="/redoc",
    lifespan=lifespan  # Add the lifespan parameter here
)

# CORS Middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],  # ensures OPTIONS allowed
    allow_headers=["*"],
)


# Request logging middleware
@app.middleware("http")
async def log_requests(request: Request, call_next):
    """Log all requests"""
    start_time = time.time()
    
    # Skip logging for health check endpoints
    if request.url.path not in ["/", "/health"]:
        logger.info(f"Request: {request.method} {request.url.path}")
    
    response = await call_next(request)
    
    process_time = time.time() - start_time
    
    # Skip logging for health check endpoints
    if request.url.path not in ["/", "/health"]:
        logger.info(
            f"Response: {response.status_code} - "
            f"Completed in {process_time:.2f}s"
        )
    
    return response


# Exception handlers
@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    """Global exception handler"""
    logger.error(f"Unhandled exception: {str(exc)}", exc_info=True)
    return JSONResponse(
        status_code=500,
        content={
            "error": "Internal server error",
            "detail": str(exc) if settings.ENVIRONMENT == "development" else "An error occurred"
        }
    )


# Include routers
app.include_router(gemini_router)


# Root endpoint
@app.get("/")
async def root():
    """Root endpoint"""
    return {
        "name": settings.APP_NAME,
        "version": settings.APP_VERSION,
        "status": "running",
        "docs": "/docs",
        "environment": settings.ENVIRONMENT
    }


# Health check endpoint
@app.get("/health")
async def health_check():
    """Health check endpoint"""
    return {
        "status": "healthy",
        "timestamp": time.time()
    }


# Run with uvicorn when executed directly
if __name__ == "__main__":
    import uvicorn
    
    # Get port from settings or default to 8000
    port = getattr(settings, 'PORT', 8000)
    host = getattr(settings, 'HOST', '0.0.0.0')
    
    logger.info(f"Starting server on {host}:{port}")
    
    uvicorn.run(
        "app.main:app",
        host=host,
        port=port,
        reload=settings.ENVIRONMENT == "development",
        log_level=settings.LOG_LEVEL.lower() if hasattr(settings.LOG_LEVEL, 'lower') else 'info'
    )