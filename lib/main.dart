import 'package:weather/models/user.dart';
import 'package:weather/screens/wrapper.dart';
import 'package:weather/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        //Returns to Wrapper
        home:Wrapper(),
      ),
    );
  }
}
