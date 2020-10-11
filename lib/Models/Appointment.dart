class Appointment {
  final String id;
  final String doctorId;
  final String userId;
  final String approval;
  final DateTime bookedAt;
  final DateTime time;

  Appointment(
      {this.id,
      this.doctorId,
      this.userId,
      this.approval,
      this.bookedAt,
      this.time});
}
