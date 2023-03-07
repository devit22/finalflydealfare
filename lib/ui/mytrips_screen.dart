import 'package:flutter/material.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';

class MyTrips extends StatelessWidget {
  const MyTrips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConstants.backgroundColor,
        child: Center(
          child: Text("My Trip Screen will update soon",
          style: TextStyle(
            color: Colors.white
          ),
          ),
        ),
      ),
    );
  }
}
