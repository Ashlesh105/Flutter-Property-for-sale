import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_sale/helperClass.dart'; // Import your database helper
import 'package:property_sale/selectionPage.dart';
import 'property_model.dart'; // Import your Property model

class SellProperty extends StatefulWidget {
  const SellProperty({Key? key}) : super(key: key);

  @override
  State<SellProperty> createState() => _SellPropertyState();
}

class _SellPropertyState extends State<SellProperty> {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  File? _image;

  Future getImageFromGallery() async {
    final imageFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    setState(() {
      _image = File(imageFile.path);
      print(_image);
    });
  }

  void _addProperty() async {
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

    await DatabaseHelper.instance.insertProperty(property.toMap());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Categories(),
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
            SizedBox(height: 10),
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
