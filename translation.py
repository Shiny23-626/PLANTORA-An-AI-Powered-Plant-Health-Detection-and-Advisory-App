from googletrans import Translator

translator = Translator()

def translate_text(text,lang):

    result = translator.translate(text,dest=lang)

    return result.text