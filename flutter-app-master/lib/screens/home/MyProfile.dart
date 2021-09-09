import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/userr.dart';
import 'package:flutter_app/screens/shared/loading.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'EditInfoPage.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final AuthService _auth = AuthService();
  String imageUrl;
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;


    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _storage.ref()
            .child('folderName/imageName')
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }

    } else {
      print('Grant Permissions and try again');
    }
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData user = snapshot.data;
          if (snapshot.hasData) {
            return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),

                      child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20, 0, 20, 10),
                                child: Center(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 80,
                                    child: imageUrl != null? ClipRRect(child :Image.network(imageUrl)):Text(
                                      'Image',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ), //Text
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => uploadImage(),
                                icon: Icon(Icons.camera_enhance),

                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black,
                                    letterSpacing: 1.0
                                ),
                              ),
                              SizedBox(height: 8.0,),
                              Text(
                                user.location,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8.0,),
                              Text(
                                user.contact,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextButton.icon(
                                  style: TextButton.styleFrom(
                                    primary: Colors.black, // background
                                    // foreground
                                  ),
                                  label: Text(
                                    'Edit Info',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                  ),
                                  icon: Icon(Icons.settings),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditInfo()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    Card(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          primary: Colors.black, // background
                          // foreground
                        ),
                        onPressed: () async {
                          await _auth.signOut();
                        },
                        icon: Icon(Icons.account_circle_rounded),
                        label: Text('Signout'),
                      ),
                    ),
                  ],
                )
            );
          }
          else {
            return Loading();
          }
        }
    );
  }
}
