import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chat_clone/Pages/ChattingPage.dart';
import 'package:chat_clone/models/user.dart';
import 'package:chat_clone/Pages/AccountSettingsPage.dart';
import 'package:chat_clone/Widgets/ProgressWidget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  final String currentUserId;
  HomeScreen({Key key, @required this.currentUserId}) : super(key: key);
  @override
  State createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

//HomePageFunctions
TextEditingController searchEditingController= TextEditingController();
  homePageHeader() {
    return AppBar(
      automaticallyImplyLeading: false, //removes back button

      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.settings_applications,
                size: 30, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            })
      ],

      backgroundColor: Colors.lightBlueAccent,

      title: Container(
        margin: EdgeInsets.only(bottom: 4.0),
        child: TextFormField(
          style: TextStyle(fontSize: 18, color: Colors.white),
          controller: searchEditingController,
          
        ),
      ),
    );
  }

//signin functions
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<Null> logoutUser() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyApp()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // RaisedButton.icon(

    return Scaffold(
      appBar: homePageHeader(),
      body: RaisedButton.icon(
          onPressed: (logoutUser),
          icon: Icon(Icons.power_settings_new),
          label: Text('Log Out')),
    );
  }
}

class UserResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {}
}
