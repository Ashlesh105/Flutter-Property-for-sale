import 'package:flutter/material.dart';


void main() => runApp(MaterialApp(home: myfav(),debugShowCheckedModeBanner: false,));

class myfav extends StatefulWidget {
  const myfav({super.key});

  @override
  State<myfav> createState() => _myfavState();
}

class _myfavState extends State<myfav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favorites'),
      ),
    );
  }
}

