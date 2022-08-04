import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:suraksha_plus/AllScreens/loginScreen.dart';
import 'package:suraksha_plus/AllScreens/mainscreen.dart';
import 'package:suraksha_plus/AllScreens/registrationScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    // name = "flutter_my_app",
    // options: FirebaseOptions(
    //   apiKey: "AIzaSyCuWNsCnlNSs8hYYbCtQ-Rgohy2g-derT4",
    //   databaseURL: "https://uber-clone-fdd32-default-rtdb.firebaseio.com",
    //   appId: "1:659467196024:android:db400df29bd59a0cfc3f8d",
    //   messagingSenderId: "659467196024",
    //   projectId: "uber-clone-fdd32",
    // ),
  );
  runApp(MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('Users');

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initilization = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _initilization,
    builder: (context, snapshot) {
        if(snapshot.hasError) {
          print("Something went Wrong");
        }

        if(snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: "Flutter App",
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            //
            initialRoute: FirebaseAuth.instance.currentUser == null ? LoginScreen.idScreen : MainScreen.idScreen,
            routes:
            {
              RegistrationScreen.idScreen: (context) => RegistrationScreen(),
              LoginScreen.idScreen: (context) => LoginScreen(),
              MainScreen.idScreen: (context) => MainScreen(),
            },
          );
        }
        return CircularProgressIndicator();
    },);

    // return MaterialApp(
    //   title: 'Secure App',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: HomePage(),
    //   debugShowCheckedModeBanner: false,
    // );
  }
}
