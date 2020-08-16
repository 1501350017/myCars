/*
  firebase_storage: ^3.1.6
  image_picker: ^0.6.7+4
  percent_indicator: ^2.1.5
  file_picker: ^1.13.3

*/



import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class UploadTest extends StatefulWidget {
  @override
  _UploadTestState createState() => _UploadTestState();
}

class _UploadTestState extends State<UploadTest> {
  PickedFile imageFile; //null
  double percetage = 0;
  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Upload Test'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              uploadImage();
            },
          )
        ],
      ),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          // imageFile == null
          //     ? Center(
          //         child: Text('No Image'),
          //       )
          //     : Image.file(
          //         File(imageFile.path),
          //       ),
          SizedBox(height: 16),
          CircularPercentIndicator(
            percent: percetage/100,
            radius: 100,
            center: Text('${percetage.toInt()}%'),
          )
        ],
      ),

      //
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //
          captureImage();
        },
      ),
    );
  }

  // capture Image
  void captureImage() async {
    //
    // ImagePicker picker = ImagePicker();
    // PickedFile temp = await picker.getImage(source: ImageSource.gallery);

    // if (temp != null) {
    //   setState(() {
    //     imageFile = temp;
    //     percetage = 0;
    //   });
    // }

    File temp =  await FilePicker.getFile(type: FileType.any);

    if(temp != null)
    {
      setState(() {
        file = temp;
        percetage = 0;
      });
    }

  }

  // upload image
  void uploadImage() {
    if (file != null) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      String ext = file.path
          .substring(file.path.lastIndexOf('.'), file.path.length);
      String finalPath = 'mydata/' + fileName + ext;

      StorageReference storageReference =
          FirebaseStorage.instance.ref().child(finalPath);

      StorageUploadTask storageUploadTask =
          storageReference.putFile(file);

      storageUploadTask.events.listen((event) {
        setState(() {
          percetage = event.snapshot.bytesTransferred /
              event.snapshot.totalByteCount *
              100;
        });
      });
    }
  }
}
