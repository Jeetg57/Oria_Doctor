import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oria_doctor/Models/Doctor.dart';
import 'package:oria_doctor/services/database.dart';
import 'package:oria_doctor/shared/loadingWidget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final DatabaseService _databaseService = DatabaseService();

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://oria-68e38.appspot.com');
  PhotoViewScaleStateController scaleStateController;
  StorageUploadTask _uploadTask;
  @override
  void initState() {
    super.initState();
    scaleStateController = PhotoViewScaleStateController();
  }

  @override
  void dispose() {
    scaleStateController.dispose();
    super.dispose();
  }

  File _image;
  final picker = ImagePicker();

  void saveImage(uid) async {
    String filePath = '$uid-${DateTime.now()}.png';
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(_image);
    });
    final StorageTaskSnapshot downloadUrl = (await _uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    await _databaseService.updateImage(uid: uid, url: url);
  }

  Future getCameraImage(String uid) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        cropImage(uid);
      } else {
        print('No image selected.');
      }
    });
    print(_image);
  }

  Future getGalleryImage(String uid) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        cropImage(uid);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> cropImage(String uid) async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _image.path,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Colors.white,
        toolbarWidgetColor: Colors.black,
        toolbarTitle: "Crop Image",
        showCropGrid: true,
      ),
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );
    setState(() {
      _image = cropped ?? _image;
    });
    saveImage(uid);
  }

  Future removePic(String uid) async {
    await _databaseService.removeImage(uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DoctorFB>(context);
    void _showModalSheet(String uid, bool isPicturePresent) {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Container(
                child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  isPicturePresent == false
                      ? SizedBox()
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => removePic(uid)),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      icon: Icon(Icons.camera),
                      onPressed: () => getCameraImage(uid)),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      icon: Icon(Icons.collections),
                      onPressed: () => getGalleryImage(uid))
                ],
              ),
            ));
          });
    }

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
                    color: Colors.white38,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        bool isPicturePresent =
                            userData.pictureLink != null ? true : false;
                        _showModalSheet(userData.uid, isPicturePresent);
                      },
                    ),
                  )
                ],
                elevation: 0.0,
                title: Text(
                  "Profile",
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.white38,
                      fontSize: 24.0,
                      // letterSpacing: 1.5,
                      fontFamily: "Poppins"),
                ),
                backgroundColor: Colors.black,
              ),
              body: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(color: Colors.black),
                child: Hero(
                  tag: 'profPic',
                  child: PhotoView(
                      // initialScale: 1.0,
                      enableRotation: false,
                      tightMode: true,
                      scaleStateController: scaleStateController,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.contained,
                      imageProvider: userData.pictureLink != null
                          ? NetworkImage(
                              userData.pictureLink,
                            )
                          : AssetImage(
                              "assets/images/person_placeholder.png",
                            )),
                ),
              ),
            );
          } else {
            return LoadingWidget();
          }
        });
  }
}
