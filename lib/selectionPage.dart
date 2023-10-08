import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:property_sale/Drawer.dart';
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
  Position? _currentPosition;
  String? _currentAddress;

  Future<Position> _getPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Location not available'),
      ));
    }
    return await Geolocator.getCurrentPosition();
  }

  void _getAddress(latitude, longitude) async {
    try {
      List<Placemark> placemark = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemark[0];
      setState(() {
        _currentAddress ='${place.locality},${place.street},${place.country}';
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.deepPurple),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
         TextButton(onPressed: () async{
           _currentAddress = (await _getPosition()) as String?;
           _getAddress(_currentPosition!.latitude, _currentPosition!.longitude);
         }, child: Text('Location'))
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
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width),
                template(
                    imageUrl: 'assets/Appartment.jpg',
                    text: 'Appartment',
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width),
                template(
                    imageUrl: 'assets/office.jpg',
                    text: 'Office',
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'SHOW ALL',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w200),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.deepPurple),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
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
