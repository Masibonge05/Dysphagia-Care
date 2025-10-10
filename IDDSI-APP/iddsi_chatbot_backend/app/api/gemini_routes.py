from fastapi import APIRouter, HTTPException, status
from app.models.chat_message import (
    ChatMessageRequest,
    ChatMessageResponse,
    HealthCheckResponse,
    ErrorResponse
)
from app.services.gemini_service import gemini_service
from app.core.config import settings
import logging
from datetime import datetime

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/api/gemini", tags=["Gemini Chat"])


@router.post(
    "/chat",
    response_model=ChatMessageResponse,
    responses={
        200: {"model": ChatMessageResponse},
        400: {"model": ErrorResponse},
        500: {"model": ErrorResponse}
    }
)
async def chat(request: ChatMessageRequest):
    """
    Main chat endpoint for IDDSI chatbot
    
    - **message**: User's message (required)
    - **language**: Language code (en, af, zu, xh, st, nso, tn, ss, ve, ts, nr)
    - **session_id**: Session ID for conversation context (required)
    
    Returns bot response in the specified language, restricted to IDDSI/dysphagia topics.
    """
    try:
        logger.info(
            f"Chat request - Session: {request.session_id}, "
            f"Language: {request.language}, "
            f"Message: {request.message[:50]}..."
        )
        
        # Validate language code
        valid_languages = ['en', 'af', 'zu', 'xh', 'st', 'nso', 'tn', 'ss', 've', 'ts', 'nr']
        if request.language not in valid_languages:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Invalid language code. Must be one of: {', '.join(valid_languages)}"
            )
        
        # Generate response
        response_text = await gemini_service.generate_response(
            message=request.message,
            language_code=request.language,
            session_id=request.session_id
        )
        
        return ChatMessageResponse(
            response=response_text,
            session_id=request.session_id,
            language=request.language,
            timestamp=datetime.now()
        )
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error in chat endpoint: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="An error occurred while processing your request"
        )


@router.get(
    "/health",
    response_model=HealthCheckResponse
)
async def health_check():
    """
    Health check endpoint
    
    Returns the API status and Gemini connection status
    """
    try:
        gemini_healthy = await gemini_service.check_health()
        
        return HealthCheckResponse(
            status="healthy" if gemini_healthy else "degraded",
            version=settings.APP_VERSION,
            gemini_status="connected" if gemini_healthy else "disconnected"
        )
    except Exception as e:
        logger.error(f"Health check error: {str(e)}")
        return HealthCheckResponse(
            status="unhealthy",
            version=settings.APP_VERSION,
            gemini_status="error"
        )


@router.delete("/session/{session_id}")
async def clear_session(session_id: str):
    """
    Clear session history
    
    - **session_id**: Session ID to clear
    """
    try:
        gemini_service.clear_session(session_id)
        return {"message": f"Session {session_id} cleared successfully"}
    except Exception as e:
        logger.error(f"Error clearing session: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to clear session"
        )