import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class UploadImageStorage extends StatefulWidget {
  const UploadImageStorage({super.key});

  @override
  State<UploadImageStorage> createState() => _UploadImageStorageState();
}

class _UploadImageStorageState extends State<UploadImageStorage> {

  firebase_storage.FirebaseStorage firebaseStorage=firebase_storage.FirebaseStorage.instance;

  File? photo;
  final ImagePicker imagePicker=ImagePicker();

  Future imageFromGallary()async{

    final pickfile=await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pickfile!=null){
        photo=File(pickfile.path);
        upload();
      }else{
        print('No image selected');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
        upload();
      } else {
        print('No image selected.');
      }
    });
  }

  Future upload()async{
    if(photo==null)return;
    final fileName=basename(photo!.path);
    final destination='files/$fileName';

    try{
      final ref=firebase_storage.FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(photo!);
    }catch(e){
      print('error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xffFDCF09),
                child: photo != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    photo!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ): Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imageFromGallary();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
