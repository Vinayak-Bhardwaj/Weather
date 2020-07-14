import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/information.dart';
import 'package:weather/WeatherResponse.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const API_KEY = '728c16fd6658cfc073d9fdf63b04acb9';

class list extends StatefulWidget {
  @override
  _listState createState() => _listState();
}

class _listState extends State<list> {

  WeatherResponse weather_response;
  getWeatherData(String city) async {
    final response = await http.get('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$API_KEY');

    if(response.statusCode == 200) {
      setState(() {
        weather_response = WeatherResponse.fromJSON(jsonDecode(response.body));
      });
    }else{
      throw Exception('Failed to load weather data');
    }

  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }



  @override
  Widget build(BuildContext context) {

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    double width = queryData.size.width;
    double height = queryData.size.height;
    var size = queryData.size;
    print(width);
    print(height);
    print(size);

    final information = Provider.of<Information>(context);

    return information == null ? CircularProgressIndicator() : Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: height/82.06,bottom: 0),
      margin: EdgeInsets.only(top: height/82.06,left: width/20.57,right: width/20.57),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[


          Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                  text: TextSpan(
                      text: 'Name : ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: height/54.70
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${information.name}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                        )
                      ]
                  )
              )
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                  text: TextSpan(
                      text: 'Email Id : ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: height/54.70
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${information.email}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                        )
                      ]
                  )
              )
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                  text: TextSpan(
                      text: 'Phone Number : ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: height/54.70
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${information.phone}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                        )
                      ]
                  )
              )
          ),

          Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                  text: TextSpan(
                      text: 'City: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: height/54.70
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${information.city}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                        )
                      ]
                  )
              )
          ),

          weather_response != null ? Container(

            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: height/164.12,bottom: height/164.12),
            margin: EdgeInsets.only(top: height/82.06,left: width/41.14,right: width/41.14,bottom: height/82.06),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                        text: TextSpan(
                            text: '${information.city} Weather',
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: height/27.35,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                            ),
                        )
                    )
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                        text: TextSpan(
                            text: 'Main : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: height/54.70
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.main}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                              )
                            ]
                        )
                    )
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                        text: TextSpan(
                            text: 'Description : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: height/54.70
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.description}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                              )
                            ]
                        )
                    )
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                        text: TextSpan(
                            text: 'Temperature : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: height/54.70
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.temperature.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                              )
                            ]
                        )
                    )
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                        text: TextSpan(
                            text: 'Feels Like : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: height/54.70
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.feels_like.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                              )
                            ]
                        )
                    )
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                        text: TextSpan(
                            text: 'Minimum Temperature : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: height/54.70
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.temp_min.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                              )
                            ]
                        )
                    )
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                        text: TextSpan(
                            text: 'Maximum Temperature : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: height/54.70
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.temp_max.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                              )
                            ]
                        )
                    )
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                        text: TextSpan(
                            text: 'Humidity : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: height/54.70
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "${weather_response.humidity.toString()}",
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                              )
                            ]
                        )
                    )
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                        text: TextSpan(
                            text: 'Sunrise : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: height/54.70
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${readTimestamp(weather_response.sunrise)}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                              )
                            ]
                        )
                    )
                ),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                        text: TextSpan(
                            text: 'Sunset : ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: height/54.70
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${readTimestamp(weather_response.sunset)}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                              )
                            ]
                        )
                    )
                ),



              ],
            ),
          ): Container(),

          RaisedButton(
            color: Color(0xffF8B350),
            onPressed: () async{
              await getWeatherData(information.city);
            },
            child:Text(
              "Get Your City's Weather Data",
              style: TextStyle(color: Colors.white,fontSize: height/41.03),
            ),
          ),


        ],
      ),

    );
  }
}
