
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomeContainer extends StatelessWidget {

  final String? lableText;
  final BoxDecoration? decoration;
   CustomeContainer({Key? key,this.lableText,this.decoration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
        ),
        Positioned(
          bottom: 0,
            child: Container(
              width: 250,
              height: 50,
              decoration: decoration,
            ),
        ),
        Positioned(
            child: Container(color: Colors.white,child: Text('XP'),)
        )
      ],
    );
  }
}


