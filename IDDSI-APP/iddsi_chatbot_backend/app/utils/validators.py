"""Input validation utilities"""
import re
from typing import Optional


VALID_LANGUAGE_CODES = ['en', 'af', 'zu', 'xh', 'st', 'nso', 'tn', 'ss', 've', 'ts', 'nr']


def validate_language_code(language_code: str) -> bool:
    """
    Validate language code
    
    Args:
        language_code: Language code to validate
        
    Returns:
        True if valid, False otherwise
    """
    return language_code in VALID_LANGUAGE_CODES


def sanitize_message(message: str) -> str:
    """
    Sanitize user message
    
    Args:
        message: Raw message from user
        
    Returns:
        Sanitized message
    """
    # Remove excessive whitespace
    message = ' '.join(message.split())
    
    # Remove potentially harmful characters
    message = re.sub(r'[<>]', '', message)
    
    return message.strip()


def validate_session_id(session_id: str) -> bool:
    """
    Validate session ID format
    
    Args:
        session_id: Session ID to validate
        
    Returns:
        True if valid, False otherwise
    """
    # Session ID should be alphanumeric and reasonable length
    if not session_id:
        return False
    
    if len(session_id) > 100:
        return False
    
    # Allow alphanumeric, hyphens, and underscores
    return bool(re.match(r'^[a-zA-Z0-9_-]+$', session_id))


def validate_message_length(message: str, min_length: int = 1, max_length: int = 2000) -> bool:
    """
    Validate message length
    
    Args:
        message: Message to validate
        min_length: Minimum length
        max_length: Maximum length
        
    Returns:
        True if valid, False otherwise
    """
    return min_length <= len(message) <= max_length