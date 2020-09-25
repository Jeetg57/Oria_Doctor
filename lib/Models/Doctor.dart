class DoctorFB {
  final String uid;

  DoctorFB({this.uid});
}

class DoctorData {
  final String uid;
  final String name;
  final String birthdate;
  final String email;
  final String profilePicture;
  final num appointmentPrice;
  final location;
  final conditionsTreated;
  final String description;
  final int numRated;
  final int totalRatings;
  final String pictureLink;
  final int experience;
  final String city;
  final String location1;
  final String location2;
  final String study;
  final String specialty;

  DoctorData(
      {this.uid,
      this.name,
      this.birthdate,
      this.email,
      this.profilePicture,
      this.appointmentPrice,
      this.location,
      this.conditionsTreated,
      this.description,
      this.numRated,
      this.totalRatings,
      this.pictureLink,
      this.experience,
      this.city,
      this.location1,
      this.location2,
      this.study,
      this.specialty});
}
