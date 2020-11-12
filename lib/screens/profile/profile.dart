import 'package:flutter/material.dart';
import 'package:oria_doctor/Models/Doctor.dart';
import 'package:oria_doctor/screens/profile/profile-picture.dart';
import 'package:oria_doctor/services/database.dart';
import 'package:oria_doctor/shared/loadingWidget.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DoctorFB>(context);
    return StreamBuilder<DoctorData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DoctorData userData = snapshot.data;
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
                  "Profile",
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
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://firebasestorage.googleapis.com/v0/b/oria-68e38.appspot.com/o/Blue%20Teal%20Movement%20Chiropractor%20Doctor%20Business%20Card.png?alt=media&token=963f58c5-3405-4253-87ee-f6c8493839a3"),
                              fit: BoxFit.cover)),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePicture()));
                          },
                          child: Container(
                            alignment: Alignment(0.0, 2.5),
                            child: Hero(
                                tag: 'profPic',
                                child: userData.pictureLink != null
                                    ? CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(userData.pictureLink),
                                        radius: 60.0,
                                      )
                                    : CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/person_placeholder.png"),
                                        radius: 60.0,
                                      )),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      userData.name,
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.blueGrey,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userData.city,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Poppins"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        elevation: 2.0,
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 30),
                            child: Text(
                              userData.specialty,
                              style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Poppins"),
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        userData.description,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black45,
                            fontFamily: "Poppins"),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      userData.study,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Poppins"),
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Ratings",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins"),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    userData.totalRatings.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Poppins"),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Appointment Price",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins"),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    userData.appointmentPrice.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Poppins"),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Colors.pink, Colors.redAccent]),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 100.0,
                                maxHeight: 40.0,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Poppins"),
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Colors.pink, Colors.redAccent]),
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: 100.0,
                                maxHeight: 40.0,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Edit Location",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Poppins"),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
            );
          } else {
            return LoadingWidget();
          }
        });
  }
}
