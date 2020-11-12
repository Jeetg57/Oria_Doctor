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
            elevation: 0.0,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Color.fromRGBO(247, 249, 249, 1),
          ),
          body: Container(
              child: SizedBox(
            child: AppointmentList(),
          )),
        ));
  }
}
