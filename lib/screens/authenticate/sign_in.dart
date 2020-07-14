import 'package:weather/screens/home/home.dart';
import 'package:weather/screens/wrapper.dart';
import 'package:weather/services/auth.dart';
import 'package:weather/shared/constants.dart';
import 'package:weather/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

int img = 1;
double ht;

class SignIn extends StatefulWidget {
  final toggleView;

  SignIn({this.toggleView});

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
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    double width = queryData.size.width;
    double height = queryData.size.height;
    var size = queryData.size;
    ht = height;

    print(width);
    print(height);
    print(size);

    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(
                vertical: height / 41.03, horizontal: width / 13.67),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: RichText(
                    text: TextSpan(
                      text: 'Select Your Spirit',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: height / 27.35,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
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
                          fontSize: height / 41.03,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
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
                          fontSize: height / 41.03,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    }

    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (img == 1)
                        ? AssetImage('assets/Morning.png')
                        : AssetImage('assets/Night.png'),
                    fit: BoxFit.cover,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xffFBB034), Color(0xffF8B313)],
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          title: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: height / 27.35),
                          ),
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
                              child: FlutterLogo(size: height / 16.412),
                            ),
                          ],
                        ),
                        ClipPath(
                          clipper: BottomClipper(),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                top: height / 20.515, bottom: height / 27.35),
                            margin: EdgeInsets.only(
                                top: height / 27.35,
                                left: width / 20.57,
                                right: width / 20.57),
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
                                      validator: (val) =>
                                      val.isEmpty ? 'Enter an Email' : null,
                                      onChanged: (val) {
                                        setState(() => email = val);
                                      }),
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
                                        validator: (val) => val.length < 6
                                            ? 'Enter a password 6+ chars long'
                                            : null,
                                        onChanged: (val) {
                                          setState(() => password = val);
                                        }),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: height / 164.12),
                                  child: InkWell(
                                    onTap: () {
                                      print("login using mobile number tap");
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        text: 'Login using ',
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'EMAIL AND PASSWORD',
                                            style: TextStyle(
                                              decoration:
                                              TextDecoration.underline,
                                            ),
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
                                      onTap: () async {
                                        if (_formKey.currentState.validate()) {
                                          setState(() => loading = true);
                                          dynamic result = await _auth
                                              .signInWithEmailAndPassword(
                                              email, password);
                                          if (result == null) {
                                            setState(() {
                                              error =
                                              'Could not sign in with those credentials';
                                              loading = false;
                                            });
                                          }
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: width / 20.57,
                                            top: height / 82.06),
                                        decoration: BoxDecoration(
                                            color: Color(0xffFBB034),
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        padding: EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.navigate_next,
                                          size: height / 20.515,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        ClipPath(
                          clipper: TopClipper(),
                          // Custom Clipper for top clipping the social login menu box
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                top: height / 16.412, bottom: height / 16.412),
                            margin: EdgeInsets.only(
                                left: width / 20.57, right: width / 20.57),
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
                                    fontSize: height / 45.58,
                                    color: Color(0xff898989),
                                  ),
                                ),
                                Text(
                                  "Login with Social Media",
                                  style: TextStyle(
                                    fontSize: height / 45.58,
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
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(40)),
                                        highlightElevation: 0,
                                        borderSide:
                                        BorderSide(color: Colors.grey),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(0,
                                              height / 82.06, 0, height / 164.12),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image(
                                                  image: AssetImage(
                                                      'assets/g_plus_icon.png'),
                                                  height: height / 23.44),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: width / 41.14),
                                                child: Text(
                                                  'Sign in with Google',
                                                  style: TextStyle(
                                                    fontSize: height / 41.03,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
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
                                SizedBox(height: height / 54.70),
                                Text(
                                  error,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: height / 41.03,
                                      fontWeight: FontWeight.bold),
                                ),
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height / 45.58),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Click here to signup",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: height / 45.58),
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
              ),
            ),
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
    path.lineTo(0, size.height - ht / 16.412);
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

    path.lineTo(size.width, ht / 16.412);
    path.lineTo(size.width, size.height + ht / 82.06);
    path.lineTo(0, size.height + ht / 82.06);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
