def chatbot_reply(question):

    q = question.lower()

    if "rice" in q:
        return "Rice disease may be due to fungus. Remove infected leaves and apply fungicide."

    elif "fertilizer" in q:
        return "Use balanced NPK fertilizer depending on crop stage."

    elif "pest" in q:
        return "Use neem oil spray or approved pesticide."

    else:
        return "Please monitor crop condition and consult agriculture expert if needed."