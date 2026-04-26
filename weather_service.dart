import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  // Get your free API key from openweathermap.org
  static const String _apiKey = 'YOUR_OPENWEATHER_API_KEY';

  Future<Map<String, dynamic>> getWeather(String city) async {
    try {
      final url =
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'city': data['name'],
          'temperature': data['main']['temp'].toString(),
          'humidity': data['main']['humidity'].toString(),
          'wind_speed': data['wind']['speed'].toString(),
          'description': data['weather'][0]['description'],
          'icon': data['weather'][0]['icon'],
          'feels_like': data['main']['feels_like'].toString(),
        };
      }
    } catch (e) {
      print('Weather error: $e');
    }
    return {'error': 'Could not fetch weather'};
  }

  String getFarmingTip(Map<String, dynamic> weather) {
    if (weather.containsKey('error')) return '';
    final humidity = double.tryParse(weather['humidity'] ?? '0') ?? 0;
    final temp = double.tryParse(weather['temperature'] ?? '0') ?? 0;

    if (humidity > 80) {
      return 'High humidity today. Watch out for fungal diseases on your crops.';
    } else if (temp > 35) {
      return 'Very hot today. Water your crops in the early morning or evening.';
    } else if (temp < 15) {
      return 'Cold weather. Protect sensitive crops from frost damage.';
    }
    return 'Good weather for farming. Ideal conditions for crop growth.';
  }
}
