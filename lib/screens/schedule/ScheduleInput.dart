import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:oria_doctor/Models/Doctor.dart';
import 'package:oria_doctor/Models/scheduleTime.dart';
import 'package:oria_doctor/services/database.dart';
import 'package:provider/provider.dart';

class ScheduleInput extends StatefulWidget {
  @override
  _ScheduleInputState createState() => _ScheduleInputState();
}

class _ScheduleInputState extends State<ScheduleInput> {
  TimeOfDay startTime;
  TimeOfDay endTime;

  final format = DateFormat("HH:mm");
  String dropdownValue = "AM";
  String timeError = "";
  List<Map> monday = [];
  List<Map> tuesday = [];
  List<Map> wednesday = [];
  List<Map> thursday = [];
  List<Map> friday = [];
  List<Map> saturday = [];
  List<Map> sunday = [];

  saveToFB(String uid) {
    DatabaseService(uid: uid).saveSchedule(
        monday: monday,
        tuesday: tuesday,
        wednesday: wednesday,
        thursday: thursday,
        friday: friday,
        saturday: saturday,
        sunday: sunday);
  }

  dialogError() {
    showDialog(
        context: context,
        builder: (BuildContext context) => new MaterialDialog(
              headerColor: Colors.red,
              title: Text(
                "Input Error",
                style: TextStyle(
                    fontSize: 20.0, fontFamily: "Poppins", color: Colors.white),
              ),
              subTitle: Text(
                "Please enter a valid range",
                style: TextStyle(
                    fontSize: 14.0, fontFamily: "Poppins", color: Colors.white),
              ),
              content: Text(
                "Start time can not be ahead of the end time! Please enter a valid range",
                style: TextStyle(fontSize: 20.0, fontFamily: "Poppins"),
              ),
              enableCloseButton: true,
              onCloseButtonClicked: () => Navigator.pop(context),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.pop(context), child: Text("OK"))
              ],
            ));
  }

  dialogInput(List<Map> day, double size) {
    showDialog(
        context: context,
        builder: (BuildContext context) => new MaterialDialog(
              title: Text("Pick a time"),
              content: Container(
                height: size,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Start Time",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    DateTimeField(
                      decoration: InputDecoration(hintText: "Start Time"),
                      format: format,
                      onShowPicker: (context, currentValue) async {
                        final time = await showTimePicker(
                          initialEntryMode: TimePickerEntryMode.dial,
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        setState(() {
                          startTime = time;
                        });
                        return DateTimeField.convert(time);
                      },
                      onChanged: (value) {},
                    ),
                    Text(
                      "End Time",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    DateTimeField(
                      decoration: InputDecoration(hintText: "End Time"),
                      format: format,
                      onChanged: (value) {},
                      onShowPicker: (context, currentValue) async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        setState(() {
                          endTime = time;
                        });
                        return DateTimeField.convert(time);
                      },
                    ),
                    Text(timeError),
                  ],
                ),
              ),
              enableBackButton: true,
              enableCloseButton: true,
              onBackButtonClicked: () {
                // Navigator.pop(context, DialogDemoAction.agree);
              },
              onCloseButtonClicked: () {
                // Navigator.pop(context, DialogDemoAction.cancel);
              },
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'CANCEL',
                    style: Theme.of(context).textTheme.button.copyWith(
                        fontSize: 12.0, color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    // Navigator.pop(context, DialogDemoAction.agree);
                  },
                ),
                FlatButton(
                  child: Text(
                    'OK',
                    style: Theme.of(context).textTheme.button.copyWith(
                        fontSize: 12.0, color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    setState(() {
                      timeError = "";
                    });
                    if (startTime.hour > endTime.hour) {
                      setState(() {
                        dialogError();
                      });
                    } else {
                      day.add({
                        "startHour": startTime.hour,
                        "startMin": startTime.minute,
                        "endHour": endTime.hour,
                        "endMin": endTime.minute
                      });
                      Navigator.pop(context);
                    }
                    // Navigator.pop(context, DialogDemoAction.cancel);
                  },
                ),
              ],
            ));
  }

  showSchedule(List<Map> day) {
    return Container(
        height: (day.length.toDouble() * 70),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: day.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200]),
                  margin: EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 0.0),
                  child: ListTile(
                    title: Text(
                      "${n(day[index]["startHour"])}:${n(day[index]["startMin"])} - ${n(day[index]["endHour"])}:${n(day[index]["endMin"])}",
                      style: TextStyle(fontSize: 20.0, fontFamily: "Poppins"),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          day.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  ));
            }));
  }

  addToList(ScheduleTime value, List<ScheduleTime> day) {
    day.add(value);
  }

  n(n) {
    return n > 9 ? "" + n.toString() : "0" + n.toString();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DoctorFB>(context);

    double devHeight = MediaQuery.of(context).size.height;

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
          "Schedule",
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
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Monday",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      dialogInput(monday, devHeight * 0.3);
                    },
                  ),
                ],
              ),
              monday.isEmpty ? SizedBox() : showSchedule(monday),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tuesday",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      dialogInput(tuesday, devHeight * 0.3);
                    },
                  ),
                ],
              ),
              tuesday.isEmpty ? SizedBox() : showSchedule(tuesday),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Wednesday",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      dialogInput(wednesday, devHeight * 0.3);
                    },
                  ),
                ],
              ),
              wednesday.isEmpty ? SizedBox() : showSchedule(wednesday),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thursday",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      dialogInput(thursday, devHeight * 0.3);
                    },
                  ),
                ],
              ),
              thursday.isEmpty ? SizedBox() : showSchedule(thursday),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Friday",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      dialogInput(friday, devHeight * 0.3);
                    },
                  ),
                ],
              ),
              friday.isEmpty ? SizedBox() : showSchedule(friday),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Saturday",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      dialogInput(saturday, devHeight * 0.3);
                    },
                  ),
                ],
              ),
              saturday.isEmpty ? SizedBox() : showSchedule(saturday),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sunday",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      dialogInput(sunday, devHeight * 0.3);
                    },
                  ),
                ],
              ),
              sunday.isEmpty ? SizedBox() : showSchedule(sunday),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => saveToFB(user.uid),
        label: Text("Save"),
        icon: Icon(Icons.save),
      ),
    );
  }
}
