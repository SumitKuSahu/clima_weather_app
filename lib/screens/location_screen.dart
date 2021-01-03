import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({@required this.locationData});
  final locationData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temp;
  String name;
  String weatherIcon;
  String weathermessage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temp = 0;
        weatherIcon = 'Error';
        name = '';
        weathermessage = 'unable to access';
        return;
      }
      double temp1 = weatherData['main']['temp'];
      temp = temp1.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weathermessage = weatherModel.getMessage(temp);
      name = weatherData['name'];
    });
  }

  Future<bool> _onPressedback() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you want to exit'),
        actions: <Widget>[
          FlatButton(
            child: Text('N0'),
            onPressed: () => Navigator.pop(context, false),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPressedback,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var weather = await weatherModel.getLocationWeather();
                        updateUI(weather);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var cityname = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (cityname != null) {
                          var weatherdata = await weatherModel
                              .getLcocationbyCityName(cityname);
                          updateUI(weatherdata);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temp°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    '${weatherModel.getMessage(temp)} in $name',
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
