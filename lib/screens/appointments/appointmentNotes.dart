import 'package:flutter/material.dart';
import 'package:oria_doctor/shared/constants.dart';

class AppointmentNotes extends StatefulWidget {
  @override
  _AppointmentNotesState createState() => _AppointmentNotesState();
}

class _AppointmentNotesState extends State<AppointmentNotes> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "Notes",
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
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ailment",
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0,
                      // letterSpacing: 1.5,
                      fontFamily: "Poppins"),
                ),
                TextField(
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: noteInputDecoration.copyWith(
                        hintText: "Ailment/Problem"),
                    minLines: 3,
                    maxLines: 10),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Notes",
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0,
                      // letterSpacing: 1.5,
                      fontFamily: "Poppins"),
                ),
                TextField(
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: noteInputDecoration.copyWith(
                        hintText: "Some notes for your patient"),
                    minLines: 10,
                    maxLines: 20),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Medications",
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20.0,
                      // letterSpacing: 1.5,
                      fontFamily: "Poppins"),
                ),
                TextField(
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: noteInputDecoration.copyWith(
                        hintText: "Medications/Prescription"),
                    minLines: 3,
                    maxLines: 10),
                RaisedButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.save),
                    label: Text("Save"))
              ],
            ),
          ),
        ));
  }
}
