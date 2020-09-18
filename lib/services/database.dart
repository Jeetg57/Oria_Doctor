import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:oria_doctor/Models/Doctor.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final StorageReference storageReferenceUser =
      FirebaseStorage().ref().child("userImages");

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('doctor-details');

  final CollectionReference doctorsCollection =
      FirebaseFirestore.instance.collection('doctors');

  final CollectionReference appointmentCollection =
      FirebaseFirestore.instance.collection('appointments');

  final CollectionReference doctorScheduleCollection =
      FirebaseFirestore.instance.collection('doctor_schedule');
  final CollectionReference testScheduleCollection =
      FirebaseFirestore.instance.collection('test');

  final geo = Geoflutterfire();
  Future setAppointment(
      {String uid, String doctorId, DateTime dateTime}) async {
    try {
      await appointmentCollection.doc().set({
        "userId": uid,
        "doctorId": doctorId,
        "time": dateTime,
        "bookedAt": DateTime.now(),
        "approval": "Pending"
      });
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Future setLocation({String uid}) async {
  //   try {
  //     GeoFirePoint myLocation =
  //         geo.point(latitude: -1.269650, longitude: 36.808920);
  //     await testScheduleCollection.doc().set({
  //       "userId": uid,
  //       "name": "JeetGohil",
  //       "bookedAt": DateTime.now(),
  //       "position": myLocation.data
  //     });
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  Future setUserDetails(String name, DateTime birthdate, String email) async {
    return await userCollection
        .doc(uid)
        .set({"email": email, "name": name, "birthdate": birthdate});
  }

  // Future getUserDetails()
  //brew list from snapshot
  // List<DoctorData> _doctorListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((document) {
  //     return DoctorData(
  //       id: document.id,
  //       name: document.data()['name'] ?? "",
  //       specialty: document.data()['specialty'] ?? "",
  //       appointmentPrice: document.data()['appointmentPrice'] ?? 0,
  //       city: document.data()['city'] ?? "",
  //       totalRatings: document.data()['totalRatings'] ?? 0,
  //       numRated: document.data()['numRated'] ?? 0,
  //     );
  //   }).toList();
  // }

  // user data from snapshot
  DoctorData _docDataFromSnapshot(DocumentSnapshot snapshot) {
    return DoctorData(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      profilePicture: snapshot.data()['profilePicture'],
      // birthdate: snapshot.data['birthdate']);
    );
  }

  // DoctorData _doctorDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return DoctorData(
  //     name: snapshot.data()['name'] ?? "",
  //     specialty: snapshot.data()['specialty'] ?? "",
  //     appointmentPrice: snapshot.data()['appointmentPrice'] ?? 0,
  //     location: snapshot.data()['location'] ?? 0,
  //     experience: snapshot.data()['experience'] ?? 0,
  //     description: snapshot.data()['description'] ?? "",
  //     numRated: snapshot.data()['numRated'] ?? 0,
  //     pictureLink: snapshot.data()['pictureLink'] ?? "",
  //     totalRatings: snapshot.data()['totalRatings'] ?? 0,
  //     location1: snapshot.data()['location1'] ?? "",
  //     location2: snapshot.data()['location2'] ?? "",
  //     city: snapshot.data()['city'] ?? "",
  //     conditionsTreated: snapshot.data()['conditionsTreated'] ?? [],
  //     study: snapshot.data()['study'] ?? "",
  //   );
  // }

  // // get brews stream
  // Stream<List<DoctorData>> get doctors {
  //   return doctorsCollection.snapshots().map(_doctorListFromSnapshot);
  // }

  // // get user doc stream
  Stream<DoctorData> get userData {
    return userCollection.doc(uid).snapshots().map(_docDataFromSnapshot);
  }

  // Stream<List<DoctorData>> doctorDocs(center, double radius) {
  //   return geo
  //       .collection(collectionRef: doctorsCollection)
  //       .within(
  //           center: center, radius: radius, field: "position", strictMode: true)
  //       .map(_doctorListFromSnapshots);
  // }

  // List<DoctorData> _doctorListFromSnapshots(List<DocumentSnapshot> snapshot) {
  //   return snapshot.map((DocumentSnapshot document) {
  //     return DoctorData(
  //       id: document.id,
  //       name: document.data()['name'] ?? "",
  //       specialty: document.data()['specialty'] ?? "",
  //       appointmentPrice: document.data()['appointmentPrice'] ?? 0,
  //       city: document.data()['city'] ?? "",
  //       totalRatings: document.data()['totalRatings'] ?? 0,
  //       numRated: document.data()['numRated'] ?? 0,
  //     );
  //   }).toList();
  // }

  // Stream<DoctorData> doctorData(doctorId) {
  //   return doctorsCollection
  //       .doc(doctorId)
  //       .snapshots()
  //       .map(_doctorDataFromSnapshot);
  // }

  // Stream<List<Appointment>> appointmentData(userId) {
  //   return appointmentCollection
  //       .where("userId", isEqualTo: userId)
  //       .orderBy("time")
  //       .where("time", isGreaterThanOrEqualTo: Timestamp.now())
  //       .orderBy("approval")
  //       .snapshots()
  //       .map(_appointmentDataFromSnapshot);
  // }

  // List<Appointment> _appointmentDataFromSnapshot(QuerySnapshot snapshot) {
  //   try {
  //     return snapshot.docs.map((document) {
  //       DateTime bookedAt =
  //           DateTime.parse(document.data()['bookedAt'].toDate().toString());
  //       DateTime time =
  //           DateTime.parse(document.data()['time'].toDate().toString());

  //       return Appointment(
  //           userId: document.data()['userId'] ?? "",
  //           approval: document.data()['approval'] ?? "",
  //           bookedAt: bookedAt,
  //           time: time,
  //           doctorId: document.data()['doctorId'] ?? "");
  //     }).toList();
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
}