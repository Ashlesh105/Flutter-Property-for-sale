import 'package:flutter/material.dart';
import 'package:property_sale/widget.dart';

void main() => runApp(MaterialApp(
      home: categories(),
      debugShowCheckedModeBanner: false,
    ));

class categories extends StatefulWidget {
  const categories({super.key});

  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer:,
      appBar: AppBar(

        backgroundColor: Colors.white,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.deepPurple),
        ),
        centerTitle: true,
        elevation: 0,

        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_on),
            color: Colors.black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Categories',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            Column(
              children: [
                template(
                    imageUrl: 'assets/home-image.jpg',
                    text: 'House',
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width),
                template(
                    imageUrl: 'assets/Appartment.jpg',
                    text: 'Appartment',
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width),
                template(
                    imageUrl: 'assets/office.jpg',
                    text: 'Office',
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 200,height: 50,
                      child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'SHOW ALL',
                            style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.w200),
                            ),

                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.deepPurple),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        backgroundColor: Colors.white,

                      ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
