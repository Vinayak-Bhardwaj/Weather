import 'package:flutter/material.dart';

class WeatherResponse{
  String main,description;
  int sunrise,sunset,humidity;
  double temperature,feels_like,temp_min,temp_max;

  WeatherResponse({this.main,this.description,this.temperature,this.feels_like,this.temp_min,this.temp_max,this.humidity,this.sunrise,this.sunset});

  factory WeatherResponse.fromJSON(Map<String, dynamic> json) {
    return WeatherResponse(
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'] - 273,
      feels_like: json['main']['feels_like'] - 273,
      temp_min: json['main']['temp_min'] - 273,
      temp_max: json['main']['temp_max'] - 273,
      humidity: json['main']['humidity'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
    );
  }

}