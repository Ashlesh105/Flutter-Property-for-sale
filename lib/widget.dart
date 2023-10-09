import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:property_sale/sellProperty.dart';

import 'House.dart';

class template extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  final String text;
  template(
      {Key? key,
      required this.imageUrl,
      required this.text,
      required this.height,
      required this.width})
      : super(key: key);

  get property => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>PropertyDetails(property: property)));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(color: Colors.black12, spreadRadius: 2.0),
              ]),
          height: height,
          width: width,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    imageUrl,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 50,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ))),
              // IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_rounded))
            ],
          ),
        ),
      ),
    );
  }
}
