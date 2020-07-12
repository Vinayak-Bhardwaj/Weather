import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/information.dart';
import 'package:weather/WeatherResponse.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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



  @override
  Widget build(BuildContext context) {

    final information = Provider.of<Information>(context);

    return information == null ? CircularProgressIndicator() : Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10,bottom: 0),
      margin: EdgeInsets.only(top: 10,left: 20,right: 20),
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
                          fontSize: 15
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${information.name}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
                          fontSize: 15
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${information.email}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
                          fontSize: 15
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${information.phone}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
                          fontSize: 15
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${information.city}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        )
                      ]
                  )
              )
          ),

          weather_response != null ? Container(

            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 5,bottom: 5),
            margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
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
                                fontSize: 30,
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
                                fontSize: 15
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.main}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
                                fontSize: 15
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.description}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
                                fontSize: 15
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.temperature.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
                                fontSize: 15
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.feels_like.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
                                fontSize: 15
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.temp_min.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
                                fontSize: 15
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.temp_max.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
                                fontSize: 15
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "${weather_response.humidity.toString()}",
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
                                fontSize: 15
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.sunrise.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
                                fontSize: 15
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${weather_response.sunset.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
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
              style: TextStyle(color: Colors.white,fontSize: 20),
            ),
          ),


        ],
      ),

    );
  }
}
