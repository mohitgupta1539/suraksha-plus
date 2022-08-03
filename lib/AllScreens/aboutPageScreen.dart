import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class aboutPage extends StatefulWidget {
  const aboutPage({Key? key}) : super(key: key);

  @override
  State<aboutPage> createState() => _aboutPageState();
}

class _aboutPageState extends State<aboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Page"),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 45.0,),
              // Image.asset("images/images/user_icon.png", height: 80.0, width: 80.0,),
              
              SizedBox(height: 12.0,),
              ListTile(
                leading: Icon(Icons.health_and_safety_sharp),
                title:Text("This App will help \nto solve the case", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
              ),
            ],
          ),
        ),
    );
  }
}