import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:suraksha_plus/AllScreens/Divider.dart';
import 'package:suraksha_plus/AllWidgets/progressDialog.dart';

class viewHistory extends StatefulWidget {
  static const String idScreen = "profileScreen";
  const viewHistory({Key? key}) : super(key: key);

  @override
  State<viewHistory> createState() => _viewHistoryState();
}

class _viewHistoryState extends State<viewHistory> {

  // women
  late String mywName;
  late String mywImageUrl = "";
  // late String myUid;
  late String mywDatetime;
  late String mywnDatetime;
  late String mywEdetails;
  late String mywnLongitude;
  late String mywnLatitdue;
  late String mywnDate;
  late String mywnTime;

  // police
  late String mypName;
  late String mypImageUrl = "";
  // late String myUid;
  late String mypDatetime;
  late String mypnDatetime;
  late String mypEdetails;
  late String mypnLongitude;
  late String mypnLatitdue;
  late String mypnDate;
  late String mypnTime;

  // fire
  late String myfName;
  late String myfImageUrl = "";
  // late String myUid;
  late String myfDatetime;
  late String myfnDatetime;
  late String myfEdetails;
  late String myfnLongitude;
  late String myfnLatitdue;
  late String myfnDate;
  late String myfnTime;

  // ambulance
  late String myaName;
  late String myaImageUrl = "";
  // late String myUid;
  late String myaDatetime;
  late String myanDatetime;
  late String myaEdetails;
  late String myanLongitude;
  late String myanLatitdue;
  late String myanDate;
  late String myanTime;

