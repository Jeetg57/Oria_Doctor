import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:oria_doctor/services/auth.dart';
import 'package:oria_doctor/shared/constants.dart';
import 'package:oria_doctor/shared/loadingWidget.dart';
// import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
// import 'package:image_picker/image_picker.dart'; // For Image Picker
// import 'package:path/path.dart' as Path;

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final geo = Geoflutterfire();
  final number = TextEditingController();

  // final picker = ImagePicker();
  // File _image;
  // String _uploadedFileURL;
  // Future chooseFile() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = File(pickedFile.path);
  //   });
  // }

  // Future uploadFile() async {
  //   StorageReference storageReference = FirebaseStorage.instance
  //       .ref()
  //       .child('userImages/${Path.basename(_image.path)}}');
  //   StorageUploadTask uploadTask = storageReference.putFile(_image);
  //   await uploadTask.onComplete;
  //   print('File Uploaded');
  //   storageReference.getDownloadURL().then((fileURL) {
  //     setState(() {
  //       _uploadedFileURL = fileURL;
  //     });
  //   });
  // }

  // clearSelection() {
  //   setState(() {
  //     _image = null;
  //   });
  // }

  String email = "";
  String password = "";
  String error = "";
  String name = "";
  DateTime birthdate;
  String city = "";
  String address1 = "";
  String address2 = "";
  String specialty = "";
  String description = "";
  double price;
  String study = "";
  final String asset = "assets/images/mask-woman.svg";
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    double devHeight = MediaQuery.of(context).size.height;
    double devWidth = MediaQuery.of(context).size.width;

    return loading
        ? LoadingWidget()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                "Oria Doctor",
                style: TextStyle(color: Colors.black, fontSize: 24.0),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: Container(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                width: devWidth * 0.6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Create Account,",
                                      style: TextStyle(
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Let's get you signed up!",
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: devHeight * 0.05),
                              SvgPicture.asset(
                                asset,
                                width: devWidth * 0.2,
                              ),
                            ],
                          ),
                          SizedBox(height: devHeight * 0.05),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Full Name"),
                                validator: (val) {
                                  return val.isEmpty ? 'Enter your name' : null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    name = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              DateTimeField(
                                onDateSelected: (DateTime value) {
                                  setState(() {
                                    birthdate = value;
                                  });
                                },
                                enabled: true,
                                mode: DateFieldPickerMode.date,
                                initialDatePickerMode: DatePickerMode.year,
                                lastDate: DateTime(2020),
                                decoration: textInputDecoration,
                                label: "Birthdate",
                                selectedDate: birthdate,
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Specialty"),
                                validator: (val) {
                                  return val.isEmpty
                                      ? 'Enter your specialty'
                                      : null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    specialty = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Description"),
                                textCapitalization:
                                    TextCapitalization.sentences,

                                keyboardType: TextInputType.multiline,
                                minLines:
                                    1, //Normal textInputField will be displayed
                                maxLines:
                                    5, // when user presses enter it will adapt to it
                                onChanged: (val) {
                                  setState(() {
                                    description = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                decoration: textInputDecoration.copyWith(
                                    hintText: "City"),
                                validator: (val) {
                                  return val.isEmpty ? 'Enter your city' : null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    city = val;
                                  });
                                },
                              ),

                              SizedBox(height: 20.0),
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.streetAddress,
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Address 1"),
                                validator: (val) {
                                  return val.isEmpty
                                      ? 'Enter an address'
                                      : null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    address1 = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                keyboardType: TextInputType.streetAddress,
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Address 2"),
                                validator: (val) {
                                  return val.isEmpty
                                      ? 'Enter an address'
                                      : null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    address2 = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Where did you study?"),
                                validator: (val) {
                                  return val.isEmpty
                                      ? 'Please fill out this field'
                                      : null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    study = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0),

                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: number,
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Appointment Price"),
                                onSaved: (input) =>
                                    price = double.tryParse(input),
                              ),
                              // TextFormField(
                              //   keyboardType: TextInputType.number,
                              //   decoration: textInputDecoration.copyWith(
                              //       hintText: "Appointment Price"),
                              //   onChanged: (val) {
                              //     setState(() {
                              //       price = val as double;
                              //     });
                              //   },
                              // ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textCapitalization: TextCapitalization.none,
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Email"),
                                validator: (val) {
                                  return val.isEmpty ? 'Enter an email' : null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Password"),
                                validator: (val) => val.length < 6
                                    ? 'Password should be at least 6 characters'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                                obscureText: true,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          // Column(
                          //   children: <Widget>[
                          //     Text('Selected Image'),
                          //     _image != null
                          //         ? Image.file(_image)
                          //         // ? Image.asset(
                          //         //     _image.path,
                          //         //     height: 150,
                          //         //   )
                          //         : Container(height: 150),
                          //     _image == null
                          //         ? RaisedButton(
                          //             child: Text('Choose File'),
                          //             onPressed: chooseFile,
                          //             color: Colors.cyan,
                          //           )
                          //         : Container(),
                          //     _image != null
                          //         ? RaisedButton(
                          //             child: Text('Upload File'),
                          //             onPressed: uploadFile,
                          //             color: Colors.cyan,
                          //           )
                          //         : Container(),
                          //     _image != null
                          //         ? RaisedButton(
                          //             child: Text('Clear Selection'),
                          //             onPressed: clearSelection,
                          //           )
                          //         : Container(),
                          //     Text('Uploaded Image'),
                          //     _uploadedFileURL != null
                          //         ? Image.network(
                          //             _uploadedFileURL,
                          //             height: 150,
                          //           )
                          //         : Container(),
                          //   ],
                          // ),
                          Container(
                            height: 60.0,
                            child: RaisedButton(
                              onPressed: () async {
                                print(birthdate);
                                if (birthdate == null) {
                                  error = "Please enter a birthdate";
                                } else if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  Location location = new Location();

                                  bool _serviceEnabled;
                                  PermissionStatus _permissionGranted;
                                  LocationData _locationData;

                                  _serviceEnabled =
                                      await location.serviceEnabled();
                                  if (!_serviceEnabled) {
                                    _serviceEnabled =
                                        await location.requestService();
                                    if (!_serviceEnabled) {
                                      return;
                                    }
                                  }

                                  _permissionGranted =
                                      await location.hasPermission();
                                  if (_permissionGranted ==
                                      PermissionStatus.denied) {
                                    _permissionGranted =
                                        await location.requestPermission();
                                    if (_permissionGranted !=
                                        PermissionStatus.granted) {
                                      return;
                                    }
                                  }

                                  _locationData = await location.getLocation();
                                  GeoFirePoint myLocation = geo.point(
                                      latitude: _locationData.latitude,
                                      longitude: _locationData.longitude);
                                  dynamic result = await _authService
                                      .registerWithEmailAndPassword(
                                    email: email,
                                    address1: address1,
                                    address2: address2,
                                    birthdate: birthdate,
                                    city: city,
                                    description: description,
                                    location: myLocation,
                                    password: password,
                                    personName: name,
                                    price: price,
                                    specialty: specialty,
                                    study: study,
                                  );

                                  if (result == null) {
                                    setState(() {
                                      error = "Please supply a valid email";
                                      loading = false;
                                    });
                                  }
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(0, 255, 249, 0.6),
                                        // Color(0xff00FFB4),
                                        Color.fromRGBO(0, 255, 137, 0.6),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth: double.infinity,
                                      minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Register",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Center(
                            child: Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5.0),
                              FlatButton(
                                onPressed: () {
                                  widget.toggleView();
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ),
          );
  }
}
