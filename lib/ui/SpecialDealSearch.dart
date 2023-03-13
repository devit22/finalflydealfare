
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';


import '../utils/network.dart';

class SpecialDealSearch extends StatefulWidget {
  final String? isoneway;
  final String? fromDate;
  final String? depcode;
  final String? descode;
   SpecialDealSearch({Key? key,this.isoneway,this.fromDate,this.depcode,this.descode}) : super(key: key);

  @override
  State<SpecialDealSearch> createState() => _SpecialDealSearchState();
}

class _SpecialDealSearchState extends State<SpecialDealSearch> {

List<int> pricelist = [];
bool isdataloaded = true;
  String country = "nothing";
  bool iscountryavail = false;


  @override
  void initState() {
getCountry();
  // UserApiService.getpricelist(widget.fromDate!,widget.isoneway!).then((value){
  // pricelist = value;
  //    setState(() {
  //      isdataloaded=true;
  //    });
  // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ColorConstants.iconColror,
            ),
          ),
          title: const Text(
            'Special Call',
            style: TextStyle(color: ColorConstants.iconColror),
          ),

      ),
      body: (isdataloaded)? Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, position) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                margin:  EdgeInsets.only(left: Diamensions.width10, right: Diamensions.width10, top: Diamensions.width5, bottom: Diamensions.width5),

                child: Material(
                  elevation: Diamensions.width10,
                  borderRadius: BorderRadius.all(Radius.circular(Diamensions.width10)
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorConstants.whitecolr,
                        borderRadius: BorderRadius.all(Radius.circular(Diamensions.width10)
                        )
                    ),
                    padding: EdgeInsets.symmetric(vertical: Diamensions.height10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                                width: Diamensions.width10*4,
                                margin: EdgeInsets.only(left:Diamensions.width10,),
                                child: Image.network("https://flightstoindia.com/wp-content/themes/flights-to-india/img/flight-logo.png"))

                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin:EdgeInsets.only(left: Diamensions.width10,bottom: Diamensions.width10),
                                  child: Text("\$500 *",style: TextStyle(
                                      color: ColorConstants.backgroundColor,
                                      fontSize: Diamensions.fontsize19
                                  ),
                                  ),
                                ),
                                Container(
                                  margin:EdgeInsets.only(left: Diamensions.width10,bottom: Diamensions.width10),
                                  child: Text("SPL Fare **",style: TextStyle(
                                      color: ColorConstants.backgroundColor,
                                      fontSize: Diamensions.fontsize19
                                  ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin:EdgeInsets.only(left: Diamensions.width10,bottom: Diamensions.width10),
                                  child: Text("${widget.depcode}",style: TextStyle(
                                      color: ColorConstants.backgroundColor,
                                      fontSize: Diamensions.fontsize19
                                  ),
                                  ),
                                ),
                                (widget.isoneway == "one")?
                                Container(
                                  height:Diamensions.width10*3,
                                  width: Diamensions.width10*3,
                                  margin: EdgeInsets.only(bottom: Diamensions.width10,left: Diamensions.width10),
                                  foregroundDecoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/images/forward.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ):
                                Container(
                                  height:Diamensions.width10*3,
                                  width: Diamensions.width10*3,
                                  margin: EdgeInsets.only(bottom: Diamensions.width10,left: Diamensions.width10),
                                  foregroundDecoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/images/double-arrow.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Container(
                                  margin:EdgeInsets.only(left: Diamensions.width10,bottom: Diamensions.width10),
                                  child: Text("${widget.descode}",style: TextStyle(
                                      color: ColorConstants.backgroundColor,
                                      fontSize: Diamensions.fontsize19
                                  ),
                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                        GestureDetector(
                          onTapDown: (TapDownDetails details){
                            _showPopupMenu(details.globalPosition,details);
                            // if(country == "India"){
                            //   FlutterPhoneDirectCaller.callNumber("+919814614000");
                            // }else if(country == "Canada"){
                            //   FlutterPhoneDirectCaller.callNumber("+18662145391");
                            // }else{
                            //   FlutterPhoneDirectCaller.callNumber("+18777711620");
                            // }
                          },
                          child: Container(
                            height: Diamensions.width53,
                            width: Diamensions.width53,
                            margin: EdgeInsets.only(right: Diamensions.width5),
                            foregroundDecoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/telephone.png"),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ): Center(child: CircularProgressIndicator(color: ColorConstants.greencolor,)),
    );
  }
  Future<String> getCountry() async{
    Network n = new Network("http://ip-api.com/json");
    var  locationSTR = (await n.getData());
    var  locationx = jsonDecode(locationSTR);
    setState(() {
      iscountryavail = true;
      country = locationx["country"];
    });
    return locationx["country"];
  }

void _showPopupMenu(Offset offset,TapDownDetails details) async{

  await showMenu(context: context,
    constraints: BoxConstraints(
        maxWidth: 135,
        maxHeight: 200
    ),
    // position: RelativeRect.fromLTRB(100, 80, 5, 0),
    position: RelativeRect.fromLTRB(
      details.globalPosition.dx,
      details.globalPosition.dy,
      details.globalPosition.dx,
      details.globalPosition.dy,
    ),
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
