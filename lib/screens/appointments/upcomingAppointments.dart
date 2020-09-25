import 'package:flutter/material.dart';
import 'package:oria_doctor/Models/Appointment.dart';
import 'package:oria_doctor/Models/Doctor.dart';
import 'package:oria_doctor/screens/appointments/upcomingAppointmentsList.dart';
import 'package:oria_doctor/services/database.dart';
import 'package:provider/provider.dart';

class UpcomingAppointments extends StatefulWidget {
  @override
  _UpcomingAppointmentsState createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DoctorFB>(context);

    return StreamProvider<List<Appointment>>.value(
        value: DatabaseService().appointmentData(user.uid),
        child: Scaffold(
          backgroundColor: Color.fromRGBO(247, 249, 249, 1),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            title: Text(
              "Oria Doctor",
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24.0,
                  // letterSpacing: 1.5,
                  fontFamily: "Poppins"),
            ),
            backgroundColor: Color.fromRGBO(247, 249, 249, 1),
          ),
          body: Container(child: SizedBox(child: AppointmentList())),
        ));
  }
}
