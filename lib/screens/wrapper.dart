import 'package:flutter/material.dart';
import 'package:oria_doctor/Models/Doctor.dart';
import 'package:oria_doctor/screens/authenticate/onboarding.dart';
import 'package:oria_doctor/screens/home/homeMain.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DoctorFB>(context);
    Future<bool> checkOnboarding() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool boolValue = prefs.getBool("onboarding-completed");
      return boolValue;
    }

    if (checkOnboarding() == null) {
      return OnBoarding();
    } else if (user == null) {
      return Authenticate();
    } else {
      return HomeMain();
    }
    //Return either home or authenticate widget
  }
}
