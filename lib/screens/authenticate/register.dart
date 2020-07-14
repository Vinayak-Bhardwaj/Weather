import 'package:provider/provider.dart';
import 'package:weather/models/user.dart';
import 'package:weather/screens/authenticate/sign_in.dart';
import 'package:weather/screens/home/home.dart';
import 'package:weather/screens/wrapper.dart';
import 'package:weather/services/auth.dart';
import 'package:weather/services/database.dart';
import 'package:weather/shared/constants.dart';
import 'package:weather/shared/loading.dart';
import 'package:flutter/material.dart';

double ht1;

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
  String msg='';
  bool obscure = true;
  String city='';
  // create a new document for the user with the uid
  Future update(User user,String name,String phone,String city,String email_same) async {
    // create a new document for the user with the uid
    await DatabaseService(uid: user.uid).updateUserData(name, phone, city,email_same);
  }

  @override

  Widget build(BuildContext context) {


    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    double width = queryData.size.width;
    double height = queryData.size.height;
    var size = queryData.size;
    ht1 = height;
    print(width);
    print(height);
    print(size);


    return loading ? Loading() : Scaffold(
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
              ),
          ),

          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    "Sign up",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: height/27.35),
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
                      child: FlutterLogo(size: height/16.412),
                    ),
                  ],
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: height/164.12,bottom: 0),
                  margin: EdgeInsets.only(top: 0,left: width/20.57,right: width/20.57,bottom:0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: 'Full Name',
                            ),
                            validator: (val) => name.isEmpty ? 'Enter Your Name' : null,
                            onChanged: (val){
                              setState(() => name = val,
                              );
                            },
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Email',
                            ),
                            validator: (val) => email.isEmpty ? 'Enter an Email' : null,
                            onChanged: (val){
                              setState(() => email = val);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              hintText: 'Phone Number',
                            ),
                            validator: (val) => phone.length < 10 ? 'Enter Correct Phone number' : null,
                            onChanged: (val){
                              setState(() => phone = val);
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_city),
                              hintText: 'City For eg New Delhi,Bikaner,Jaipur',
                            ),
                            validator: (val) => city.isEmpty ? 'Enter Your City' : null,
                            onChanged: (val){
                              setState(() => city = val,
                              );
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            obscureText: obscure,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Password',
                              suffixIcon: GestureDetector(
                                onTap: () => setState(() {
                                  obscure = !obscure;
                                }),
                                child: obscure
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                              ),
                            ),
                            validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                            onChanged: (val){
                              setState(() => password = val);

                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                              obscureText: obscure,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                labelText: 'Re-Enter Password',
                                suffixIcon: GestureDetector(
                                  onTap: () => setState(() {
                                    obscure = !obscure;
                                  }),
                                  child: obscure
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                ),

                              ),
                              validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                              onChanged: (val){
                                setState(() => verpassword = val);
                                if(password!=verpassword){
                                  setState(() {
                                    error = 'Password does not match';
                                    loading = false;
                                  });
                                }else{
                                  setState(() {
                                    msg = 'Password matches';
                                  });
                                }
                              }
                          ),
                        ),


                        OutlineButton(
                          splashColor: Color(0xffFBB034),
                          focusColor: Color(0xffFBB034),
                          color: Color(0xffFBB034),
                          highlightColor:Color(0xffFBB034),
                          hoverColor: Color(0xffFBB034),

                          onPressed: () async{
                            if(_formKey.currentState.validate()){
                              setState(() => loading = true);
                              dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                              update(result,name, phone, city,email);
                              if(result == null){
                                setState(() {
                                  error = 'please supply a valid email';
                                  loading = false;
                                });
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          highlightElevation: 0,
                          borderSide: BorderSide(color: Color(0xffFBB034)),
                          child: Padding(
                            padding:EdgeInsets.fromLTRB(width/41.14, height/82.06, width/41.14, height/82.06),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //Image(image: AssetImage('assets/g_plus_icon.png'), height: 35.0),
                                Padding(
                                  padding:EdgeInsets.only(left: width/41.14),
                                  child: Text(
                                    'Proceed',
                                    style: TextStyle(
                                      fontSize: height/41.03,
                                      color: Color(0xffFBB034),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(
                                  "Or",
                                  style: TextStyle(
                                    fontSize: height/45.58,
                                    color: Color(0xff898989),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Text(
                                  "Register with Social Media",
                                  style: TextStyle(
                                    fontSize: height/45.58,
                                    color: Color(0xff898989),
                                  ),
                                ),
                              ),
                            ]
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height/164.12),
                          child: OutlineButton(
                            splashColor: Colors.grey,
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
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                            highlightElevation: 0,
                            borderSide: BorderSide(color: Colors.grey),
                            child: Padding(
                              padding:EdgeInsets.fromLTRB(0, height/164.12, 0, height/164.12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(image: AssetImage('assets/g_plus_icon.png'), height: height/23.44),
                                  Padding(
                                    padding: EdgeInsets.only(left: width/41.14),
                                    child: Text(
                                      'Sign in with Google',
                                      style: TextStyle(
                                        fontSize: height/41.03,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height/82.06),
                        Text(
                          msg.isEmpty?error:msg,
                          style: msg.isEmpty?TextStyle(color : Colors.red, fontSize: height/41.03,fontWeight: FontWeight.bold):TextStyle(color : Colors.green, fontSize: height/41.03,fontWeight: FontWeight.bold),
                        ),
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
                            color: Colors.white, fontWeight: FontWeight.bold,fontSize: height/45.58),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Click here to sign in",
                            style:
                            TextStyle(decoration: TextDecoration.underline,fontSize: height/45.58),
                          ),
                        ],
                      ),
                    ),
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