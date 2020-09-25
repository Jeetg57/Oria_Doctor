class Appointment {
  final String doctorId;
  final String userId;
  final String approval;
  final DateTime bookedAt;
  final DateTime time;

  Appointment(
      {this.doctorId, this.userId, this.approval, this.bookedAt, this.time});
}
