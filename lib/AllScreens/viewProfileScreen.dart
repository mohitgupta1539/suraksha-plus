import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:suraksha_plus/AllScreens/Divider.dart';
import 'package:suraksha_plus/AllWidgets/progressDialog.dart';

class viewProfile extends StatefulWidget {
  static const String idScreen = "profileScreen";
  const viewProfile({Key? key}) : super(key: key);

  @override
  State<viewProfile> createState() => _viewProfileState();
}

class _viewProfileState extends State<viewProfile> {

  
  late String myName;
  late String myEmail;
  // late String myUid;
  late String myLatitdue;
  late String myLongitude;
  late String mynLongitude;
  late String mynLatitdue;
  late String myImageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                    return ProgressDialog(message: "Fetching, Please wait.",);
                 // return Text("Loading data...Please wait");
                    {
                      return (
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              SizedBox(height: 45.0,),
                              myImageUrl.length > 2 ? Image.network(myImageUrl) : Image.asset("images/images/user_icon.png", height: 80.0, width: 80.0,),

                              SizedBox(height: 12.0,),
                              ListTile(
                                leading: Icon(Icons.person_outline),
                                title:Text("$myName", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),

                              SizedBox(height: 4.0,),
                              ListTile(
                                leading: Icon(Icons.email_outlined),
                                title:Text("$myEmail", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                              ),

                              // SizedBox(height: 4.0,),
                              // ListTile(
                              //   leading: Icon(Icons.person_add_outlined),
                              //   title:Text("$myUid", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                              // ),

                              SizedBox(height: 4.0,),
                              ListTile(
                                leading: Icon(Icons.location_on),
                                title:Text("Latitude: $myLatitdue", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                              ),

                              SizedBox(height: 4.0,),
                              ListTile(
                                leading: Icon(Icons.location_on_sharp),
                                title:Text("Longitude: $myLongitude", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                              ),

                              SizedBox(height: 4.0,),
                              ListTile(
                                leading: Icon(Icons.location_on_sharp),
                                title:Text("new Longitude: $mynLongitude", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                              ),

                              SizedBox(height: 4.0,),
                              ListTile(
                                leading: Icon(Icons.location_on_sharp),
                                title:Text("new Longitude: $mynLatitdue", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                              ),
                            ],
                          )
                        )
                      );
                    }
                  },
              ),
        ),
      ),
    );
  }
  _fetch() async {
    User? firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myEmail = ds["email"];
        myImageUrl = ds["imageurl"];
        myName = ds["name"];
        // myUid = ds["uid"];
        myLatitdue = ds["platitude"];
        myLongitude = ds["plongitude"];
        mynLatitdue = ds["nlatitude"];
        mynLongitude = ds["nlongitude"];
        // print(myName);
        // print(myEmail);
        // print(myUid);
      }).catchError((e) {
        print(e);
      });
  }
}