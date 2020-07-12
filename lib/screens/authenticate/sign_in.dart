import 'package:weather/screens/home/home.dart';
import 'package:weather/screens/wrapper.dart';
import 'package:weather/services/auth.dart';
import 'package:weather/shared/constants.dart';
import 'package:weather/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

int img = 1;


class SignIn extends StatefulWidget {

  final toggleView;

  SignIn({ this.toggleView});


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  //text field state
  String email = '';
  String password = '';
  String error = '';
  String phoneNo;
  String smsCode;
  String verificationId;
  bool obscure = true;


  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context,builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: RichText(
                      text: TextSpan(
                        text: 'Select Your Spirit',
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
                child: RaisedButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () {
                      setState(() {
                        img = 1;
                      });
                      Navigator.pop(context);
                    },
                    child: RichText(
                        text: TextSpan(
                          text: '1)   Morning',
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        )
                    )
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: RaisedButton(
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        img = 2;
                      });
                      Navigator.pop(context);
                    },
                    child: RichText(
                        text: TextSpan(
                          text: '2)   Night',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        )
                    )
                ),
              )

            ],
          )
        );
      });
    }

    return loading ? Loading() : Scaffold(
      // SingleChildScrollView makes the UI not to overflow from bottom when TextField is used or different device is used
        body: SingleChildScrollView(
          child: Container(
            // MediaQuery.of(context).size provides the Dimensions of the parent widget
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              // Adding Linear Gradient to the background of UI
              image: DecorationImage(
                image: (img == 1) ? AssetImage('assets/Morning.png'):AssetImage('assets/Night.png'),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // Colors are converted to Integer from Hex Codes by replacing # with 0xff
                colors: [Color(0xffFBB034), Color(0xffF8B313)],
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column( // Column Widget is added to Render the complete UI in vertical direction
                children: <Widget>[
                  // App Bar is added in the body parameter of the Scaffold because we need to make it transparent and
                  // show the gradient in background. Alternative option will be to use gradient action bar from pub.dev
                  AppBar(

                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    // elevation removes the shadow under the action bar
                    title: Text(
                      "LOGIN", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),
                    centerTitle: true,
                    leading: GestureDetector(
                      onTap: () {
                        _showSettingsPanel();
                      },
                      child: Icon(
                        Icons.menu,
                      ),
                    ),

                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlutterLogo(size: 50),
                      )
                    ],
                  ),
                  ClipPath( // ClipPath is used to clip the child in a custom shape
                    clipper: BottomClipper(),
                    // here is the custom clipper for bottom cut shape
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.only(top: 40, bottom: 30),
                      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(1, 2),
                              spreadRadius: 1.0,
                              blurRadius: 5.0)
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    labelText: 'Email'),
                                validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                                onChanged: (val){
                                  setState(() => email = val);
                                }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
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
                                  }
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: InkWell(
                              onTap: () {
                                print("login using mobile number tap");
                              },
                              child: RichText( // RichText is used to styling a particular text span in a text by grouping them in one widget
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,),
                                  text: 'Login using ',
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'EMAIL AND PASSWORD',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              InkWell(
                                onTap: () async{
                                  if(_formKey.currentState.validate()){
                                    setState(() => loading = true);
                                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                    if(result == null){
                                      setState(() {
                                        error = 'Could not sign in with those credentials';
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 20, top: 10),
                                  decoration: BoxDecoration(
                                      color: Color(0xffFBB034),
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.navigate_next,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: TopClipper(), // Custom Clipper for top clipping the social login menu box
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 50, bottom: 50),
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(1, 2),
                              spreadRadius: 1.0,
                              blurRadius: 5.0),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
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
                            "Login with Social Media",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff898989),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[


                            Padding(
                              padding: const EdgeInsets.all(5.0),
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
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(image: AssetImage('assets/g_plus_icon.png'), height: 35.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Sign in with Google',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),



                              Padding(
                                padding: const EdgeInsets.all(8.0),


                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            error,
                            style: TextStyle(color : Colors.red, fontSize: 20.0,fontWeight: FontWeight.bold),
                          )
                        ],

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        widget.toggleView();
                        print("don't have an account tap");
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,fontSize:18),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Click here to signup",
                              style:
                              TextStyle(decoration: TextDecoration.underline,fontSize:18),
                            )
                          ],
                        ),
                      ),

                    ),
                  ),

                ],
              ),
            ),
          )
          ,
        )
    );
  }
}

// Custom Clipper Class
class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Add Path lines to form slight cut
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height - 50);
    return path;
  }

  // we don't need to render it again and again as UI renders
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 50);
    path.lineTo(size.width, size.height + 10);
    path.lineTo(0, size.height + 10);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
