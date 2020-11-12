import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oria_doctor/Models/UserData.dart';
import 'package:oria_doctor/screens/appointments/appointmentStatus.dart';
import 'package:oria_doctor/services/database.dart';
import 'package:oria_doctor/Models/Appointment.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;
  AppointmentTile({this.appointment});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PatientData>(
        stream: DatabaseService().patientData(appointment.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PatientData patientData = snapshot.data;
            String formattedTime =
                DateFormat.MMMMEEEEd().format(appointment.time);
            return Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200]),
                margin: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 0.0),
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AppointmentStatus(appointmentId: appointment.id),
                    ),
                  ),
                  title: Text("Appointment with ${patientData.name}",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 18.0)),
                  subtitle: Text("Date : $formattedTime",
                      style: TextStyle(fontFamily: "Poppins")),
                  trailing: Text(appointment.approval),
                ),
              ),
            );
          } else {
            return Container(
              child: Text("Error"),
            );
          }
        });
  }
}
