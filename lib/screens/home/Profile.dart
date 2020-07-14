import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/information.dart';
import 'package:weather/models/user.dart';
import 'package:weather/screens/authenticate/sign_in.dart';
import 'package:weather/screens/home/home.dart';
import 'package:weather/screens/home/list.dart';
import 'package:weather/screens/home/settings_forms.dart';
import 'package:weather/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather/shared/constants.dart';


double ht3;


class Profile extends StatefulWidget {


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {




  @override
  Widget build(BuildContext context) {

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    double width = queryData.size.width;
    double height = queryData.size.height;
    var size = queryData.size;
    ht3 = height;
    print(width);
    print(height);
    print(size);


    void _showSettingsPanel() {
      showModalBottomSheet(context: context,builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: height/41.03,horizontal: width/6.85),
          child: SettingsForm(),
        );
      });
    }


    final user = Provider.of<User>(context);
    return StreamProvider<Information>.value(
      value: DatabaseService(uid: user.uid).information,
      child: Scaffold(
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
                                colors: [Color(0xffFBB034),Color(0xffF8B313)],
                              )
                          ),

                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  title: Text(
                                    "Profile",
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/27.35),
                                  ),
                                  centerTitle: true,

                                  leading: new IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    tooltip: "Home Page",
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Home();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  actions: <Widget>[
                                    FlatButton.icon(
                                      color: Colors.transparent,
                                      icon: Icon(Icons.settings),
                                      label: Text('Settings',
                                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () => _showSettingsPanel(),
                                    )
                                  ],
                                ),

                                Container(
                                  child: list(),
                                ),

                              ],
                            ),

                          ),


                        )
                    )
                ),

    );
  }
}










