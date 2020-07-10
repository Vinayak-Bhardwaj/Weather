import 'package:weather/screens/home/home.dart';
import 'package:weather/screens/wrapper.dart';
import 'package:weather/services/auth.dart';
import 'package:weather/shared/constants.dart';
import 'package:weather/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String verpassword = '';
  String error = '';
  String name='';
  String phone='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
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
                  "Sign up",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0),
                ),
                centerTitle: true,

                leading: new IconButton(
                  icon: Icon(Icons.arrow_back),
                  tooltip: "Sign in",
                  onPressed: () {
                    widget.toggleView();
                  },
                ),

                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/logo.png'),
                  )
                ],
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 20,bottom: 0),
                margin: EdgeInsets.only(top: 30,left: 20,right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Full Name',
                            ),
                            validator: (val) => val.isEmpty ? 'Enter Your Name' : null,
                            onChanged: (val){
                              setState(() => name = val);
                            }
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Email',
                            ),
                            validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                            onChanged: (val){
                              setState(() => email = val);
                            }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.flag),
                              hintText: 'Phone Number',
                            ),
                            validator: (val) => val.length < 10 ? 'Enter Correct Phone number' : null,
                            onChanged: (val){
                              setState(() => phone = val);
                            }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Password',
                            ),
                            validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                            obscureText: true,
                            onChanged: (val){
                              setState(() => password = val);

                            }
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Re-Enter Password',
                            ),
                            validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                            obscureText: true,
                            onChanged: (val){
                              setState(() => verpassword = val);
                              if(password!=verpassword){
                                setState(() {
                                  error = 'Password does not match';
                                  loading = false;
                                });
                              }
                            }
                        ),
                      ),

                      RaisedButton(
                        color: Color(0xffFBB034),
                        onPressed: () async{
                          if(_formKey.currentState.validate()){
                            setState(() => loading = true);
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            if(result == null){
                              setState(() {
                                error = 'please supply a valid email';
                                loading = false;
                              });

                            }
                          }
                        },
                        child:Text(
                          'Proceed',
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        ),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Or",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff898989),
                              ),
                            ),
                            Text(
                              "Register with Social Media",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff898989),
                              ),
                            ),
                          ]
                      ),
                      new IconButton(
                        padding: const EdgeInsets.all(8.0),
                        icon: Image.asset('assets/g_plus_icon.png'),
                        tooltip: "Google Sign in",
                        onPressed: () async {
                          signInWithGoogle().whenComplete(() {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return Wrapper();
                                },
                              ),
                            );
                          });
                        },
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color : Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    widget.toggleView();
                    print("already have an account tap");
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Click here to sign in",
                          style:
                          TextStyle(decoration: TextDecoration.underline,fontSize: 15),
                        )
                      ],
                    ),
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