  // other
  late String myoName;
  late String myoImageUrl = "";
  // late String myUid;
  late String myoDatetime;
  late String myonDatetime;
  late String myoEdetails;
  late String myonLongitude;
  late String myonLatitdue;
  late String myonDate;
  late String myonTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cases, In that You helped"),
      ),

      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 5.0,),
          TextButton(onPressed: () => {
            // showAlertDialog(context),
            showDialog(context: context, builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.all(0.0),
            title: Text('Women Case, that You Helped'),
            content: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(2.0,),
                  child: FutureBuilder(
                    future: _fetchWomenDetails(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState != ConnectionState.done)
                      return ProgressDialog(message: "Fetching, Please wait.",);
                      {
                        return(
                          mywImageUrl.length > 2 ?
                          Padding(
                            padding: EdgeInsets.all(2.0,),
                          child: Column(
                            children: [
                              SizedBox(height: 1.0,),
                              Image.network(mywImageUrl, height: 300.0, width: 300.0,),
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.location_on_sharp),
                                title:Text("Latitude: $mywnLatitdue", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),

                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.location_on_sharp),
                                title:Text("Longitude: $mywnLongitude", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                                
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.date_range_sharp),
                                title:Text("$mywDatetime", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),

                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.timer),
                                title:Text("$mywnTime", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                              
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.data_saver_on_rounded),
                                title:Text("Details: $mywEdetails", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                              ],
                            ),
                          )
                          :AlertDialog(
                            title: Text("Thanks, \nPlease help \nby providing Information"),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok"),),
                            ],
                          )
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            actions: [
              // TextButton(
              //   onPressed: () => Navigator.pop(context), 
              //   child: Text("Cancel"),),
              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: Text("Ok"),),
            ],
            ),
            ),
            }, 
            child: Text("Women", style: TextStyle(fontSize: 20.0,),),
          ),

          SizedBox(height: 5.0,),
          TextButton(onPressed: () => {
            // showAlertDialog(context),
            showDialog(context: context, builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.all(0.0),
            title: Text('Police Case, that You Helped'),
            content: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(2.0,),
                  child: FutureBuilder(
                    future: _fetchPoliceDetails(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState != ConnectionState.done)
                      return ProgressDialog(message: "Fetching, Please wait.",);
                      {
                        return(
                          mypImageUrl.length > 2 ?
                          Padding(
                            padding: EdgeInsets.all(2.0,),
                          child: Column(
                            children: [
                              SizedBox(height: 1.0,),
                              Image.network(mypImageUrl, height: 300.0, width: 300.0,),
                              // FadeInImage.assetNetwork(placeholder: "images/images/user_icon.png", image: mypImageUrl),
                              // mypImageUrl != null? Image.network(mypImageUrl, height: 300.0, width: 300.0,) : Image.asset("images/images/user_icon.png", height: 300.0, width: 300.0,),
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.location_on_sharp),
                                title:Text("Latitude: $mypnLatitdue", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),

                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.location_on_sharp),
                                title:Text("Longitude: $mypnLongitude", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                                
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.date_range_sharp),
                                title:Text("$mypDatetime", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),

                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.timer),
                                title:Text("$mypnTime", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                              
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.data_saver_on_rounded),
                                title:Text("Details: $mypEdetails", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                              ],
                            ),
                          ) : 
                          // ProgressDialog(message: "message")
                          AlertDialog(
                            title: Text("Thanks, \nPlease help \nby providing Information"),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok"),),
                            ],
                          )
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            actions: [
              // TextButton(
              //   onPressed: () => Navigator.pop(context), 
              //   child: Text("Cancel"),),
              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: Text("Ok"),),
            ],
            ),
            ),
            }, 
            child: Text("Police", style: TextStyle(fontSize: 20.0,),),
          ),


          SizedBox(height: 5.0,),
          TextButton(onPressed: () => {
            // showAlertDialog(context),
            showDialog(context: context, builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.all(0.0),
            title: Text('Fire Case, that You Helped'),
            content: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(2.0,),
                  child: FutureBuilder(
                    future: _fetchFireDetails(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState != ConnectionState.done)
                      return ProgressDialog(message: "Fetching, Please wait.",);
                      {
                        return(
                          myfImageUrl.length > 2 ?
                          Padding(
                            padding: EdgeInsets.all(2.0,),
                          child: Column(
                            children: [
                              SizedBox(height: 1.0,),
                              Image.network(myfImageUrl, height: 300.0, width: 300.0,),
                              // myaImageUrl != null? Image.network(myfImageUrl, height: 300.0, width: 300.0,) : Image.asset("images/images/user_icon.png", height: 300.0, width: 300.0,),
                              // Image.network(myfImageUrl, height: 300.0, width: 300.0,),
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.location_on_sharp),
                                title:Text("Latitude: $myfnLatitdue", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),

                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.location_on_sharp),
                                title:Text("Longitude: $myfnLongitude", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                                
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.date_range_sharp),
                                title:Text("$myfDatetime", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),

                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.timer),
                                title:Text("$myfnTime", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                              
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.data_saver_on_rounded),
                                title:Text("Details: $myfEdetails", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                              ],
                            ),
                          )
                          : AlertDialog(
                            title: Text("Thanks, \nPlease help \nby providing Information"),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: Text("ok"),),
                            ],
                          )
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            actions: [
              // TextButton(
              //   onPressed: () => Navigator.pop(context), 
              //   child: Text("Cancel"),),
              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: Text("Ok"),),
            ],
            ),
            ),
            }, 
            child: Text("Fire", style: TextStyle(fontSize: 20.0,),),
          ),

          SizedBox(height: 5.0,),
          TextButton(onPressed: () => {
            // showAlertDialog(context),
            showDialog(context: context, builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.all(0.0),
            title: Text('Ambulance Case, that You Helped'),
            content: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(2.0,),
                  child: FutureBuilder(
                    future: _fetchAmbulanceDetails(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState != ConnectionState.done)
                      return ProgressDialog(message: "Fetching, Please wait.",);
                      {
                        return(
                          myaImageUrl.length > 2 ?
                          Padding(
                            padding: EdgeInsets.all(2.0,),
                          child: Column(
                            children: [
                              SizedBox(height: 1.0,),
                              Image.network(myaImageUrl, height: 300.0, width: 300.0,),
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.location_on_sharp),
                                title:Text("Latitude: $myanLatitdue", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),

                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.location_on_sharp),
                                title:Text("Longitude: $myanLongitude", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                                
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.date_range_sharp),
                                title:Text("$myaDatetime", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),

                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.timer),
                                title:Text("$myanTime", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                              
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.data_saver_on_rounded),
                                title:Text("Details: $myaEdetails", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                              ],
                            ),
                          )
                          :AlertDialog(
                            title: Text("Thanks, \nPlease help \nby providing Information"),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok"),),
                            ],
                          )
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            actions: [
              // TextButton(
              //   onPressed: () => Navigator.pop(context), 
              //   child: Text("Cancel"),),
              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: Text("Ok"),),
            ],
            ),
            ),
            }, 
            child: Text("Ambulance", style: TextStyle(fontSize: 20.0,),),
          ),

          SizedBox(height: 5.0,),
          TextButton(onPressed: () => {
            // showAlertDialog(context),
            showDialog(context: context, builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              contentPadding: EdgeInsets.all(0.0),
            title: Text('Other Case, that You Helped'),
            content: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(2.0,),
                  child: FutureBuilder(
                    future: _fetchOtherDetails(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState != ConnectionState.done)
                      return ProgressDialog(message: "Fetching, Please wait.",);
                      {
                        return(
                          myoImageUrl.length > 2 ?
                          Padding(
                            padding: EdgeInsets.all(2.0,),
                          child: Column(
                            children: [
                              SizedBox(height: 1.0,),
                              Image.network(myoImageUrl, height: 300.0, width: 300.0,),
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.location_on_sharp),
                                title:Text("Latitude: $myonLatitdue", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),

                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.location_on_sharp),
                                title:Text("Longitude: $myonLongitude", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                                
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.date_range_sharp),
                                title:Text("$myoDatetime", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),

                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.timer),
                                title:Text("$myonTime", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                              
                              SizedBox(height: 1.0,),
                              ListTile(
                                leading: Icon(Icons.data_saver_on_rounded),
                                title:Text("Details: $myoEdetails", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
                                ),
                              ],
                            ),
                          )
                          :AlertDialog(
                            title: Text("Thanks, \nPlease help \nby providing Information"),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok"),),
                            ],
                          )
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            actions: [
              // TextButton(
              //   onPressed: () => Navigator.pop(context), 
              //   child: Text("Cancel"),),
              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: Text("Ok"),),
            ],
            ),
            ),
            }, 
            child: Text("Other Cases", style: TextStyle(fontSize: 20.0,),),
          ),
        ],
        ),
      ),
    );
        
  }

  _fetchWomenDetails() async {
    User? firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('womenDetails')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        mywDatetime = ds["datetime"];
        // print(myDatetime);
        mywnDatetime = ds["datetime"];
        mywDatetime = mywDatetime.substring(0,10);
        mywnDate = mywDatetime.substring(0, 10);
        mywnTime = mywnDatetime.substring(10, 19);
        // print(myDatetime);
        mywEdetails = ds["edetails"];
        // myUid = ds["uid"];
        mywImageUrl = ds["wimageurl"];
        // myLongitude = ds["plongitude"];
        mywnLatitdue = ds["nlatitude"];
        mywnLongitude = ds["nlongitude"];
        // print(myName);
        // print(myEmail);
        // print(myUid);
      }).catchError((e) {
        print(e);
      });
  }

  _fetchPoliceDetails() async {
    User? firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('policeDetails')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        mypDatetime = ds["datetime"];
        // print(myDatetime);
        mypnDatetime = ds["datetime"];
        mypDatetime = mypDatetime.substring(0,10);
        mypnDate = mypDatetime.substring(0, 10);
        mypnTime = mypnDatetime.substring(10, 19);
        // print(myDatetime);
        mypEdetails = ds["edetails"];
        // myUid = ds["uid"];
        mypImageUrl = ds["pimageurl"];
        // myLongitude = ds["plongitude"];
        mypnLatitdue = ds["nlatitude"];
        mypnLongitude = ds["nlongitude"];
        // print(myName);
        // print(myEmail);
        // print(myUid);
      }).catchError((e) {
        print(e);
      });
  }

  _fetchFireDetails() async {
    User? firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('firesDetails')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myfDatetime = ds["datetime"];
        // print(myDatetime);
        myfnDatetime = ds["datetime"];
        myfDatetime = myfDatetime.substring(0,10);
        myfnDate = myfDatetime.substring(0, 10);
        myfnTime = myfnDatetime.substring(10, 19);
        // print(myDatetime);
        myfEdetails = ds["edetails"];
        // myUid = ds["uid"];
        myfImageUrl = ds["fimageurl"];
        // myLongitude = ds["plongitude"];
        myfnLatitdue = ds["nlatitude"];
        myfnLongitude = ds["nlongitude"];
        // print(myName);
        // print(myEmail);
        // print(myUid);
      }).catchError((e) {
        print(e);
      });
  }

  _fetchAmbulanceDetails() async {
    User? firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('ambulanceDetails')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myaDatetime = ds["datetime"];
        // print(myDatetime);
        myanDatetime = ds["datetime"];
        myaDatetime = myaDatetime.substring(0,10);
        myanDate = myaDatetime.substring(0, 10);
        myanTime = myanDatetime.substring(10, 19);
        // print(myDatetime);
        myaEdetails = ds["edetails"];
        // myUid = ds["uid"];
        myaImageUrl = ds["aimageurl"];
        // myLongitude = ds["plongitude"];
        myanLatitdue = ds["nlatitude"];
        myanLongitude = ds["nlongitude"];
        // print(myName);
        // print(myEmail);
        // print(myUid);
      }).catchError((e) {
        print(e);
      });
  }
  _fetchOtherDetails() async {
    User? firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('otherDetails')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myoDatetime = ds["datetime"];
        // print(myDatetime);
        myonDatetime = ds["datetime"];
        myoDatetime = myoDatetime.substring(0,10);
        myonDate = myoDatetime.substring(0, 10);
        myonTime = myonDatetime.substring(10, 19);
        // print(myDatetime);
        myoEdetails = ds["edetails"];
        // myUid = ds["uid"];
        myoImageUrl = ds["oimageurl"];
        // myLongitude = ds["plongitude"];
        myonLatitdue = ds["nlatitude"];
        myonLongitude = ds["nlongitude"];
        // print(myName);
        // print(myEmail);
        // print(myUid);
      }).catchError((e) {
        print(e);
      });
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class viewHistory extends StatefulWidget {
//   const viewHistory({Key? key}) : super(key: key);

//   @override
//   State<viewHistory> createState() => _viewHistoryState();
// }

// class _viewHistoryState extends State<viewHistory> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("History Page"),
//         ),
//     );
//   }
// }