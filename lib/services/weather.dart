import 'package:flutter_dotenv/flutter_dotenv.dart';

// services
import '../services/location.dart';
import '../services/networking.dart';

const String OPEN_WEATHER_MAP_URL =
    'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  String requestBasedUrl =
      '$OPEN_WEATHER_MAP_URL?appid=${DotEnv().env["api_key"]}&units=metric';

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    String url =
        '$requestBasedUrl&lat=${location.latitude}&lon=${location.longitude}';
    NetworkHelper networkHelper = NetworkHelper(url);

    return await networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    //  https://openweathermap.org/weather-conditions

    if (condition == null) {
      return 'Error';
    }

    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp == null) {
      return 'Unable to get weather data';
    }

    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
