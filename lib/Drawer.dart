import 'dart:io';

import 'package:flutter/material.dart';
import 'package:property_sale/sellProperty.dart';
import 'package:property_sale/signup.dart';
import 'Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userPhoneNumber;
  final File? userProfileImage;

  const DrawerPage({
    Key? key,
    required this.userName,
    required this.userEmail,
    required this.userPhoneNumber,
    required this.userProfileImage,
  }) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  late String currentUserId; // Variable to store the current user's ID

  @override
  void initState() {
    super.initState();
    currentUserId = '';
    // Retrieve the current user's ID from SharedPreferences when the widget is initialized
    _getCurrentUserId();
  }

  // Method to retrieve the current user's ID from SharedPreferences
  Future<void> _getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentUserId = prefs.getString('userId') ?? ''; // Set the currentUserId variable
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.userName),
            accountEmail: Text(widget.userEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: widget.userProfileImage != null
                  ? FileImage(widget.userProfileImage!) as ImageProvider
                  : AssetImage('assets/default_image.jpg'),
            ),
            decoration: BoxDecoration(color: Colors.deepPurple.shade300),
          ),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () async {
              // Navigate to the profile page and wait for it to return
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyProfile()),
              );

              // Reload the drawer with updated user information
              _getCurrentUserId();
              setState(() {});
            },
          ),
          ListTile(
            leading: const Icon(Icons.sell_sharp),
            title: const Text('Sell your property'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SellProperty()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Signout'),
            onTap: () {
              _signOut();
            },
          )
        ],
      ),
    );
  }

  // Method to sign out and save the user's current state
  void _signOut() async {
    // Perform any signout actions if needed

    // Save the current user's ID to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lastUserId', currentUserId);

    // Navigate to the LoginPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          userId: null,
          password: null,
        ),
      ),
    );
  }
}
