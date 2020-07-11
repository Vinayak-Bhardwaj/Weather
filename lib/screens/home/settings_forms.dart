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

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      // ignore: missing_return
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.city,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please enter a city' : null,
                  onChanged: (val) => setState(() => _currentCity = val),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.phone,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please enter a phone' : null,
                  onChanged: (val) => setState(() => _currentPhone = val),
                ),



                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentName ?? userData.name,
                        _currentPhone ?? userData.phone,
                        _currentCity ?? userData.city
                      );
                      Navigator.pop(context);
                    }
                  },
                ),


              ],
            ),
          );
        }else {
          return Loading();

        }

      }
    );
  }
}
