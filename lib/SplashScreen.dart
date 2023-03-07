import 'dart:async';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/ui/login_screen.dart';
import 'package:lottie/lottie.dart';


import 'ui/root_home_screen.dart';

class EntryPackage extends StatefulWidget {
  const EntryPackage({Key? key}) : super(key: key);

  @override
  State<EntryPackage> createState() => _EntryPackageState();
}

class _EntryPackageState extends State<EntryPackage> {
  @override
  void initState() {
    Timer(Duration(seconds: 4),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (_) => LogInScreen()
            )
        )
    );
    super.initState();

  }

  // startTimer() async {
  //   return  Timer(Duration(seconds: 4),
  //           ()=>Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder:
  //               (context) => EntryPackage()
  //           )
  //       )
  //   );;
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          gradient:  LinearGradient(
            colors: [ColorConstants.greencolor,ColorConstants.staticcolro,ColorConstants.backgroundColor],
             begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1,0.4,0.9,],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Column(
          children: [
          const SizedBox(
            height: 120,
          ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Lottie.asset("assets/mystartanimation.json"),
            ),
           const SizedBox(
             height: 40,
           ),
            Entry.offset(
              duration: Duration(seconds: 3),
              xOffset: 0,
              yOffset: 350,
              curve: Curves.linearToEaseOut,
              child: SizedBox(
                  child: Entry.scale(
                    duration: Duration(seconds: 3),
                    scale: 3,
                    curve: Curves.linearToEaseOut,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                        child: const Text("FLYDEALFARE",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold

                          ),
                        )
                    ),
                  ),
                //child: Image.asset("assets/images/mydrawyerlogo.png"),
              ),
            )
          ],

        ),
      ) ,
    );
  }
}