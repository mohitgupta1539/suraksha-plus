import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:suraksha_plus/AllScreens/imagesUpload/user_image.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({Key? key}) : super(key: key);

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  String imageUrl = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Please, Upload Case"),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 15.0,),

          UserImage(
            onFileChanged: (imageUrl) {
              setState(() {
                this.imageUrl = imageUrl;
              });
            }
          )
        ],
      ),
    );
  }
}