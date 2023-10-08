import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MaterialApp(
      home: myProfile(),
      debugShowCheckedModeBanner: false,
    ));

class myProfile extends StatefulWidget {
  const myProfile({super.key});

  @override
  State<myProfile> createState() => _myProfileState();
}

class _myProfileState extends State<myProfile> {
  File? _selectedImage;
  Future getImageFromGallery() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imageFile==null) return;
    setState(() {
      _selectedImage = File(imageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.deepPurple.shade300,
      ),
      body: Column(
        children: [
          Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.deepPurple,
                  foregroundImage: _selectedImage == null
                      ? null
                      : FileImage(File(_selectedImage!.path)),
                  child: _selectedImage == null
                      ? IconButton( onPressed: getImageFromGallery, icon: Icon(Icons.add_photo_alternate),color: Colors.white,iconSize: 30,)
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text('Name'),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(20))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text('Email'),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(20))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text('Phone number'),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(20))
                  ),
                ),
              ),


            ],
          ))
        ],
      ),
    );
  }
}
