import 'package:flutter/material.dart';

class template extends StatelessWidget {

  final String imageUrl;
   final String text;
   template({Key?key, required this.imageUrl, required this.text}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.0),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(color: Colors.blueGrey,borderRadius: BorderRadius.circular(20.0),boxShadow: []),
        child: Column(
          children: [
            Image.asset(imageUrl,fit: BoxFit.cover,),
            SizedBox(height: 36,),
            Container(height:30,width:200,decoration:BoxDecoration(color: Colors.white),child: Text(text,textAlign: TextAlign.center))
          ],
        )
      ),
    );
  }
}
