
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
  String country = "";
List<int> pricelist = [];
bool isdataloaded = false;
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
  getcurrentcountry();

  UserApiService.getpricelist(widget.fromDate!,widget.isoneway!).then((value){
  pricelist = value;
     setState(() {
       isdataloaded=true;
     });
  });
    super.initState();
  }

  Future<void> getcurrentcountry() async{
    getuserCurrentLocation().then((value) async{
      List<Placemark> _placemak = await placemarkFromCoordinates(value.latitude, value.longitude);
      country = _placemak.reversed.last.country.toString();

    });
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
            itemCount: pricelist.length,
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
                            // Container(
                            //   foregroundDecoration: const BoxDecoration(
                            //     image: DecorationImage(
                            //         image: NetworkImage("https://flightstoindia.com/wp-content/themes/flights-to-india/img/flight-logo.png"),
                            //         fit: BoxFit.fill),
                            //   ),
                            // ),

                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin:EdgeInsets.only(left: Diamensions.width10,bottom: Diamensions.width10),
                                  child: Text("\$${pricelist[position]} *",style: TextStyle(
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

                            if(country == "India"){
                              FlutterPhoneDirectCaller.callNumber("+919814614000");
                            }else if(country == "Canada"){
                              FlutterPhoneDirectCaller.callNumber("+18662145391");
                            }else{
                              FlutterPhoneDirectCaller.callNumber("+18777711620");
                            }
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

}
