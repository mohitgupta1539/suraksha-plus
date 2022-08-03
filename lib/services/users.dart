import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:suraksha_plus/AllScreens/mainscreen.dart';

class UserManagement {
  storeNewUser(user, context) async {
    // print(user[0]);
    // var firebaseUser = await FirebaseAuth.instance.currentUser();
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser?.uid)
        .set({'name': user["name"],'email': user["email"], 'uid': user["uid"], "platitude": user["platitude"], "plongitude": user["plongitude"], "nlatitude": "", "nlongitude": "", "wimageurl": "", "pimageurl": "", "fimageurl": "", "aimageurl": "", "oimageurl": ""})
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen())))
        .catchError((e) {
          print(e);
        });
  }
}
