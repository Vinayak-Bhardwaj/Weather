import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/user.dart';
import 'package:weather/services/database.dart';
import 'package:weather/shared/constants.dart';
import 'package:weather/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentPhone;
  String _currentCity;
  String email;

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

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      // ignore: missing_return
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;
          return Form(
            key: _formKey,

            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your settings',
                    style: TextStyle(fontSize: height/32.824,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height/41.03),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      initialValue:userData.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                  ),

                  SizedBox(height: height/41.03),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      initialValue: userData.city,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                      ),
                      validator: (val) => val.isEmpty ? 'Please enter a city' : null,
                      onChanged: (val) => setState(() => _currentCity = val),
                    ),
                  ),
                  SizedBox(height: height/41.03),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      initialValue: userData.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (val) => val.isEmpty ? 'Please enter a phone' : null,
                      onChanged: (val) => setState(() => _currentPhone = val),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: OutlineButton(
                      padding: EdgeInsets.all(0),
                      splashColor: Colors.yellow,
                      color: Colors.yellow,
                      hoverColor: Colors.yellow,
                      onPressed: () async {
                        if(_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentPhone ?? userData.phone,
                              _currentCity ?? userData.city,
                              userData.email
                          );
                          Navigator.pop(context);
                        }
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      highlightElevation: 0,
                      borderSide: BorderSide(color: Colors.grey),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, height/82.06, 0, height/82.06),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Image(image: AssetImage('assets/g_plus_icon.png'), height: 35.0),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Update Details',
                                style: TextStyle(
                                  fontSize: height/41.03,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
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
            ),

          );
        }else {
          return Loading();

        }

      }
    );
  }
}
