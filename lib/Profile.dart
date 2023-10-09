import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MaterialApp(
  home: MyProfile(),
  debugShowCheckedModeBanner: false,
));

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  File? _selectedImage;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  bool _isEditing = false;

  Future getImageFromGallery() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    setState(() {
      _selectedImage = File(imageFile.path);
    });
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Save changes when done editing
        // You can save these values in a database or wherever you prefer.
        // For simplicity, we are just displaying them here.
        _nameController.text;
        _emailController.text;
        _phoneNumberController.text;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.deepPurple.shade300,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  getImageFromGallery();
                },
                child: CircleAvatar(
                  radius: 50,
                  // backgroundColor: Colors.deepPurple,
                  backgroundImage: _selectedImage == null
                      ? null
                      : FileImage(File(_selectedImage!.path)),
                  child: _selectedImage == null ? Icon(Icons.add_photo_alternate) : null,
                  //     ? IconButton(
                  //   onPressed: getImageFromGallery,
                  //   icon: Icon(Icons.add_photo_alternate),
                  //   color: Colors.white,
                  //   iconSize: 30,
                  // )

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                enabled: _isEditing,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                enabled: _isEditing,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                enabled: _isEditing,
              ),
            ),
            ElevatedButton(
              onPressed: _toggleEdit,
              child: Text(_isEditing ? 'Save' : 'Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
