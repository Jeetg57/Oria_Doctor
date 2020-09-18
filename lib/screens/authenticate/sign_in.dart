import 'package:flutter/material.dart';
import 'package:oria_doctor/screens/authenticate/forgot_pass.dart';
import 'package:oria_doctor/services/auth.dart';
import 'package:oria_doctor/shared/constants.dart';
import 'package:oria_doctor/shared/loadingWidget.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  //Text field state
  String email = "";
  String password = "";
  String error = "";
  String success = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    return loading
        ? LoadingWidget()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                "Oria Doctor",
                style: TextStyle(color: Colors.black, fontSize: 24.0),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: devHeight * 0.03),
                          Text(
                            "Welcome Back,",
                            style: TextStyle(
                                fontSize: 60.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                                letterSpacing: 0.0,
                                height: 1.1),
                          ),
                          Text(
                            "Let's get you signed in!",
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.grey[700],
                            ),
                          ),

                          //

                          SizedBox(height: devHeight * 0.03),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: devHeight * 0.02,
                                ),
                                TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: "Email"),
                                  validator: (val) => val.isEmpty
                                      ? "Please fill out this field"
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                ),
                                SizedBox(height: devHeight * 0.025),
                                TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                    hintText: "Password",
                                  ),
                                  validator: (val) => val.isEmpty
                                      ? "Please fill out this field"
                                      : null,
                                  onChanged: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                  obscureText: true,
                                ),
                                SizedBox(height: devHeight * 0.02),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sign in",
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontFamily: "Poppins",
                                    letterSpacing: 0.0,
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result = await _authService
                                          .signInWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          error =
                                              "Failed to sign in! Please check your credentials";
                                          loading = false;
                                        });
                                      }
                                    }
                                  },
                                  child: Icon(Icons.arrow_forward),
                                  backgroundColor: Colors.green,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: devHeight * 0.01),
                          Center(
                            child: Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    widget.toggleView();
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ForgotPass()),
                                    );
                                  },
                                  child: Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          );
  }
}