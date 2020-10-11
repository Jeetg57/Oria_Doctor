import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:oria_doctor/Models/DocSchedule.dart';
import 'package:oria_doctor/Models/Doctor.dart';
import 'package:oria_doctor/services/database.dart';
import 'package:provider/provider.dart';

class ScheduleInput extends StatefulWidget {
  @override
  _ScheduleInputState createState() => _ScheduleInputState();
}

class _ScheduleInputState extends State<ScheduleInput> {
  TimeOfDay startTime;
  TimeOfDay endTime;
  DatabaseService databaseService = DatabaseService();
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

  dialogInput(String day, double size) {
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
                      var map = {
                        "startHour": startTime.hour,
                        "startMin": startTime.minute,
                        "endHour": endTime.hour,
                        "endMin": endTime.minute
                      };
                      databaseService.addToScheduleArray(day.toString(), map);
                      Navigator.pop(context);
                    }
                    // Navigator.pop(context, DialogDemoAction.cancel);
                  },
                ),
              ],
            ));
  }

  n(n) {
    if (n.runtimeType != String)
      return n > 9 ? "" + n.toString() : "0" + n.toString();
    else
      return n;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DoctorFB>(context);

    double devHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<DocSchedule>(
      stream: DatabaseService(uid: user.uid).scheduleData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DocSchedule schedule = snapshot.data;
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
                    const Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 1,
                      endIndent: 0,
                    ),
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
                            dialogInput("Monday", devHeight * 0.3);
                          },
                        ),
                      ],
                    ),
                    schedule.monday != null
                        ? ListTile(
                            leading: Text(
                                "${schedule.monday["startHour"].toString()}:${n(schedule.monday["startMin"])} - ${schedule.monday["endHour"].toString()}:${n(schedule.monday["endMin"])}"),
                            trailing: IconButton(
                                icon: Icon(Icons.delete), onPressed: null),
                          )
                        : Text("Unavailable"),
                    const Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 1,
                      endIndent: 0,
                    ),
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
                            dialogInput("Tuesday", devHeight * 0.3);
                          },
                        ),
                      ],
                    ),
                    schedule.tuesday != null
                        ? ListTile(
                            leading: Text(
                                "${schedule.tuesday["startHour"].toString()}:${n(schedule.tuesday["startMin"])} - ${schedule.tuesday["endHour"].toString()}:${n(schedule.tuesday["endMin"])}"),
                            trailing: IconButton(
                                icon: Icon(Icons.delete), onPressed: null),
                          )
                        : Text("Unavailable"),
                    const Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 1,
                      endIndent: 0,
                    ),
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
                            dialogInput("Wednesday", devHeight * 0.3);
                          },
                        ),
                      ],
                    ),
                    schedule.wednesday != null
                        ? ListTile(
                            leading: Text(
                                "${schedule.wednesday["startHour"].toString()}:${n(schedule.wednesday["startMin"])} - ${schedule.wednesday["endHour"].toString()}:${n(schedule.wednesday["endMin"])}"),
                            trailing: IconButton(
                                icon: Icon(Icons.delete), onPressed: null),
                          )
                        : Text("Unavailable"),
                    const Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 1,
                      endIndent: 0,
                    ),
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
                            dialogInput("Thursday", devHeight * 0.3);
                          },
                        ),
                      ],
                    ),
                    schedule.thursday != null
                        ? ListTile(
                            leading: Text(
                                "${schedule.thursday["startHour"].toString()}:${n(schedule.thursday["startMin"])} - ${schedule.thursday["endHour"].toString()}:${n(schedule.thursday["endMin"])}"),
                            trailing: IconButton(
                                icon: Icon(Icons.delete), onPressed: null),
                          )
                        : Text("Unavailable"),
                    const Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 1,
                      endIndent: 0,
                    ),
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
                            dialogInput("Friday", devHeight * 0.3);
                          },
                        ),
                      ],
                    ),
                    schedule.friday != null
                        ? ListTile(
                            leading: Text(
                                "${schedule.friday["startHour"].toString()}:${n(schedule.friday["startMin"])} - ${schedule.friday["endHour"].toString()}:${n(schedule.friday["endMin"])}"),
                            trailing: IconButton(
                                icon: Icon(Icons.delete), onPressed: null),
                          )
                        : Text("Unavailable"),
                    const Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 1,
                      endIndent: 0,
                    ),
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
                            dialogInput("Saturday", devHeight * 0.3);
                          },
                        ),
                      ],
                    ),
                    schedule.saturday != null
                        ? ListTile(
                            leading: Text(
                                "${schedule.saturday["startHour"].toString()}:${n(schedule.saturday["startMin"])} - ${schedule.saturday["endHour"].toString()}:${n(schedule.saturday["endMin"])}"),
                            trailing: IconButton(
                                icon: Icon(Icons.delete), onPressed: null),
                          )
                        : Text("Unavailable"),
                    const Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 1,
                      endIndent: 0,
                    ),
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
                            dialogInput("Sunday", devHeight * 0.3);
                          },
                        ),
                      ],
                    ),
                    schedule.sunday != null
                        ? ListTile(
                            leading: Text(
                                "${schedule.sunday["startHour"].toString()}:${n(schedule.sunday["startMin"])} - ${schedule.sunday["endHour"].toString()}:${n(schedule.saturday["endMin"])}"),
                            trailing: IconButton(
                                icon: Icon(Icons.delete), onPressed: null),
                          )
                        : Text("Unavailable"),
                    const Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 1,
                      endIndent: 0,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(
            child: Text("Error"),
          );
        }
      },
    );
  }
}
