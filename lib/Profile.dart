import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Drawer.dart';
import 'User_model_class.dart';
import 'helperClass.dart';

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
   int userId =0;
  bool _isEditing = false;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _isEditing = true;
    _loadUserData();
  }
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdString = prefs.getString('userId');

    // Check if userIdString is not null and can be parsed as an integer
    if (userIdString != null) {
      userId = int.tryParse(userIdString) ?? 0;
    }

    // Retrieve user data from SQLite
    User? user = await DatabaseHelper.instance.getUser(userId);

    if (user != null) {
      setState(() {
        _nameController.text = user.name;
        _emailController.text = user.email;
        _phoneNumberController.text = user.phoneNumber;
        _selectedImage = File(user.profileImage);
      });
    }
  }

  Future<void> _toggleEdit() async {
    print('in toggle edit');
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Save changes when done editing
        // You can save these values in a database or wherever you prefer.
        // For simplicity, we are just displaying them here.
        _updateUserData().then((_) {
          _loadUserData(); // Reload user data after updating
        });
        Navigator.pop(context);
      }
    });
  }

  Future<void> _updateUserData() async {
    // Save user data to SQLite
    await DatabaseHelper.instance.updateUser(User(
      id: userId,
      name: _nameController.text,
      email: _emailController.text,
      phoneNumber: _phoneNumberController.text,
      profileImage: _selectedImage?.path ?? '',

    ));
    print('User data updated in the database:');
    print('Name: ${_nameController.text}');
    print('Email: ${_emailController.text}');
    print('Phone Number: ${_phoneNumberController.text}');
    print('Profile Image Path: ${_selectedImage?.path ?? ''}');
  }

  Future getImageFromGallery() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    setState(() {
      _selectedImage = File(imageFile.path);
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
              onPressed: () async {
                await _toggleEdit(); // Save changes before navigating
                print('saved');
              },
              child: Text('Save'),
            ),


          ],
        ),
      ),
    );
  }
}
