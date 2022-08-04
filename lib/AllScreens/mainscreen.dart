import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:suraksha_plus/AllScreens/aboutPageScreen.dart';
import 'package:suraksha_plus/AllScreens/imagesUpload/uploadImagePage.dart';
import 'package:suraksha_plus/AllScreens/loginScreen.dart';
import 'package:suraksha_plus/AllScreens/viewHistoryPage.dart';
import 'package:suraksha_plus/AllScreens/viewProfileScreen.dart';
import 'package:suraksha_plus/configMaps.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:suraksha_plus/AllScreens/Divider.dart';
import 'package:suraksha_plus/services/userAddressUpdate.dart';

CollectionReference _UserData = FirebaseFirestore.instance.collection('users');


class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  
  late String myName;
  late String myImageUrl = "";

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 165.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      myImageUrl.length > 2 ? Image.network(myImageUrl, height: 85.0, width: 85.0,) : Image.asset("images/images/user_icon.png", height: 65.0, width: 65.0,),
                      // Image.asset("images/images/user_icon.png", height: 65.0, width: 65.0,),
                      SizedBox(width: 16.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 19.0,),
                          Container(
                            child: FutureBuilder(
                              future: _fetch(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState != ConnectionState.done)
                                return Text("Loading data...Please wait");
                                return Text("User $myName", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),
                                );
                                },
                                ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              DividerWidget(),

              SizedBox(height: 12.0,),

              // Drawer Body Controller
              GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => viewHistory(),),);
                },
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text("History", style: TextStyle(fontSize: 15.0,),),
                ),
              ),
              GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => viewProfile(),),);
                },
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Visit Profile", style: TextStyle(fontSize: 15.0,),),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => aboutPage(),),);
                },
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About", style: TextStyle(fontSize: 15.0,),),
                ),
              ),
              GestureDetector(
                onTap: ()
                {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                },
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Sign Out", style: TextStyle(fontSize: 15.0,),),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [

          // HamburgerButton for Drawer
          Positioned(
            child: Column(
            children: [
              SizedBox(height: 8.0,),
              ListTile(
                leading: Icon(Icons.health_and_safety_sharp),
                title:Text("This App will help \nto solve the case", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
              ),
            ],
          ),
            // child: GestureDetector(
            //   onTap: ()
            //   {
            //     // scaffoldKey.currentState?.openDrawer();
            //   },
            //   child: Container(
                
            //     child: CircleAvatar(
            //       backgroundColor: Colors.blue,
            //       child: Icon(Icons.menu, color: Colors.blue,),
            //       radius: 20.0,
            //     ),
            //   ),
            // ),
          ),

          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 400.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(19.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  )
                ]
              ),

              
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 19.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.0),
                    Text("Hello, ", style: TextStyle(fontSize: 12.0,),),
                    Text("Thanks to Come here, ", style: TextStyle(fontSize: 20.0, fontFamily: "Brand-Bold"),),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              )
                            ]
                        ),
                        // child: Padding(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: Row(
                        //     children: [
                        //       Icon(Icons.search, color: Colors.blueAccent,),
                        //       SizedBox(width: 10.0,),
                        //       Text("Search Drop off")
                        //     ],
                        //   ),
                        // ),
                      ),
                    ),

                    
                    DividerWidget(),
                    SizedBox(height: 15.0,),
                    Row(children: [
                      ElevatedButton(onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => UploadImagePage(),),);
                      }, child: Text("Uplaod Case", style: TextStyle(fontSize: 30.0, fontFamily: "Brand-Bold"),),
                      ),
                    ],),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  _fetch() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myName = ds["name"];
        myImageUrl = ds["imageurl"];
        print(myName);
      }).catchError((e) {
        print(e);
      });
  }
}
