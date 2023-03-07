


import 'package:country_picker/country_picker.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/Data.dart';
import 'package:fly_deal_fare/ui/chat_screen.dart';
import 'package:fly_deal_fare/ui/deals_screen.dart';
import 'package:fly_deal_fare/ui/login_screen.dart';
import 'package:fly_deal_fare/ui/myaccount_screen.dart';
import 'package:fly_deal_fare/ui/mytrips_screen.dart';
import 'package:fly_deal_fare/ui/register_screen.dart';
import 'package:fly_deal_fare/ui/reward_screen.dart';
import 'package:fly_deal_fare/ui/search_screen.dart';
import 'package:fly_deal_fare/ui/setting.dart';
import 'package:fly_deal_fare/ui/notification_screen.dart';
import 'package:fly_deal_fare/ui/travel_update_screen.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';
import 'package:get/get.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  Data? loggedindata;
  final int? pageIndex;
  final int? bottomindex ;
  final bool? iscomponentload;
  final bool? isLoggedIn;
   HomeScreen({Key? key, this.loggedindata,this.pageIndex = 0,this.iscomponentload=true,this.isLoggedIn=false,this.bottomindex =0}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pageIndex = 0;
  var bottomindex = 0;
var  pages = [];
var bottompages = [];
  var iscomponentload = true;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  String url = "https://v2.zopim.com/widget/livechat.html?api_calls=%5B%5D&hostname=flydealfare.com&key=3Em35GdwEBlCExa7X0KZN0silzvPrqZA&lang=en&";
late FirebaseAuth auth;
//String country = "";

Future<Position> getuserCurrentLocation() async{

  await Geolocator.requestPermission().then((value){
    print("Permission Granted");
  }).onError((error, stackTrace){
    print("error => ${error.toString()}");
  });

  return await Geolocator.getCurrentPosition();
}
  @override
  void initState() {


  getuserCurrentLocation().then((value) {
    print(" ${value.latitude} and ${value.longitude} ");
  });

    auth = FirebaseAuth.instance;

    pages = [
      MyAccount(loggedInuser: widget.loggedindata,),
      Settings(),
      NotificationScreen(),
      ChatScreen(chaturl: url,),
      TravelUpdateScreen()
    ];
    bottompages =[
      Search(loggedindata: widget.loggedindata),
      Reward(loggedindata: widget.loggedindata,isLoggedIn: widget.isLoggedIn!,),
      MyTrips(),
      Deals(loggedindata: widget.loggedindata,isLoggedIn: widget.isLoggedIn!,),
    ];
    if (!(widget.pageIndex == 0 && widget.iscomponentload == false)) {
      pageIndex = widget.pageIndex!;
      iscomponentload = widget.iscomponentload!;
      bottomindex = widget.bottomindex!;
    }
    super.initState();





  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Container(
              height: 75,
              width: 200,
              child: Image.asset(
                "assets/images/mydrawyerlogo.png",
                fit: BoxFit.contain,
              )),
          iconTheme: const IconThemeData(color: Colors.blue),
          actions: [
            GestureDetector(
              onTapDown: (TapDownDetails details){
               _showPopupMenu(details.globalPosition);
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: Diamensions.width5),
                width: 40,
                  height: 40,
                  child: Image.asset("assets/images/telephone.png")),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ), //BoxDecoration
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset("assets/images/mydrawyerlogo.png"),
                      ),

                      Visibility(
                        visible: (widget.isLoggedIn!)?false:true,
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LogInScreen()));
                            },
                            child: const Text(
                              "Sign In ",
                              style: TextStyle(color: Colors.blue),
                            )
                        ),
                      )

                    ],
                  ) //UserAccountDrawerHeader
              ), //DrawerHeader
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                title: const Text(
                  ' My Account',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  setState(() {
                    pageIndex = 0;
                    iscomponentload=false;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
                title: const Text(
                  'Setting',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  setState(() {
                    pageIndex = 1;
                    iscomponentload=false;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.add_alert_sharp,
                  color: Colors.blue,
                ),
                title: const Text(
                  'Notification',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  setState(() {
                    pageIndex = 2;
                    iscomponentload=false;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.chat,
                  color: Colors.blue,
                ),
                title: const Text(
                  'Chat',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  setState(() {
                    pageIndex = 3;
                    iscomponentload=false;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.card_travel_outlined,
                  color: Colors.blue,
                ),
                title: const Text(
                  'Travel Updates',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  setState(() {
                    pageIndex = 4;
                    iscomponentload=false;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.blue,
                ),
                title: const Text(
                  'LogOut',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {

                    auth.signOut();

                    Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen()));


//                   auth.signOut();
// FacebookAuth.instance.logOut().then((value) => {
//
// });

                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: bottomindex,
          items: <Widget>[
            Container(
                height: 20,
                width: 20,
                child: Image.asset(
                  'assets/images/search_large.png',
                  color: Colors.black,
                )
            ),
            Container(
                height: 20,
                width: 20,
                child: Image.asset(
                  'assets/images/reward_large.png',
                  color: Colors.black,
                )
            ),
            Container(
                height: 20,
                width: 20,
                child: Image.asset(
                  'assets/images/trip_large.png',
                  color: Colors.black,
                )
            ),
            Container(
                height: 20,
                width: 20,
                child: Image.asset(
                  'assets/images/deal_large.png',
                  color:Colors.black,
                )
            )
          ],
          color: ColorConstants.whitecolr,
          buttonBackgroundColor: ColorConstants.whitecolr,
          backgroundColor: ColorConstants.backgroundColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {


            setState(() {
              bottomindex = index;
              iscomponentload = true;
            });
          },
          letIndexChange: (index) => true,
        ),
       // body: pages[pageIndex]);


    body: (iscomponentload) ? bottompages[bottomindex] : pages[pageIndex]);
  }

  void _showPopupMenu(Offset offset) async{

    await showMenu(context: context,
        constraints: BoxConstraints(
          maxWidth: 135,
          maxHeight: 200
        ),
        position: RelativeRect.fromLTRB(100, 80, 5, 0),
        items: [
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset("assets/images/fly_deal_fare_icon_canada.png"),
                ),
                Flexible(
                    child: Container(
                        margin: EdgeInsets.only(left: Diamensions.width5),
                        child: Text("Canada"))
                )
              ],

            ),

          ),
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset("assets/images/fly_deal_farc_icon_india.png"),
                ),
                Flexible(
                    child: Container(
                        margin: EdgeInsets.only(left: Diamensions.width5),
                        child: Text("India")
                    )
                )
              ],

            ),

          ),

          PopupMenuItem(
            value: 3,
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset("assets/images/fly_deal_fare_icon_usa.png"),
                ),
                Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: Diamensions.width5),
                        child: Text("USA")
                    )
                )
              ],

            ),

          ),
        ],
      elevation: 8.0,
    ).then((value) {

      if(value != null){
        switch(value){
          case 1:
            FlutterPhoneDirectCaller.callNumber("+919814614000");
            break;
          case 2:
            FlutterPhoneDirectCaller.callNumber("+18662145391");
            break;
          case 3:
            FlutterPhoneDirectCaller.callNumber("+18777711620");
            break;
    }
      }
    });
  }
}