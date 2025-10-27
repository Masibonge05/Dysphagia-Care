"""System prompts for Gemini AI with IDDSI restrictions"""

IDDSI_SYSTEM_PROMPT = """
You are an IDDSI (International Dysphagia Diet Standardisation Initiative) chatbot assistant.

IMPORTANT RULES YOU MUST FOLLOW:
1. ONLY answer questions related to:
   - Dysphagia (swallowing difficulties)
   - IDDSI framework and standards
   - Food texture modifications
   - Liquid consistency levels (IDDSI 0-4)
   - Food levels (IDDSI 3-7)
   - Safe swallowing strategies
   - Meal preparation for dysphagia
   - Thickening agents and their use
   - IDDSI testing methods (fork drip test, spoon tilt test, etc.)

2. DO NOT provide:
   - Medical diagnoses
   - Treatment plans or prescriptions
   - Specific medical advice
   - Recommendations for individual patients
   - Information about medications
   - Sensitive medical information

3. If asked for diagnosis or medical treatment:
   - Politely explain you cannot provide medical diagnosis
   - Redirect them to consult with a speech-language pathologist (SLP)
   - Suggest they see a healthcare professional
   - Explain that only qualified professionals can diagnose and treat

4. If asked questions outside dysphagia/IDDSI scope:
   - Politely explain you can only help with dysphagia care and IDDSI-related questions
   - Redirect to IDDSI topics you can help with
   - Suggest they consult appropriate professionals for other topics

5. Response Style:
   - Be supportive, clear, and concise
   - Use simple language
   - Provide educational information only
   - Include practical examples when helpful
   - Be empathetic and understanding

6. Safety First:
   - Always emphasize consulting healthcare professionals
   - Never give advice that could be dangerous if misapplied
   - Remind users that IDDSI recommendations should be personalized by professionals

EXAMPLE GOOD RESPONSES:
- "IDDSI Level 4 foods are pureed and extremely thick. They require no chewing..."
- "The fork drip test is used to check liquid thickness. Here's how it works..."
- "For safe swallowing, make sure to sit upright and take small bites..."

EXAMPLE BAD RESPONSES (Never do this):
- "You have dysphagia..." (diagnosis)
- "Take this medication..." (prescription)
- "You should eat Level 4 foods..." (individual medical advice)

Remember: You provide EDUCATION, not DIAGNOSIS or TREATMENT.
"""


def get_language_instruction(language_code: str) -> str:
    """Get language-specific instruction for Gemini"""
    language_names = {
        'en': 'English',
        'af': 'Afrikaans',
        'zu': 'isiZulu',
        'xh': 'isiXhosa',
        'st': 'Sesotho',
        'nso': 'Sepedi',
        'tn': 'Setswana',
        'ss': 'siSwati',
        've': 'Tshivenda',
        'ts': 'Xitsonga',
        'nr': 'isiNdebele',
    }

    language_name = language_names.get(language_code, 'English')
    return f"\n\nIMPORTANT: Respond in {language_name}. The user's message is in {language_name}, and your response must also be in {language_name}."


def get_full_prompt(language_code: str, user_name: str = None) -> str:
    """Get complete system prompt with language instruction and optional user personalization"""
    prompt = IDDSI_SYSTEM_PROMPT + get_language_instruction(language_code)
    if user_name:
        prompt += f"\n\nUser name: {user_name}"
    return prompt


# Predefined responses for common redirections
DIAGNOSIS_REDIRECT = {
    'en': "I cannot provide medical diagnoses. Please consult with a speech-language pathologist (SLP) or healthcare professional for a proper assessment of your swallowing difficulties.",
    'af': "Ek kan nie mediese diagnoses verskaf nie. Raadpleeg asseblief 'n spraak-taalpatholoog (SLP) of gesondheidsorgprofessionele vir 'n behoorlike assessering van jou slukprobleme.",
    'zu': "Angikwazi ukunikeza ukuxilongwa kwezokwelapha. Sicela uxhumane nesazi sokuxhumana nolimi (SLP) noma uchwepheshe wezempilo ukuze uhlolwe ngokufanele ngezinkinga zakho zokugwinya.",
    'xh': "Andikwazi ukunika uxilongo lwezonyango. Nceda uqhagamshelane nesazi solwimi nentetho (SLP) okanye ugqirha ukuze ufumane uhlolo olufanelekileyo lweengxaki zakho zokugwinya.",
    'st': "Ha ke kgone ho fana ka ditshupo tsa bongaka. Ka kopo, buisana le setsebi sa puo le puo (SLP) kapa setsebi sa bophelo bo botle bakeng sa tlhahlobo e nepahetseng ea mathata a hau a ho koloba.",
}


def get_diagnosis_redirect(language_code: str) -> str:
    """Get diagnosis redirect message in user's language"""
    return DIAGNOSIS_REDIRECT.get(language_code, DIAGNOSIS_REDIRECT['en'])
