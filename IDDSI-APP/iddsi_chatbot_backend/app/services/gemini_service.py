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
        logger.info(f"Gemini service initialized with model: {settings.GEMINI_MODEL}")
    
    def _get_session_history(self, session_id: str) -> List[Dict]:
        """Get conversation history for a session"""
        if session_id not in self.sessions:
            self.sessions[session_id] = []
        return self.sessions[session_id]
    
    def _add_to_history(self, session_id: str, role: str, content: str):
        """Add message to session history"""
        self.sessions[session_id].append({
            "role": role,
            "content": content
        })
        
        # Keep only last 10 messages to manage context
        if len(self.sessions[session_id]) > 10:
            self.sessions[session_id] = self.sessions[session_id][-10:]
    
    def _build_context(self, session_id: str, system_prompt: str) -> str:
        """Build conversation context with history"""
        history = self._get_session_history(session_id)
        
        context = system_prompt + "\n\nConversation History:\n"
        
        for msg in history[-5:]:  # Include last 5 messages
            role = "User" if msg["role"] == "user" else "Assistant"
            context += f"{role}: {msg['content']}\n"
        
        return context
    
    def _is_medical_diagnosis_request(self, message: str) -> bool:
        """Check if message is requesting medical diagnosis"""
        diagnosis_keywords = [
            'diagnose', 'diagnosis', 'do i have', 'am i suffering',
            'what\'s wrong with me', 'what disease', 'what condition',
            'am i sick', 'is it serious', 'should i be worried'
        ]
        
        message_lower = message.lower()
        return any(keyword in message_lower for keyword in diagnosis_keywords)
    
    def _is_off_topic(self, message: str) -> bool:
        """Check if message is off-topic (not IDDSI/dysphagia related)"""
        iddsi_keywords = [
            'iddsi', 'dysphagia', 'swallow', 'texture', 'thickness',
            'puree', 'minced', 'soft', 'liquid', 'consistency',
            'chew', 'food', 'drink', 'thicken', 'level'
        ]
        
        message_lower = message.lower()
        
        # Check if any IDDSI keyword is present
        has_iddsi_keyword = any(keyword in message_lower for keyword in iddsi_keywords)
        
        # If no IDDSI keywords and message is not a greeting
        greeting_keywords = ['hello', 'hi', 'hey', 'good morning', 'how are you']
        is_greeting = any(greeting in message_lower for greeting in greeting_keywords)
        
        return not has_iddsi_keyword and not is_greeting
    
    async def generate_response(
        self,
        message: str,
        language_code: str = "en",
        session_id: Optional[str] = None
    ) -> str:
        """
        Generate response from Gemini with IDDSI restrictions
        
        Args:
            message: User message
            language_code: Language code for response
            session_id: Session ID for context
            
        Returns:
            Generated response text
        """
        try:
            # Check for diagnosis requests
            if self._is_medical_diagnosis_request(message):
                logger.warning(f"Diagnosis request detected: {message[:50]}...")
                return get_diagnosis_redirect(language_code)
            
            # Check if off-topic
            if self._is_off_topic(message):
                off_topic_responses = {
                    'en': "I can only help with questions about dysphagia care and IDDSI standards. Please ask me about IDDSI levels, food textures, liquid consistencies, or safe swallowing strategies.",
                    'af': "Ek kan slegs help met vrae oor disfagie-sorg en IDDSI-standaarde. Vra my asseblief oor IDDSI-vlakke, voedsel teksture, vloeistof konsekwentheid, of veilige sluk strategieë.",
                    'zu': "Ngingakusiza kuphela ngemibuzo mayelana nokunakekelwa kwe-dysphagia kanye nezindinganiso ze-IDDSI. Sicela ungibuze ngamazinga e-IDDSI, ukwakheka kokudla, ukuqina koketshezi, noma amasu okugwinya okuphephile.",
                }
                return off_topic_responses.get(language_code, off_topic_responses['en'])
            
            # Get system prompt with language instruction
            system_prompt = get_full_prompt(language_code)
            
            # Build context with history if session exists
            if session_id:
                full_prompt = self._build_context(session_id, system_prompt)
                full_prompt += f"\n\nUser: {message}\nAssistant:"
            else:
                full_prompt = f"{system_prompt}\n\nUser: {message}\nAssistant:"
            
            # Generate response from Gemini
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
            
            # Add to session history
            if session_id:
                self._add_to_history(session_id, "user", message)
                self._add_to_history(session_id, "assistant", response_text)
            
            logger.info(f"Response generated for session {session_id}, language: {language_code}")
            return response_text
            
        except Exception as e:
            logger.error(f"Error generating response: {str(e)}")
            
            error_messages = {
                'en': "Sorry, I encountered an error processing your request. Please try again.",
                'af': "Jammer, ek het 'n fout teëgekom terwyl ek jou versoek verwerk. Probeer asseblief weer.",
                'zu': "Uxolo, ngihlangabezane nephutha ngenkathi ngiqhubeka nesicelo sakho. Sicela uzame futhi.",
            }
            return error_messages.get(language_code, error_messages['en'])
    
    async def check_health(self) -> bool:
        """Check if Gemini API is accessible"""
        try:
            # Simple test request
            response = self.model.generate_content("Hello")
            return bool(response.text)
        except Exception as e:
            logger.error(f"Gemini health check failed: {str(e)}")
            return False
    
    def clear_session(self, session_id: str):
        """Clear session history"""
        if session_id in self.sessions:
            del self.sessions[session_id]
            logger.info(f"Session {session_id} cleared")


# Singleton instance
gemini_service = GeminiService()