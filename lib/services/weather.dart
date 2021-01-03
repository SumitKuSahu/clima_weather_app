import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
const apikey = '2a03800efac7383590802a1b961d0344';
 const openweatherurl='https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {
Future<dynamic>getLcocationbyCityName(String cityname)async
{
var url='$openweatherurl?q=$cityname&appid=$apikey&units=metric';
NetworkingData networkingData=NetworkingData(url);
var weatherData=await networkingData.getApi();
return weatherData;
}


  Future<dynamic> getLocationWeather()
  async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkingData networkingData = NetworkingData(
        '$openweatherurl?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');
    var weatherData = await networkingData.getApi();
return weatherData;

  }

  String getWeatherIcon(int condition) {
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
