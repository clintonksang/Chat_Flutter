import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:chat_clone/Widgets/ProgressWidget.dart';
import 'package:chat_clone/main.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.grey,
        title: Text('Account Settings',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,

      ),
      body: SettingsScreen(),

    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  State createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  //UserAccount functions

  TextEditingController nicknameTextEditingController;
  TextEditingController aboutMeTextEditingController;

  SharedPreferences preferences;
  String id = "";
  String nickname = "";
  String aboutMe = "";
  String photoURL = "";
  File imageFileAvatar;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    readDatafromLocal();
  }

  void readDatafromLocal() async {
    preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");
    nickname = preferences.getString("nickname");
    aboutMe = preferences.getString("aboutMe");
    photoURL = preferences.getString("photoURL");

    nicknameTextEditingController = TextEditingController(text: nickname);
    aboutMeTextEditingController = TextEditingController(text: aboutMe);

    setState(() {});
  }

  Future getImage() async {
    File newImageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);

    if (newImageFile != null) {
      setState(() {
        this.imageFileAvatar = newImageFile;
        isLoading = true;
      });
    }
    //  uploadImagetofirebasestorage;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          ///User Image Avatar
          ///
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Stack(children: [
                    (imageFileAvatar == null)
                        ? (photoURL != "")
                            ? Material(
                                //old user Imaage
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation(
                                          Colors.lightBlueAccent),
                                    ),
                                    width: 200,
                                    height: 200,
                                    padding: EdgeInsets.all(20),
                                  ),
                                  imageUrl: photoURL,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(125)),
                                clipBehavior: Clip.hardEdge,
                              )
                            : Icon(Icons.account_circle,
                                size: 90, color: Colors.grey)
                        : Material(
                            //Display New updated Image
                            child: Image.file(
                              imageFileAvatar,
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(125)),
                            clipBehavior: Clip.hardEdge,
                          ),
                    IconButton(
                      icon: Icon(
                        Icons.camera_enhance,
                        size: 100,
                        color: Colors.white54.withOpacity(0.3),
                      ),
                      onPressed: getImage,
                      padding: EdgeInsets.all(0),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.grey,
                      iconSize: 200,
                    )
                  ]),
                ),

                width: double.infinity,
                
                margin: EdgeInsets.all(20),
              )
            ],
          ),
        )
      ],
    );
  }
}
