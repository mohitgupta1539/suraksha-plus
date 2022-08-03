import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:suraksha_plus/AllScreens/loginScreen.dart';
import 'package:suraksha_plus/AllScreens/mainscreen.dart';
import 'package:suraksha_plus/AllWidgets/progressDialog.dart';
import 'package:suraksha_plus/services/users.dart';

import '../main.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen = "register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  
  // location as service feature
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
      
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 45.0,),
              Image(image: AssetImage("images/images/logo.png"),
                width: 350.0,
                height: 350.0,
                alignment: Alignment.center,
              ),

              SizedBox(height: 1.0,),
              Text(
                "Register",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 1.0,),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Phone Number",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 1.0,),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          )
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),

                    SizedBox(height: 10.0,),
                    RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(fontSize: 19.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: () async {
                        // print("LoggedIn button Clicked");
                        if(nameTextEditingController.text.length < 4)
                          {
                            displayToastMessage("Name must be atleast 3 characters.", context);
                          } else if(!emailTextEditingController.text.contains("@")) {
                            displayToastMessage("Email address is not valid.", context);
                        } else if(phoneTextEditingController.text.isEmpty) {
                            displayToastMessage("Phone Number is mandatory", context);
                        } else if(passwordTextEditingController.text.length < 6) {
                            displayToastMessage("Password must be atleast 6 Characters.", context);
                        }  else {
                          Position position = await _getGeoLocationPosition();
                          print("Your Latitude is :" + position.latitude.toString());
                          print("Your longitude is:" + position.longitude.toString());
                          registerNewUser(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: ()
                {
                  // print("Clicked");
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: Text(
                  "Already have an Account? Sigin Here",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Registering, Please wait.",);
        });

      final User? firebaseUser = (await _firebaseAuth
          .createUserWithEmailAndPassword(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text
      ).catchError((errMsg) {
        Navigator.pop(context);
        displayToastMessage("Error: " + errMsg.toString(), context);
      })).user;
      
      // accessing the locaiton of user
      Position position = await _getGeoLocationPosition();
      // this is used when realtime database is used
      if (firebaseUser != null) // user created
          {
        // save user to database
        Map userDataMap = {
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": phoneTextEditingController.text.trim(),
          "uid": firebaseUser.uid,
          "platitude": position.latitude.toString(),
          "plongitude": position.longitude.toString(),
        };
        usersRef.child(firebaseUser.uid).set(userDataMap);
        UserManagement().storeNewUser(userDataMap, context);

        displayToastMessage("Congratulation, your account has been created.", context);

        Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
      }
    else {
        Navigator.pop(context);
      // error occured - display error
      displayToastMessage("New user has not been created", context);
    }
  }

}
displayToastMessage(String message, BuildContext context )
{
  Fluttertoast.showToast(msg: message);
}