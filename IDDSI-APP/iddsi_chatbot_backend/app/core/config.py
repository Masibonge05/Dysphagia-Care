from pydantic import BaseSettings
from typing import List, Optional
import os
from dotenv import load_dotenv

load_dotenv()


class Settings(BaseSettings):
    """Application settings and configuration"""
    
    # Application
    APP_NAME: str = "IDDSI Chatbot API"
    APP_VERSION: str = "1.0.0"
    ENVIRONMENT: str = "development"
    
    # Server
    HOST: str = "0.0.0.0"
    PORT: int = 8000
    
    # Gemini API
    GEMINI_API_KEY: str
    GEMINI_MODEL: str = "gemini-2.0-flash-exp"
    MAX_TOKENS: int = 1024
    TEMPERATURE: float = 0.7
    TOP_P: float = 0.95
    TOP_K: int = 40
    
    # CORS
    CORS_ORIGINS: List[str] = [
        "http://localhost:3000",
        "http://localhost:8080",
        "http://127.0.0.1:3000",
        "http://127.0.0.1:8080",
    ]
    
    # Logging
    LOG_LEVEL: str = "INFO"
    
    # Rate Limiting
    MAX_REQUESTS_PER_MINUTE: int = 60
    
    # Session
    SESSION_TIMEOUT_MINUTES: int = 30
    
    class Config:
        env_file = ".env"
        case_sensitive = True


settings = Settings()