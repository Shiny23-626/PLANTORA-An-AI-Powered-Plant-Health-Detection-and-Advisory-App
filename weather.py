import requests

API_KEY="YOUR_API_KEY"

def get_weather(city):

    url=f"http://api.openweathermap.org/data/2.5/weather?q={city}&appid={API_KEY}&units=metric"

    r=requests.get(url).json()

    return {
        "temp":r["main"]["temp"],
        "humidity":r["main"]["humidity"],
        "wind":r["wind"]["speed"]
    }