import 'package:flutter/material.dart';
import 'package:oria_doctor/services/auth.dart';
import 'package:oria_doctor/shared/constants.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  //Text field state
  String email = "";
  String error = "";
  bool loading = false;
  String success = "";
  bool emailInputEnabled = true;
  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Oria",
          style: TextStyle(color: Colors.black, fontSize: 24.0),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: devHeight * 0.03),
                    Text(
                      "Reset Password,",
                      style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          letterSpacing: 0.0,
                          height: 1.1),
                    ),
                    Text(
                      "Let's get you up and running!",
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
                            enabled: emailInputEnabled,
                            decoration:
                                textInputDecoration.copyWith(hintText: "Email"),
                            validator: (val) => val.isEmpty
                                ? "Please fill out this field"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          SizedBox(height: devHeight * 0.02),
                          Text(
                            success,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: devHeight * 0.02),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Reset",
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
                                  emailInputEnabled = false;
                                  loading = true;
                                });
                                dynamic result =
                                    await _authService.resetPassword(email);
                                if (result == null) {
                                  setState(() {
                                    emailInputEnabled = true;
                                    error =
                                        "Failed to sign in! Please check your credentials";
                                    loading = false;
                                  });
                                } else if (result == true) {
                                  setState(() {
                                    success =
                                        "Email successfully sent! Please check your mailbox to reset your password.";
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
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
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