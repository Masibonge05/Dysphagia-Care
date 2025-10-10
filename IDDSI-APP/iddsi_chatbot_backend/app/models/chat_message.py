from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime


class ChatMessageRequest(BaseModel):
    """Request model for chat messages"""
    message: str = Field(..., min_length=1, max_length=2000, description="User message")
    language: str = Field(default="en", description="Language code (en, af, zu, etc.)")
    session_id: str = Field(..., description="Session ID for conversation tracking")
    
    class Config:
        json_schema_extra = {
            "example": {
                "message": "What is IDDSI level 4?",
                "language": "en",
                "session_id": "1705320000000"
            }
        }


class ChatMessageResponse(BaseModel):
    """Response model for chat messages"""
    response: str = Field(..., description="Bot response message")
    session_id: str = Field(..., description="Session ID")
    language: str = Field(..., description="Response language code")
    timestamp: datetime = Field(default_factory=datetime.now, description="Response timestamp")
    
    class Config:
        json_schema_extra = {
            "example": {
                "response": "IDDSI Level 4 is pureed food...",
                "session_id": "1705320000000",
                "language": "en",
                "timestamp": "2025-01-15T10:30:00"
            }
        }


class HealthCheckResponse(BaseModel):
    """Health check response model"""
    status: str = Field(..., description="API status")
    version: str = Field(..., description="API version")
    gemini_status: str = Field(..., description="Gemini API connection status")
    
    class Config:
        json_schema_extra = {
            "example": {
                "status": "healthy",
                "version": "1.0.0",
                "gemini_status": "connected"
            }
        }


class ErrorResponse(BaseModel):
    """Error response model"""
    error: str = Field(..., description="Error message")
    detail: Optional[str] = Field(None, description="Detailed error information")
    timestamp: datetime = Field(default_factory=datetime.now, description="Error timestamp")
    
    class Config:
        json_schema_extra = {
            "example": {
                "error": "Invalid request",
                "detail": "Message cannot be empty",
                "timestamp": "2025-01-15T10:30:00"
            }
        }