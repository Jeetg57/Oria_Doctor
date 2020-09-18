import 'package:flutter/material.dart';
import 'package:oria_doctor/Models/Doctor.dart';
import 'package:oria_doctor/screens/home/homeMain.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DoctorFB>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return HomeMain();
    }
    //Return either home or authenticate widget
  }
}