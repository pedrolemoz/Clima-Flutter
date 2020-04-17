import 'package:clima/services/weather_data.dart';
import 'package:clima/utilities/capitalize.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/utilities/current_time.dart';
import 'package:clima/widgets/refresh_button.dart';
import 'package:flutter/material.dart';

class WeatherInformation extends StatefulWidget {
  WeatherInformation({this.weatherData});

  final weatherData;

  @override
  _WeatherInformationState createState() => _WeatherInformationState();
}

class _WeatherInformationState extends State<WeatherInformation> {
  double temperature;
  double feelsLike;
  String cityName;
  String description;

  @override
  void initState() {
    super.initState();
    updateData(widget.weatherData);
  }

  void updateData(var weatherData) {
    setState(() {
      temperature = weatherData['main']['temp'];
      cityName = weatherData['name'];
      feelsLike = weatherData['main']['feels_like'];
      description = weatherData['weather'][0]['description'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            getCurrentDateTime(),
                            style: kRegularTextStyle.copyWith(
                              fontSize: 20.0,
                              color: kSecondaryFontColor,
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            cityName,
                            style: kExtraBoldTextStyle.copyWith(
                              fontSize: 20.0,
                              color: kPrimaryFontColor,
                            ),
                          ),
                        ],
                      ),
                      RefreshButton(onPress: () {
                        var weatherData = WeatherData().getLocationData();
                        updateData(weatherData);
                      }),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${temperature.round()}º',
                        style: kExtraBoldTextStyle.copyWith(
                          fontSize: 80.0,
                          color: kPrimaryFontColor,
                        ),
                      ),
                      Text(
                        capitalize(description),
                        style: kRegularTextStyle.copyWith(
                          fontSize: 45.0,
                          color: kPrimaryFontColor,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'Feels like ${feelsLike.round()}º',
                        style: kRegularTextStyle.copyWith(
                          fontSize: 20.0,
                          color: kSecondaryFontColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
