import 'package:flutter/material.dart';
import 'package:property_sale/Favorites.dart';
import 'package:property_sale/sellProperty.dart';
import 'package:property_sale/signup.dart';
import 'package:property_sale/splashScreen.dart';

import 'Profile.dart';

void main() => runApp(MaterialApp(home: drawer()));

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Ashlesh Kini T'),
            accountEmail: Text('tashleshkini@gmail.com'),
            currentAccountPicture: CircleAvatar(
              foregroundImage: AssetImage('assets/mypic.jpg'),
            ),
            decoration: BoxDecoration(color: Colors.deepPurple.shade300),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => myProfile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.sell_sharp),
            title: Text('Sell your property'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => sellProperty()));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => myfav()));
            },
          ),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Signout'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => splashScreen()));
              })
        ],
      ),
    );
  }

  myfav() {}
}
