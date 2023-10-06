import 'package:flutter/material.dart';
import 'package:property_sale/widget.dart';

void main() => runApp(MaterialApp(home: categories(),debugShowCheckedModeBanner: false,));

class categories extends StatefulWidget {
  const categories({super.key});

  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.deepPurple),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            )),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_on),
            color: Colors.black,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Categories',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          Row(
            children: [
              template(
                  imageUrl: 'assets/home.jfif',text: 'House',),
            ],
          )
        ],
      ),
    );
  }
}
