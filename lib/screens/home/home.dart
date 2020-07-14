import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/WeatherResponse.dart';
import 'package:weather/models/user.dart';
import 'package:weather/screens/authenticate/register.dart';
import 'package:weather/screens/authenticate/sign_in.dart';
import 'package:weather/screens/home/Profile.dart';
import 'package:weather/services/auth.dart';
import 'package:weather/shared/constants.dart';

double ht2;


const API_KEY = '728c16fd6658cfc073d9fdf63b04acb9';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  WeatherResponse weather_response;
  TextEditingController _controller = TextEditingController();

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

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {


    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    double width = queryData.size.width;
    double height = queryData.size.height;
    var size = queryData.size;
    ht2 = height;
    print(width);
    print(height);
    print(size);

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

    return Scaffold(


                body: SingleChildScrollView(


                  child: Container(
                    height: MediaQuery.of(context).size.height,

                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: (img == 1) ? AssetImage('assets/Morning.png'):AssetImage('assets/Night.png'),
                          fit: BoxFit.cover,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xffF8B313),Color(0xff222867)],
                        )
                    ),

                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[

                          AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            title: Text(
                              widget.title,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/27.35),
                            ),
                            centerTitle: true,

                            leading: new IconButton(
                              icon: Icon(Icons.person),
                              tooltip: "Logout",
                              onPressed: () async{
                                await _auth.signOut();
                              },
                            ),

                            actions: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                //child: Image.asset('assets/logo.png'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: OutlineButton(
                                  splashColor: Colors.white,
                                  focusColor: Colors.white,
                                  color: Colors.white,
                                  highlightColor:Colors.white,
                                  hoverColor: Colors.white,
                                  textColor: Colors.white,
                                  onPressed: () async {

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Profile();
                                        },
                                      ),
                                    );

                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                  highlightElevation: 0,
                                  borderSide: BorderSide(color: Colors.transparent),
                                  child: Padding(
                                    padding:EdgeInsets.fromLTRB(0, height/82.06, 0, height/82.06),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        //Image(image: AssetImage('assets/g_plus_icon.png'), height: 35.0),
                                        Padding(
                                          padding: EdgeInsets.only(left: width/41.14),
                                          child: Text(
                                            'Profile',
                                            style: TextStyle(
                                              fontSize: height/41.03,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          weather_response != null ? Container(

                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: height/82.06,bottom: height/54.70),
                            margin: EdgeInsets.only(top: height/16.412,left: width/20.57,right: width/20.57,bottom: height/27.35),
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
                                      text: 'Main : ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: height/54.70,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${weather_response.main}',
                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/54.70),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: RichText(
                                        text: TextSpan(
                                            text: 'Description : ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: height/54.70,
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
                                    padding: const EdgeInsets.all(10),
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
                                                style: TextStyle(fontWeight: FontWeight.bold,fontSize:height/54.70),
                                              )
                                            ]
                                        )
                                    )
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(10),
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
                                    padding: const EdgeInsets.all(10),
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
                                    padding: const EdgeInsets.all(10),
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
                                    padding: const EdgeInsets.all(10),
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
                                    padding: const EdgeInsets.all(10),
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
                                    padding: const EdgeInsets.all(10),
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

                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: height/82.06,bottom: height/54.70),
                            margin: EdgeInsets.only(top: height/16.412,left: width/20.57,right: width/20.57,bottom: height/27.35),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                labelText: 'Enter your city',
                                prefixIcon: Icon(Icons.location_city),
                              ),
                            ),
                          ),

                          RaisedButton(
                            color: Color(0xffF8B350),
                            onPressed: () async{
                              await getWeatherData(_controller.text);
                            },
                            child:Text(
                              "Get Weather Data",
                              style: TextStyle(color: Colors.white,fontSize: height/41.03),
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













