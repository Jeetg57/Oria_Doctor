import 'package:flutter/cupertino.dart';

class ScheduleTime {
  int startHour;
  int startMin;
  int endHour;
  int endMin;

  ScheduleTime({
    @required this.startHour,
    @required this.startMin,
    @required this.endHour,
    @required this.endMin,
  });
}
