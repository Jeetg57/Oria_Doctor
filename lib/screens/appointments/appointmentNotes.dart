import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oria_doctor/shared/constants.dart';

class AppointmentNotes extends StatefulWidget {
  final String appointmentId;
  AppointmentNotes({Key key, @required this.appointmentId}) : super(key: key);
  @override
  _AppointmentNotesState createState() => _AppointmentNotesState();
}

class _AppointmentNotesState extends State<AppointmentNotes> {
  String ailment = "";
  bool loading = false;
  String notes = "";
  String medications = "";
  final myNoteController = TextEditingController();
  final myMedicationsController = TextEditingController();
  final myAilmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  getNotes() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("notes")
          .doc(widget.appointmentId)
          .get();
      if (doc.exists) {
        setState(() {
          ailment = doc.data()["ailment"];
          notes = doc.data()["notes"];
          medications = doc.data()["medications"];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  setNotes({String ailment, String notes, String medications}) async {
    setState(() {
      loading = true;
    });
    try {
      await FirebaseFirestore.instance
          .collection("notes")
          .doc(widget.appointmentId)
          .set(
              {"ailment": ailment, "notes": notes, "medications": medications});
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
              TextFormField(
                initialValue: ailment,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                decoration:
                    noteInputDecoration.copyWith(hintText: "Ailment/Problem"),
                minLines: 3,
                maxLines: 10,
                onChanged: (val) {
                  setState(() {
                    ailment = val;
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Notes for your patient",
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20.0,
                    // letterSpacing: 1.5,
                    fontFamily: "Poppins"),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                initialValue: notes,
                decoration: noteInputDecoration.copyWith(
                    hintText: "Some notes for your patient"),
                minLines: 10,
                maxLines: 20,
                onChanged: (val) {
                  setState(() {
                    notes = val;
                  });
                },
              ),
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
              TextFormField(
                keyboardType: TextInputType.multiline,
                initialValue: medications,
                textCapitalization: TextCapitalization.sentences,
                decoration: noteInputDecoration.copyWith(
                    hintText: "Medications/Prescription"),
                minLines: 3,
                maxLines: 10,
                onChanged: (val) {
                  setState(() {
                    medications = val;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: () {
            setNotes(notes: notes, ailment: ailment, medications: medications);
          },
          icon: Icon(Icons.save),
          label: Text("Save")),
    );
  }
}
