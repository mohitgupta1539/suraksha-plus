import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:suraksha_plus/AllScreens/mainscreen.dart';

class UserManagementUrl {
  late String myUrl;
  storeNewUser(user, context) async {
    // print(user[0]);
    // var firebaseUser = await FirebaseAuth.instance.currentUser();
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        // myEmail = ds["email"];
        myUrl = ds["imageurl"];
        print("Url is :" + myUrl);
        // print(myUid);
      }).catchError((e) {
        print(e);
      });

      if(myUrl.length < 1) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser?.uid)
        .update({"nlongitude": user["nlongitude"], "nlatitude": user["nlatitude"], "imageurl": user["imageurl"]})
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen())))
        .catchError((e) {
          print(e);
        });
      } else {
        print("You have already solved the case");
        Navigator.of(context).pop();
        displayToastMessage("You have already uploaded an image", context);
      }
  }
}

displayToastMessage(String message, BuildContext context )
{
  Fluttertoast.showToast(msg: message);
}
