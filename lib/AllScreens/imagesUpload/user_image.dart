import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:suraksha_plus/AllScreens/Divider.dart';

import 'package:suraksha_plus/services/userAddressUpdate.dart';
import 'package:suraksha_plus/services/userRegisterfireDetail.dart';
import 'package:intl/intl.dart';


class UserImage extends StatefulWidget {

  final Function(String imageUrl) onFileChanged;
  // UserImage({Key? key}) : super(key: key);
  
  UserImage({
    required this.onFileChanged,
  });

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {

  String? caseType;
  TextEditingController extraTextEditingController = TextEditingController();

  // adding locaiton service for currentLocaiton
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

  final ImagePicker _picker = ImagePicker();

  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.0,),
        Text("Please select type of Case", style: TextStyle(color: Colors.blue, fontSize: 20.0, fontFamily: "Brand-Bold"),),

        SizedBox(height: 1.0,),
        RadioListTile(
          title: Text("Women"),
          value: "womenDetails", 
          groupValue: caseType, 
          onChanged: (value){
            setState(() {
                caseType = value.toString();
            });
          },
      ),

      SizedBox(height: 1.0,),
        RadioListTile(
          title: Text("Police"),
          value: "policeDetails", 
          groupValue: caseType, 
          onChanged: (value){
            setState(() {
                caseType = value.toString();
            });
          },
      ),

      SizedBox(height: 1.0,),
        RadioListTile(
          title: Text("Fire"),
          value: "firesDetails", 
          groupValue: caseType, 
          onChanged: (value){
            setState(() {
                caseType = value.toString();
            });
          },
      ),

      SizedBox(height: 1.0,),
        RadioListTile(
          title: Text("Ambulance"),
          value: "ambulanceDetails", 
          groupValue: caseType, 
          onChanged: (value){
            setState(() {
                caseType = value.toString();
            });
          },
      ),

      // RadioListTile(
      //     title: Text("Case2"),
      //     value: "Case2", 
      //     groupValue: caseType, 
      //     onChanged: (value){
      //       setState(() {
      //           caseType = value.toString();
      //       });
      //     },
      // ),

      SizedBox(height: 1.0,),
      RadioListTile(
            title: Text("Other Emergency"),
            value: "otherDetails", 
            groupValue: caseType, 
            onChanged: (value){
              setState(() {
                  caseType = value.toString();
              });
            },
      ),

      SizedBox(height: 2.0,),
      TextField(
        controller: extraTextEditingController,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: "Please share extra Details",
          labelStyle: TextStyle(
            fontSize: 25.0,
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 20.0,
          )
        ),
       style: TextStyle(fontSize: 19.0),
      ),

        SizedBox(height: 5.0,),
        DividerWidget(),
        // if(imageUrl == null) 
          // Icon(Icons.image, size: 150.0, color: Colors.blue[800],),


          InkWell(
            onTap: () => _selectPhoto(),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                leading: Icon(Icons.image, size: 150.0, color: Colors.blue[800],),
                title: Text(imageUrl != null
              ? 'Next Case can be uploaded after perious one, Thankyou'
              : '\nPlease Take photo \nto Complete Process',
              style: TextStyle(color: Colors.blue[900],fontSize: 20.0,),
              ),
                // title:Text("This App will help \nto solve the case", style: TextStyle(fontSize: 15.0, fontFamily: "Brand-Bold"),),
              ),
              ]),
              // child: Text(imageUrl != null
              // ? 'Next Case can be uploaded after perious one, Thankyou'
              // : 'Please Take photo \nto Complete Process',
              // style: TextStyle(color: Colors.blue[900],fontSize: 20.0,),
              // ),
            ),
          ),






        
      ],
    );
    
  }

  Future _selectPhoto() async {
    await showModalBottomSheet(context: context, builder: (context) => BottomSheet(
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(leading: Icon(Icons.camera), title: Text('Camera'),
          onTap: () {
            Navigator.of(context).pop();
            _pickImage(ImageSource.camera);
          },),

          ListTile(leading: Icon(Icons.filter), title: Text('Pick a file'),
          onTap: () {
            Navigator.of(context).pop();
            _pickImage(ImageSource.gallery);
          },),
        ],
      ),
      onClosing: () {},
      ),
      );
  }

  Future _pickImage(ImageSource source) async {
    final PickedFile = await _picker.pickImage(source: source, imageQuality: 50);
    if(PickedFile == null) {
      return;
    }

    var file = await ImageCropper().cropImage(sourcePath: PickedFile.path, aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));

    if(file == null) {
      return;
    }

    // file = await compressImage(file.path, 39);

    await _uploadFile(file.path);
  }
  Future<File?> compressImage(String path, int imageQuality) async {
    final newPath = p.join((await getTemporaryDirectory()).path, '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(path, newPath, quality: imageQuality,);

    return result;

  }
  Future _uploadFile(String path) async {
    Position position = await _getGeoLocationPosition();
    // print(position.latitude);
    final datetime = DateTime.now();
    final ref = storage.FirebaseStorage.instance.ref()
    .child('images')
    .child('${DateTime.now().toIso8601String() + p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();
    // print("Url is ancjsndkisjdfkindsfjloajvnmdk:" + fileUrl);
    Map userDataMap = {
      "nlongitude": position.longitude.toString(),
      "nlatitude": position.latitude.toString(),
      "imageurl": fileUrl,
    };
    UserManagementUrl().storeNewUser(userDataMap, context);
    Map userCaseDataMap = {
      "nlongitude": position.longitude.toString(),
      "nlatitude": position.latitude.toString(),
      "edetails": extraTextEditingController.text.trim(),
      "datetime": datetime.toString(),
      "imageurl": fileUrl,
      "caseType": caseType,
    };
    UserManagementCaseUrl().storeNewUser(userCaseDataMap, context);

    setState(() {
      imageUrl = fileUrl;
      widget.onFileChanged(fileUrl);
    });
  }
}