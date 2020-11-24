import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:oria_doctor/shared/constants.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class AppointmentNotes extends StatefulWidget {
  final String appointmentId;
  AppointmentNotes({Key key, @required this.appointmentId}) : super(key: key);
  @override
  _AppointmentNotesState createState() => _AppointmentNotesState();
}

class _AppointmentNotesState extends State<AppointmentNotes> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(); // Create instance.
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
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  getNotes() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("notes")
          .doc(widget.appointmentId)
          .get();
      if (doc.exists) {
        setState(() {
          myNoteController.text = doc.data()['notes'];
          myAilmentController.text = doc.data()['ailment'];
          myMedicationsController.text = doc.data()['medications'];
          notes = myNoteController.text;
          medications = myMedicationsController.text;
          ailment = myMedicationsController.text;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  setNotes(
      {String ailment,
      String notes,
      String medications,
      String displayTime}) async {
    setState(() {
      loading = true;
    });
    try {
      await FirebaseFirestore.instance
          .collection("notes")
          .doc(widget.appointmentId)
          .set({
        "ailment": ailment,
        "notes": notes,
        "medications": medications,
        "time-elapsed": displayTime,
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
    return StreamBuilder<int>(
      stream: _stopWatchTimer.rawTime,
      initialData: 0,
      builder: (context, snap) {
        final value = snap.data;
        final displayTime = StopWatchTimer.getDisplayTime(value);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Time Elapsed",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              displayTime,
                              style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                    controller: myAilmentController,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: noteInputDecoration.copyWith(
                        hintText: "Ailment/Problem"),
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
                    controller: myNoteController,
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
                    controller: myMedicationsController,
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) => new MaterialDialog(
                    borderRadius: 8.0,
                    enableFullHeight: true,
                    enableFullWidth: true,
                    enableCloseButton: true,
                    closeButtonColor: Colors.white,
                    headerColor: Colors.red,
                    title: Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 20.0,
                    ),
                    subTitle: Text(
                      "Appointment Rejection",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.0,
                      ),
                    ),
                    onCloseButtonClicked: () {
                      Navigator.pop(context);
                    },
                    children: <Widget>[
                      Text(
                        "Are you sure you want to end this meeting?",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // TextField(
                      //   decoration: InputDecoration(hintText: 'Enter Username'),
                      // ),
                    ],
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          'Yes',
                          style: Theme.of(context).textTheme.button.copyWith(
                              fontSize: 12.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                          setNotes(
                              notes: notes,
                              ailment: ailment,
                              medications: medications,
                              displayTime: displayTime);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/', (Route<dynamic> route) => false);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'No',
                          style: Theme.of(context).textTheme.button.copyWith(
                              fontSize: 12.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.save),
              label: Text("Save")),
        );
      },
    );
  }
}
