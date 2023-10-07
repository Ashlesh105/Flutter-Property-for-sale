import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 2.0),]),
        height: height,
        width: width,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FittedBox(
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 50,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0)),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                    )))
          ],
        ),
      ),
    );
  }
}
