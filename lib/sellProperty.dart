import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MaterialApp(home: sellProperty()));

class Property {
  String type;
  int minPrice;
  int maxPrice;
  String imageUrl;

  Property({
    required this.type,
    required this.minPrice,
    required this.maxPrice,
    required this.imageUrl,
  });
}

class sellProperty extends StatefulWidget {
  const sellProperty({Key? key});

  @override
  State<sellProperty> createState() => _sellProperty();
}

class _sellProperty extends State<sellProperty> {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  File? _image;

  Future getImageFromGallery() async {
    final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    setState(() {
      _image = File(imageFile.path);
      print(_image);
    });
  }

  void _addProperty() {
    final type = typeController.text;
    final minPrice = int.tryParse(minPriceController.text) ?? 0;
    final maxPrice = int.tryParse(maxPriceController.text) ?? 0;
    final imageUrl = _image?.path ?? '';

    final property = Property(
      type: type,
      minPrice: minPrice,
      maxPrice: maxPrice,
      imageUrl: imageUrl,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyDetails(property: property),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: typeController,
              decoration: InputDecoration(labelText: 'Property Type'),
            ),
            TextFormField(
              controller: minPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Minimum Price'),
            ),
            TextFormField(
              controller: maxPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Maximum Price'),
            ),
            ElevatedButton(
              onPressed: getImageFromGallery,
              child: Text('Select Image'),
            ),
           SizedBox(height: 10,),
            ElevatedButton(
              onPressed: _addProperty,
              child: Text('Add Property'),
            ),
          ],
        ),
      ),
    );
  }
}

class PropertyDetails extends StatelessWidget {
  final Property property;

  PropertyDetails({required this.property});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 2.0),
            ]),
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0)
              ),
              child: Text('Image here')
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(20.0),
              //   child: Image.File(
              //     imageUrl,
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.width,
              //     fit: BoxFit.fill,
              //   ),
              // ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(children: [
                      Text(
                        ' ${property.type}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                      Text(
                        'Minimum Price: \$${property.minPrice}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                      Text(
                        'Maximum Price: \$${property.maxPrice}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.black),
                      ),

                    ],)

                )),
            // IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_rounded))
          ],
        ),
      ),
    );
  }
}
