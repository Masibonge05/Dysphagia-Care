import google.generativeai as genai
from typing import Optional, Dict, List
from app.core.config import settings
from app.core.prompts import get_full_prompt, get_diagnosis_redirect
import logging

logger = logging.getLogger(__name__)


class GeminiService:
    """Service for interacting with Gemini API"""
    
    def __init__(self):
        """Initialize Gemini API"""
        genai.configure(api_key=settings.GEMINI_API_KEY)
        self.model = genai.GenerativeModel(settings.GEMINI_MODEL)
        self.sessions: Dict[str, List[Dict]] = {}
        self.session_user_names: Dict[str, str] = {}  # Store user names per session
        logger.info(f"Gemini service initialized with model: {settings.GEMINI_MODEL}")
    
    def _get_session_history(self, session_id: str) -> List[Dict]:
        if session_id not in self.sessions:
            self.sessions[session_id] = []
        return self.sessions[session_id]
    
    def _add_to_history(self, session_id: str, role: str, content: str):
        self.sessions[session_id].append({"role": role, "content": content})
        if len(self.sessions[session_id]) > 10:
            self.sessions[session_id] = self.sessions[session_id][-10:]
    
    def _set_session_user_name(self, session_id: str, user_name: str):
        if user_name and user_name.strip():
            self.session_user_names[session_id] = user_name.strip()
    
    def _get_session_user_name(self, session_id: str) -> Optional[str]:
        return self.session_user_names.get(session_id)
    
    def _build_context(self, session_id: str, system_prompt: str) -> str:
        history = self._get_session_history(session_id)
        context = system_prompt + "\n\nConversation History:\n"
        for msg in history[-5:]:
            role = "User" if msg["role"] == "user" else "Assistant"
            context += f"{role}: {msg['content']}\n"
        return context
    
    def _is_medical_diagnosis_request(self, message: str) -> bool:
        diagnosis_keywords = [
            'diagnose', 'diagnosis', 'do i have', 'am i suffering',
            'what\'s wrong with me', 'what disease', 'what condition',
            'am i sick', 'is it serious', 'should i be worried'
        ]
        return any(keyword in message.lower() for keyword in diagnosis_keywords)
    
    def _is_off_topic(self, message: str) -> bool:
        iddsi_keywords = [
            'iddsi', 'dysphagia', 'swallow', 'texture', 'thickness',
            'puree', 'minced', 'soft', 'liquid', 'consistency',
            'chew', 'food', 'drink', 'thicken', 'level'
        ]
        greeting_keywords = ['hello', 'hi', 'hey', 'good morning', 'how are you']
        message_lower = message.lower()
        has_iddsi_keyword = any(keyword in message_lower for keyword in iddsi_keywords)
        is_greeting = any(greeting in message_lower for greeting in greeting_keywords)
        return not has_iddsi_keyword and not is_greeting
    
    async def generate_response(
        self,
        message: str,
        language_code: str = "en",
        session_id: Optional[str] = None,
        user_name: Optional[str] = None
    ) -> str:
        try:
            if session_id and user_name:
                self._set_session_user_name(session_id, user_name)
            if session_id and not user_name:
                user_name = self._get_session_user_name(session_id)
            
            if self._is_medical_diagnosis_request(message):
                logger.warning(f"Diagnosis request detected: {message[:50]}...")
                return get_diagnosis_redirect(language_code, user_name)
            
            if self._is_off_topic(message):
                off_topic_responses = {
                    'en': "I can only help with questions about dysphagia care and IDDSI standards. Please ask me about IDDSI levels, food textures, liquid consistencies, or safe swallowing strategies.",
                    'af': "Ek kan slegs help met vrae oor disfagie-sorg en IDDSI-standaarde. Vra my asseblief oor IDDSI-vlakke, voedsel teksture, vloeistof konsekwentheid, of veilige sluk strategieë.",
                    # Add other languages here...
                }
                response = off_topic_responses.get(language_code, off_topic_responses['en'])
                if user_name:
                    response = f"{user_name}, {response}"
                return response
            
            # FIXED: Call get_full_prompt with both language_code and user_name
            system_prompt = get_full_prompt(language_code=language_code, user_name=user_name)
            
            if session_id:
                full_prompt = self._build_context(session_id, system_prompt)
                full_prompt += f"\n\nUser: {message}\nAssistant:"
            else:
                full_prompt = f"{system_prompt}\n\nUser: {message}\nAssistant:"
            
            response = self.model.generate_content(
                full_prompt,
                generation_config=genai.types.GenerationConfig(
                    max_output_tokens=settings.MAX_TOKENS,
                    temperature=settings.TEMPERATURE,
                    top_p=settings.TOP_P,
                    top_k=settings.TOP_K,
                )
            )
            
            response_text = response.text.strip()
            
            if session_id:
                self._add_to_history(session_id, "user", message)
                self._add_to_history(session_id, "assistant", response_text)
            
            logger.info(f"Response generated for session {session_id}, language: {language_code}, user: {user_name or 'anonymous'}")
            return response_text
            
        except Exception as e:
            logger.error(f"Error generating response: {str(e)}")
            error_messages = {
                'en': "Sorry, I encountered an error processing your request. Please try again.",
            }
            error_response = error_messages.get(language_code, error_messages['en'])
            if user_name:
                error_response = f"{user_name}, {error_response.lower()}"
            return error_response
    
    async def check_health(self) -> bool:
        try:
            response = self.model.generate_content("Hello")
            return bool(response.text)
        except Exception as e:
            logger.error(f"Gemini health check failed: {str(e)}")
            return False
    
    def clear_session(self, session_id: str):
        if session_id in self.sessions:
            del self.sessions[session_id]
            logger.info(f"Session {session_id} cleared")
        if session_id in self.session_user_names:
            del self.session_user_names[session_id]


# Singleton instance
gemini_service = GeminiService()
