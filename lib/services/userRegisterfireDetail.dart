import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:suraksha_plus/AllScreens/mainscreen.dart';

class UserManagementCaseUrl {
  late String myUrl;
  storeNewUser(user, context) async {
    // print(user["edetails"] + user["datetime"]);
    // var firebaseUser = await FirebaseAuth.instance.currentUser();
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    // if (firebaseUser != null)
    //   await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get().then((ds) {
    //     myUrl = ds["imageurl"];
    //     // print("Url is :" + myUrl);
    //     // print(myUid);
    //   }).catchError((e) {
    //     print(e);
    //   });

      
        if(user["caseType"] == "womenDetails"){
          if (firebaseUser != null)
          await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get().then((ds) {
            myUrl = ds["wimageurl"];
         print("Url is :" + myUrl);
         // print(myUid);
          }).catchError((e) {
            print(e);
            });
          if(myUrl.length < 2) {
            FirebaseFirestore.instance.collection('users').doc(firebaseUser?.uid).update({"wimageurl": user["imageurl"]})
            // .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())))
            .catchError((e) {
              print(e);
            });
            FirebaseFirestore.instance
            .collection('womenDetails')
            .doc(firebaseUser?.uid)
            .set({'nlongitude': user["nlongitude"],'nlatitude': user["nlatitude"], 'ruid': firebaseUser?.uid, "edetails": user["edetails"], "datetime": user["datetime"], "wimageurl": user["imageurl"]})
            .then((value) => {
              displayToastMessage("Thankyou for Solving this case", context),
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()))
              }
            ).catchError((e) {
              print(e);
              });
          }
        } else if(user["caseType"] == "policeDetails"){
          if (firebaseUser != null)
          await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get().then((ds) {
            myUrl = ds["pimageurl"];
         // print("Url is :" + myUrl);
         // print(myUid);
          }).catchError((e) {
            print(e);
            });
          if(myUrl.length < 2) {
            FirebaseFirestore.instance.collection('users').doc(firebaseUser?.uid).update({"pimageurl": user["imageurl"]})
            // .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())))
            .catchError((e) {
              print(e);
            });
            FirebaseFirestore.instance
            .collection('policeDetails')
            .doc(firebaseUser?.uid)
            .set({'nlongitude': user["nlongitude"],'nlatitude': user["nlatitude"], 'ruid': firebaseUser?.uid, "edetails": user["edetails"], "datetime": user["datetime"], "pimageurl": user["pimageurl"]})
            .then((value) => {
              displayToastMessage("Thankyou for Solving this case", context),
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()))
              }
            ).catchError((e) {
              print(e);
              });
          }
        } else if(user["caseType"] == "firesDetails"){
          if (firebaseUser != null)
          await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get().then((ds) {
            myUrl = ds["fimageurl"];
         // print("Url is :" + myUrl);
         // print(myUid);
          }).catchError((e) {
            print(e);
            });
          if(myUrl.length < 2) {
            FirebaseFirestore.instance.collection('users').doc(firebaseUser?.uid).update({"fimageurl": user["imageurl"]})
            // .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())))
            .catchError((e) {
              print(e);
            });
            FirebaseFirestore.instance
            .collection('firesDetails')
            .doc(firebaseUser?.uid)
            .set({'nlongitude': user["nlongitude"],'nlatitude': user["nlatitude"], 'ruid': firebaseUser?.uid, "edetails": user["edetails"], "datetime": user["datetime"], "fimageurl": user["fimageurl"]})
            .then((value) => {
              displayToastMessage("Thankyou for Solving this case", context),
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()))
              }
            ).catchError((e) {
              print(e);
              });
          }
        } else if(user["caseType"] == "ambulanceDetails"){
          if (firebaseUser != null)
          await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get().then((ds) {
            myUrl = ds["aimageurl"];
         // print("Url is :" + myUrl);
         // print(myUid);
          }).catchError((e) {
            print(e);
            });
          if(myUrl.length < 2) {
            FirebaseFirestore.instance.collection('users').doc(firebaseUser?.uid).update({"aimageurl": user["imageurl"]})
            // .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())))
            .catchError((e) {
              print(e);
            });
            FirebaseFirestore.instance
            .collection('ambulanceDetails')
            .doc(firebaseUser?.uid)
            .set({'nlongitude': user["nlongitude"],'nlatitude': user["nlatitude"], 'ruid': firebaseUser?.uid, "edetails": user["edetails"], "datetime": user["datetime"], "aimageurl": user["aimageurl"]})
            .then((value) => {
              displayToastMessage("Thankyou for Solving this case", context),
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()))
              }
            ).catchError((e) {
              print(e);
              });
          }
        } else if(user["caseType"] == "otherDetails"){
          if (firebaseUser != null)
          await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get().then((ds) {
            myUrl = ds["oimageurl"];
         // print("Url is :" + myUrl);
         // print(myUid);
          }).catchError((e) {
            print(e);
            });
          if(myUrl.length < 2) {
            FirebaseFirestore.instance.collection('users').doc(firebaseUser?.uid).update({"oimageurl": user["imageurl"]})
            // .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())))
            .catchError((e) {
              print(e);
            });
            FirebaseFirestore.instance
            .collection('otherDetails')
            .doc(firebaseUser?.uid)
            .set({'nlongitude': user["nlongitude"],'nlatitude': user["nlatitude"], 'ruid': firebaseUser?.uid, "edetails": user["edetails"], "datetime": user["datetime"], "oimageurl": user["oimageurl"]})
            .then((value) => {
              displayToastMessage("Thankyou for Solving this case", context),
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()))
              }
            ).catchError((e) {
              print(e);
              });
          }
        }
  }
}
displayToastMessage(String message, BuildContext context )
{
  Fluttertoast.showToast(msg: message);
}
