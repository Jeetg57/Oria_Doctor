import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oria_doctor/screens/wrapper.dart';
import 'package:oria_doctor/services/auth.dart';
import 'package:provider/provider.dart';

import 'Models/Doctor.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<DoctorFB>.value(
      value: AuthService().user,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => Wrapper(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          // '/doctors': (context) => Doctors(),
          // '/appointments': (context) => MyAppointments(),
          // '/appointment_status': (context) => Status(),
        },
      ),
    );
  }
}

