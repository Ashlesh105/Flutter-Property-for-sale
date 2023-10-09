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
  bool _locationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _locationPermissionGranted = true;
      await _getCurrentLocation();
    }
  }
  Future<void> _getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition();
      _getAddress(_currentPosition!.latitude, _currentPosition!.longitude);
    } catch (e) {
      print(e);
    }
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
           await _checkLocationPermission();
           print(_currentAddress);
         }, child:Text(
           _locationPermissionGranted
               ? _currentAddress ?? 'Loading...'
               : 'Location',
           style: TextStyle(color: Colors.deepPurple),
         ),)
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

              ],
            )
          ],
        ),
      ),
    );
  }
}
