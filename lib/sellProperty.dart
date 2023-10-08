import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(home: sellProperty(),debugShowCheckedModeBanner: false,));

class sellProperty extends StatefulWidget {
  const sellProperty({super.key});

  @override
  State<sellProperty> createState() => _sellPropertyState();
}

class _sellPropertyState extends State<sellProperty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property details'),

      ),
    );
  }
}
