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
    
    def _set_session_user_name(self, session_id: str, user_name: str):
        """Store user name for a session"""
        if user_name and user_name.strip():
            self.session_user_names[session_id] = user_name.strip()
    
    def _get_session_user_name(self, session_id: str) -> Optional[str]:
        """Get user name for a session"""
        return self.session_user_names.get(session_id)
    
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
        session_id: Optional[str] = None,
        user_name: Optional[str] = None
    ) -> str:
        """
        Generate response from Gemini with IDDSI restrictions
        
        Args:
            message: User message
            language_code: Language code for response
            session_id: Session ID for context
            user_name: User's name for personalization
            
        Returns:
            Generated response text
        """
        try:
            # Store user name for this session if provided
            if session_id and user_name:
                self._set_session_user_name(session_id, user_name)
            
            # Get user name from session if not provided but exists in session
            if session_id and not user_name:
                user_name = self._get_session_user_name(session_id)
            
            # Check for diagnosis requests
            if self._is_medical_diagnosis_request(message):
                logger.warning(f"Diagnosis request detected: {message[:50]}...")
                return get_diagnosis_redirect(language_code, user_name)
            
            # Check if off-topic
            if self._is_off_topic(message):
                off_topic_responses = {
                    'en': "I can only help with questions about dysphagia care and IDDSI standards. Please ask me about IDDSI levels, food textures, liquid consistencies, or safe swallowing strategies.",
                    'af': "Ek kan slegs help met vrae oor disfagie-sorg en IDDSI-standaarde. Vra my asseblief oor IDDSI-vlakke, voedsel teksture, vloeistof konsekwentheid, of veilige sluk strategieë.",
                    'zu': "Ngingakusiza kuphela ngemibuzo mayelana nokunakekelwa kwe-dysphagia kanye nezindinganiso ze-IDDSI. Sicela ungibuze ngamazinga e-IDDSI, ukwakheka kokudla, ukuqina koketshezi, noma amasu okugwinya okuphephile.",
                    'xh': "Ndingakunceda kuphela ngemibuzo emalunga nokhathalelo lwe-dysphagia kunye nemigangatho ye-IDDSI. Nceda undibuze ngamanqanaba e-IDDSI, ukwakheka kokutya, ukuqina kolwelo, okanye izicwangciso zokugwinya ezikhuselekileyo.",
                    'st': "Ke ka u thusa feela ka lipotso mabapi le tlhokomelo ea dysphagia le maemo a IDDSI. Ka kopo mpotse ka maemo a IDDSI, sebopeho sa lijo, ho kuta ha metsi, kapa mekhoa e bolokehileng ea ho koloba.",
                    'nso': "Nka go thuša fela ka dipotšišo tša go ela ga dysphagia le maemo a IDDSI. Hle mpotšiše ka maemo a IDDSI, sebopego sa dijo, go tia ga meetse, goba mekgwa ya go kela ye e bolokegago.",
                    'tn': "Nka go thusa fela ka dipotso tsa tlhokomelo ya dysphagia le maemo a IDDSI. Tsweetswee mpotse ka maemo a IDDSI, sebopego sa dijo, go tiisa ga metsi, kgotsa mekgwa e e babalesegileng ya go metela.",
                    'ss': "Ngingakusita kuphela ngemibuto mayelana nekuphatsa kwe-dysphagia kanye netindzaba te-IDDSI. Sicela ungibutse ngetinhloko te-IDDSI, kubunjwa kwekudla, kucinana kwemanti, noma tindlela tekugwinya letiphepha.",
                    've': "Ndi nga ni thusa fhedzi nga mbudziso dza ndzhena dza dysphagia na zwiga zwa IDDSI. Ni humbela u mpfunza nga zwiimo zwa IDDSI, muvhumbeo wa zwiliwa, u tiya ha maḓi, kana zwiga zwa u gulula zwo teaho.",
                    'ts': "Ndzi nga mi pfuna ntsena hi swivutiso swa vuhlayiseki bya dysphagia na swiyimo swa IDDSI. Kombela mi ndzi vutisa hi swiyimo swa IDDSI, ku akiwa ka swakudya, ku tiya ka mati, kumbe tindlela ta ku khotsa leti hlayisekaka.",
                    'nr': "Ngingalikusiza kuphela ngeemibuto elimayelana nokuphatjwa kwe-dysphagia kanye namatjheja we-IDDSI. Sicela ungibutje ngemikhakha ye-IDDSI, ukubunjwa kwekudla, ukutjhina kwamanzi, kumbe tindlela tekugwinya letiphepha.",
                }
                
                response = off_topic_responses.get(language_code, off_topic_responses['en'])
                
                # Personalize if user name is available
                if user_name:
                    response = f"{user_name}, {response}"
                
                return response
            
            # Get system prompt with language instruction and personalization
            system_prompt = get_full_prompt(language_code, user_name)
            
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
            
            logger.info(f"Response generated for session {session_id}, language: {language_code}, user: {user_name or 'anonymous'}")
            return response_text
            
        except Exception as e:
            logger.error(f"Error generating response: {str(e)}")
            
            error_messages = {
                'en': "Sorry, I encountered an error processing your request. Please try again.",
                'af': "Jammer, ek het 'n fout teëgekom terwyl ek jou versoek verwerk. Probeer asseblief weer.",
                'zu': "Uxolo, ngihlangabezane nephutha ngenkathi ngiqhubeka nesicelo sakho. Sicela uzame futhi.",
                'xh': "Uxolo, ndifumene impazamo xa ndiququzelela isicelo sakho. Nceda uzame kwakhona.",
                'st': "Tšoarelo, ke ile ka kopana le phoso ha ke sebetsana le kopo ea hau. Ka kopo leka hape.",
                'nso': "Maswabi, ke kopane le phošo ge ke swara kgopelo ya gago. Hle leka gape.",
                'tn': "Tshwarelo, ke kopane le phoso fa ke dira kopo ya gago. Tsweetswee leka gape.",
                'ss': "Uxolo, ngihlangene nekhukhuleka ngesikhati ngilungisa sicelo sakho. Sicela uzame futsi.",
                've': "Ri livhuwa, ndo ṱangana na vhusiwana hu tshi khou ita khumbelo yanu. Ni humbela u lingedza hafhu.",
                'ts': "Ku rivaleli, ndzi hlanganile ni xihoxo loko ndzi endlaka xikombelo xa n'wina. Kombela mi ringeta nakambe.",
                'nr': "Uxolo, ngihlangene nebanga nangesikhathi ngilungisa isicelo sakho. Sicela uzame godu.",
            }
            
            error_response = error_messages.get(language_code, error_messages['en'])
            
            # Personalize error message if user name is available
            if user_name:
                error_response = f"{user_name}, {error_response.lower()}"
            
            return error_response
    
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
        
        # Also clear user name
        if session_id in self.session_user_names:
            del self.session_user_names[session_id]


# Singleton instance
gemini_service = GeminiService()