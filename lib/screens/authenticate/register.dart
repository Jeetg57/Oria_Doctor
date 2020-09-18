import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oria_doctor/services/auth.dart';
import 'package:oria_doctor/shared/constants.dart';
import 'package:oria_doctor/shared/loadingWidget.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String password = "";
  String error = "";
  String name = "";
  DateTime birthdate;
  final String asset = "assets/images/mask-woman.svg";
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;

    return loading
        ? LoadingWidget()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                "Oria",
                style: TextStyle(color: Colors.black, fontSize: 24.0),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: Container(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                width: devWidth * 0.6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Create Account,",
                                      style: TextStyle(
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Let's get you signed up!",
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: devHeight * 0.05),
                              SvgPicture.asset(
                                asset,
                                width: devWidth * 0.2,
                              ),
                            ],
                          ),
                          SizedBox(height: devHeight * 0.05),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Full Name"),
                                validator: (val) {
                                  return val.isEmpty ? 'Enter your name' : null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    name = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              DateTimeField(
                                onDateSelected: (DateTime value) {
                                  setState(() {
                                    birthdate = value;
                                  });
                                },
                                enabled: true,
                                mode: DateFieldPickerMode.date,
                                initialDatePickerMode: DatePickerMode.year,
                                lastDate: DateTime(2020),
                                decoration: textInputDecoration,
                                label: "Birthdate",
                                selectedDate: birthdate,
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Email"),
                                validator: (val) {
                                  return val.isEmpty ? 'Enter an email' : null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Password"),
                                validator: (val) => val.length < 6
                                    ? 'Password should be at least 6 characters'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                                obscureText: true,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            height: 60.0,
                            child: RaisedButton(
                              onPressed: () async {
                                print(birthdate);
                                if (birthdate == null) {
                                  error = "Please enter a birthdate";
                                } else if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await _authService
                                      .registerWithEmailAndPassword(
                                          email, password, name, birthdate);
                                  if (result == null) {
                                    setState(() {
                                      error = "Please supply a valid email";
                                      loading = false;
                                    });
                                  }
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(0, 255, 249, 0.6),
                                        // Color(0xff00FFB4),
                                        Color.fromRGBO(0, 255, 137, 0.6),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: double.infinity,
                                      minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Register",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Center(
                            child: Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5.0),
                              FlatButton(
                                onPressed: () {
                                  widget.toggleView();
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ),
          );
  }
}