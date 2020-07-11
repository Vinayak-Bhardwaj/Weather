import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/information.dart';
import 'package:weather/models/user.dart';
import 'package:weather/screens/home/home.dart';
import 'package:weather/screens/home/list.dart';
import 'package:weather/screens/home/settings_forms.dart';
import 'package:weather/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Profile extends StatefulWidget {


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context,builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
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
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xffFBB034),Color(0xffF8B313)],
                    )
                ),
                child: Column(
                  children: <Widget>[
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: Text(
                        "Profile",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0),
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
                          icon: Icon(Icons.settings),
                          label: Text('Settings'),
                          onPressed: () => _showSettingsPanel(),
                        )
                      ],
                    ),

                    Container(
                      child: list(),
                    ),
                  ],
                ),
              )
          )
      ),
    );
  }
}










