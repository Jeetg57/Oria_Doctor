import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oria_doctor/screens/appointments/appointmentNotes.dart';
import 'package:oria_doctor/shared/loadingWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentStatus extends StatefulWidget {
  final String appointmentId;
  AppointmentStatus({Key key, @required this.appointmentId}) : super(key: key);
  @override
  _AppointmentStatusState createState() => _AppointmentStatusState();
}

class _AppointmentStatusState extends State<AppointmentStatus> {
  bool loading = false;
  var appointment;
  var user;
  String dropdownValue = 'Accept';

  final String phone = 'tel:+254799698998';

  @override
  void initState() {
    super.initState();
    getSchedule();
  }

  _callPhone() async {
    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      throw 'Could not Call Phone';
    }
  }

  _appointmentStatus(String confirmation) async {
    setState(() {
      loading = true;
    });
    try {
      await FirebaseFirestore.instance
          .collection("appointments")
          .doc(widget.appointmentId)
          .update({"approval": confirmation});
      getSchedule();
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        loading = false;
      });
      return null;
    }
  }

  getSchedule() async {
    setState(() {
      loading = true;
    });
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("appointments")
          .doc(widget.appointmentId)
          .get();
      setState(() {
        appointment = doc.data();
      });
      DocumentSnapshot docUser = await FirebaseFirestore.instance
          .collection("users")
          .doc(appointment["userId"])
          .get();
      setState(() {
        loading = false;
        user = docUser.data();
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        loading = false;
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingWidget()
        : Scaffold(
            backgroundColor: Color.fromRGBO(247, 249, 249, 1),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              elevation: 0.0,
              title: Text(
                "Appointment Status",
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24.0,
                    // letterSpacing: 1.5,
                    fontFamily: "Poppins"),
              ),
              backgroundColor: Color.fromRGBO(247, 249, 249, 1),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.green,
                    ),
                    title: Text(
                      "Patient Info",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Color.fromRGBO(28, 40, 51, 1),
                          fontSize: 20.0),
                    ),
                    subtitle: Text(
                      "Some info about the patient",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(212, 230, 241, 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          user["name"],
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 10,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          user["email"],
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 10,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        Text(
                          "Birthdate",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          DateFormat('dd-MM-yyyy')
                              .format(DateTime.parse(
                                  user["birthdate"].toDate().toString()))
                              .toString(),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.book,
                      size: 40,
                      color: Colors.green,
                    ),
                    title: Text(
                      "Appointment Details",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Color.fromRGBO(28, 40, 51, 1),
                          fontSize: 20.0),
                    ),
                    subtitle: Text(
                      "Information about your appointment",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(212, 230, 241, 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          DateFormat('EEEE MMMM d - HH:m a')
                              .format(DateTime.parse(
                                  appointment["time"].toDate().toString()))
                              .toString(),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                        const Divider(
                          color: Color.fromRGBO(171, 178, 185, 1),
                          height: 10,
                          indent: 0,
                          thickness: 1,
                          endIndent: 0,
                        ),
                        Text(
                          "Approval",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(128, 139, 150, 1)),
                        ),
                        Text(
                          appointment["approval"],
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromRGBO(28, 40, 51, 1),
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  appointment["approval"] == "Booked"
                      ? Container(
                          alignment: Alignment.bottomCenter,
                          child: Wrap(
                            spacing: 20.0,
                            runSpacing: 8.0,
                            direction: Axis.horizontal,
                            runAlignment: WrapAlignment.spaceEvenly,
                            alignment: WrapAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton.extended(
                                  backgroundColor: Colors.green,
                                  heroTag: "ButtonCall",
                                  onPressed: () => _callPhone(),
                                  icon: Icon(Icons.call),
                                  label: Text("Call")),
                              FloatingActionButton.extended(
                                  backgroundColor: Colors.green,
                                  heroTag: "buttonMessage",
                                  onPressed: null,
                                  icon: Icon(Icons.message),
                                  label: Text("Message")),
                              FloatingActionButton.extended(
                                  backgroundColor: Colors.black,
                                  heroTag: "buttonStartMeeting",
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AppointmentNotes(
                                            appointmentId:
                                                widget.appointmentId),
                                      )),
                                  icon: Icon(Icons.play_arrow),
                                  label: Text("Start Meeting")),
                            ],
                          ),
                        )
                      : SizedBox(),
                  appointment["approval"] == "Rejected"
                      ? Container(
                          margin: const EdgeInsets.all(15.0),
                          child: Text(
                            "This meeting was cancelled and can no longer be changed! You no longer have access to notes or the contact of the patient",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : SizedBox(),
                  appointment["approval"] == "Pending"
                      ? Column(
                          children: [
                            Text("Please input your decision"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlatButton.icon(
                                    color: Colors.greenAccent,
                                    onPressed: () =>
                                        _appointmentStatus("Booked"),
                                    icon: Icon(Icons.done),
                                    label: Text("Approve")),
                                FlatButton.icon(
                                    color: Colors.redAccent,
                                    onPressed: () =>
                                        _appointmentStatus("Rejected"),
                                    icon: Icon(Icons.clear),
                                    label: Text("Reject")),
                              ],
                            )
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
          );
  }
}
