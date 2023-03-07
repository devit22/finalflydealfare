import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/custom_widget/custome_container.dart';
import 'package:fly_deal_fare/models/output.dart';
import 'package:fly_deal_fare/ui/result_screen.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';

class OneWay extends StatefulWidget {
  const OneWay({Key? key}) : super(key: key);

  @override
  State<OneWay> createState() => _OneWayState();
}

class _OneWayState extends State<OneWay> {

  var selectDateText = "Depart Date ";
  var passengerInfo = "Pick Passenger and More";
  var departairportCode = "some";
  var destinationAirportCode = "some";
  var departSuggestionValue = "Depart City";
  var destinationSuggestionValue = "Destination City";
  var fieldText = TextEditingController();
  var isPressed = false;
  var isPressedDes = false;

  var adultcount = 1;
  var childcount = 0;
  var infantcount =0;
  String dropdownvalue = 'Economy';
  var items = [
    'Economy',
    'First',
    'Business',
    'Premium',
  ];
var  deparvisibility = false;
  void returntext() {
    departSuggestionValue;
  }
@override
  void dispose() {
    super.dispose();
    fieldText.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var i = 0;
    return Stack(
      children: [
        Container(
          color: ColorConstants.backgroundColor,
          child: SingleChildScrollView(
            child: Column(

              children: <Widget>[
                Container(
                  width: Diamensions.width310+Diamensions.width10*2,
                  height: Diamensions.height53,
                  padding: EdgeInsets.only(left: Diamensions.width10+Diamensions.width5,right: Diamensions.width10+Diamensions.width5),
                  margin:  EdgeInsets.only(left: Diamensions.width10, right: Diamensions.width10),
                  child: TypeAheadField<Output?>(
                    loadingBuilder: (context){
                      return SizedBox(
                        height: Diamensions.height10*5,
                        child: const Center(child: CircularProgressIndicator(
                          color: ColorConstants.backgroundColor,
                        )
                        ),
                      );
                    },
                    minCharsForSuggestions: 3,
                    hideSuggestionsOnKeyboardHide: true,
                    textFieldConfiguration: TextFieldConfiguration(
                        style: const TextStyle(color: ColorConstants.whitecolr),
                        controller: TextEditingController(
                            text: (isPressed) ? departSuggestionValue : ""),
                        decoration: InputDecoration(
                            hintText: departSuggestionValue,
                            hintStyle:
                            const TextStyle(color: ColorConstants.whitecolr),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.whitecolr, width: 2.0),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.whitecolr, width: 2.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstants.whitecolr, width: 2.0)),
                            prefixIcon: const Icon(
                              Icons.place_outlined,
                              color: ColorConstants.whitecolr,
                            ))),
                    suggestionsCallback: UserApiService.getupdatedairportlist,
                    itemBuilder: (context, Output? suggestion) {
                      final user = suggestion;

                      i++;
                      Color colors = (i % 2 == 0) ? Colors.blue : Colors.white;
                      Color textcolor = (i % 2 == 0) ? Colors.white : Colors.blue;

                      return Container(
                        height: 30,
                        color: colors,
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 2.5, bottom: 2.5),
                        child: Text(
                          "${user?.name} (${user?.code})",
                          style: TextStyle(color: textcolor, fontSize: 19),
                        ),
                      );
                    },
                    noItemsFoundBuilder: (context) => Container(
                      height: 80,
                      child: const Center(
                        child: Text(
                          'No user found',
                          style: TextStyle(fontSize: 17, color: Colors.blue),
                        ),
                      ),
                    ),
                    onSuggestionSelected: (Output? suggestion) {
                      final user = suggestion!;
                      setState(() {
                        isPressed = true;
                        departSuggestionValue = user.name!;
                        departairportCode = user.code!;
                      });
                    },
                    errorBuilder:(context,object){
                      return SizedBox(
                        height:Diamensions.height10*5,
                        child: Center(
                            child: Text(" ERROR! ",style: TextStyle(
                              color: Colors.red,
                              fontSize: 25
                            ),)),
                      );
                    },
                  ),
                ),

                // Container(
                //   width: Diamensions.width310-Diamensions.width10,
                //   height: Diamensions.height53,
                //   padding: EdgeInsets.only(right: Diamensions.width10,left: 0.0),
                //   margin:  EdgeInsets.only(left: Diamensions.width10*2, right: Diamensions.width10*2),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5.0),
                //       border: Border.all(width: 2,color: Colors.white)
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Container(
                //         width: Diamensions.width58*5-Diamensions.width40,
                //         child: TypeAheadField<Output?>(
                //           loadingBuilder: (context){
                //              setState(() {
                //                deparvisibility = true;
                //              });
                //             return const  SizedBox(
                //               height: 0,
                //               child:  Center(child: CircularProgressIndicator(
                //                 color: ColorConstants.backgroundColor,
                //               )
                //               ),
                //             );
                //           },
                //           minCharsForSuggestions: 3,
                //           hideSuggestionsOnKeyboardHide: true,
                //
                //           textFieldConfiguration: TextFieldConfiguration(
                //               style: const TextStyle(color: ColorConstants.whitecolr),
                //               controller: TextEditingController(
                //                   text: (isPressed) ? departSuggestionValue : ""),
                //               decoration: InputDecoration(
                //                   hintText: departSuggestionValue,
                //                   hintStyle:
                //                   const TextStyle(color: ColorConstants.whitecolr),
                //                   border: const UnderlineInputBorder(
                //                                   borderSide: BorderSide(
                //                                       color: ColorConstants.backgroundColor, width: 2.0),
                //                                 ),
                //                                 disabledBorder:  const UnderlineInputBorder(
                //                                   borderSide: BorderSide(
                //                                       color: ColorConstants.backgroundColor, width: 2.0),
                //                                 ),
                //                                 enabledBorder: const UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: ColorConstants.backgroundColor, width: 2.0)),
                //                   focusedBorder: const UnderlineInputBorder(
                //                     borderSide: BorderSide(
                //                       color: ColorConstants.backgroundColor,width: 2.0
                //                     )
                //                   ),
                //                   prefixIcon: const Icon(
                //                     Icons.place_outlined,
                //                     color: ColorConstants.whitecolr,
                //                   ))),
                //           suggestionsCallback: UserApiService.getupdatedairportlist,
                //           itemBuilder: (context, Output? suggestion) {
                //             final user = suggestion;
                //
                //             i++;
                //             Color colors = (i % 2 == 0) ? Colors.blue : Colors.white;
                //             Color textcolor = (i % 2 == 0) ? Colors.white : Colors.blue;
                //
                //             return Container(
                //               height: 30,
                //               color: colors,
                //               padding: const EdgeInsets.only(
                //                   left: 5, right: 5, top: 2.5, bottom: 2.5),
                //               child: Text(
                //                 "${user?.name} (${user?.code})",
                //                 style: TextStyle(color: textcolor, fontSize: 19),
                //               ),
                //             );
                //           },
                //           noItemsFoundBuilder: (context) => Container(
                //             height: 80,
                //             child: const Center(
                //               child: Text(
                //                 'No user found',
                //                 style: TextStyle(fontSize: 17, color: Colors.blue),
                //               ),
                //             ),
                //           ),
                //           onSuggestionSelected: (Output? suggestion) {
                //             final user = suggestion!;
                //             setState(() {
                //               isPressed = true;
                //               departSuggestionValue = user.name!;
                //               departairportCode = user.code!;
                //             });
                //           },
                //         ),
                //       ),
                //       Visibility(
                //         visible: deparvisibility,
                //         child: CircularProgressIndicator(
                //           color: Colors.white,
                //
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: Diamensions.height5,
                ),
                Container(
                  width: Diamensions.width310+Diamensions.width10*2,
                  height: Diamensions.height53,
                  padding: EdgeInsets.only(left: Diamensions.width10+Diamensions.width5,right: Diamensions.width10+Diamensions.width5),
                  margin:  EdgeInsets.only(left: Diamensions.width10, right: Diamensions.width10),
                  child: TypeAheadField<Output?>(
                    loadingBuilder: (context){
                      return SizedBox(
                        height: Diamensions.height10*5,
                        child: Center(child: CircularProgressIndicator(
                          color: ColorConstants.backgroundColor,
                        )
                        ),
                      );
                    },
                    minCharsForSuggestions: 3,
                    hideSuggestionsOnKeyboardHide: true,
                    textFieldConfiguration: TextFieldConfiguration(
                        style: const TextStyle(color: ColorConstants.whitecolr),
                        controller: TextEditingController(
                            text: (isPressedDes) ? destinationSuggestionValue : ""),
                        decoration: InputDecoration(
                            hintText: destinationSuggestionValue,
                            hintStyle:
                            const TextStyle(color: ColorConstants.whitecolr),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.whitecolr, width: 2.0),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.whitecolr, width: 2.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstants.whitecolr, width: 2.0)),
                            prefixIcon: const Icon(
                              Icons.place_outlined,
                              color: ColorConstants.whitecolr,
                            ))),
                    suggestionsCallback: UserApiService.getupdatedairportlist,
                    itemBuilder: (context, Output? suggestion) {
                      final user = suggestion;

                      i++;
                      Color colors = (i % 2 == 0) ? Colors.blue : Colors.white;
                      Color textcolor = (i % 2 == 0) ? Colors.white : Colors.blue;

                      return Container(
                        height: 30,
                        color: colors,
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 2.5, bottom: 2.5),
                        child: Text(
                          "${user?.name} (${user?.code})",
                          style: TextStyle(color: textcolor, fontSize: 19),
                        ),
                      );
                    },
                    noItemsFoundBuilder: (context) => Container(
                      height: 80,
                      child: const Center(
                        child: Text(
                          'No user found',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                    onSuggestionSelected: (Output? suggestion) {
                      final user = suggestion!;
                      setState(() {
                        isPressedDes = true;
                        destinationSuggestionValue = user.name!;
                        destinationAirportCode = user.code!;
                      });
                    },
                    errorBuilder:(context,object){
                      return SizedBox(
                        height:Diamensions.height10*5,
                        child: Center(
                            child: Text(" ERROR! ",style: TextStyle(
                                color: Colors.red,
                                fontSize: 25
                            ),)),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Diamensions.height5,
                ),
                //Depart Date value
                Container(
                    width: Diamensions.width310+Diamensions.width10*2,
                    height: Diamensions.height53,
                    padding: EdgeInsets.only(left: Diamensions.width10+Diamensions.width5,right: Diamensions.width10+Diamensions.width5),
                    margin:  EdgeInsets.only(left: Diamensions.width10, right: Diamensions.width10),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                          fixedSize: const Size(50, 40),
                          alignment: const AlignmentDirectional(-1.0, 0),
                          side: const BorderSide(
                              width: 2,
                              color: ColorConstants.whitecolr,
                              style: BorderStyle.solid)),
                      onPressed: () async {
                        await showDateDialog(context);
                      },
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        size: 23,
                        color: ColorConstants.whitecolr,
                      ),
                      label: Text(
                        selectDateText,
                        style: const TextStyle(color: ColorConstants.whitecolr),
                      ),
                    )
                ),
                SizedBox(
                  height: Diamensions.height5,
                ),
                Container(
                  width: Diamensions.width310-Diamensions.width5*2,
                  height: Diamensions.height53-Diamensions.height5,
                  margin:  EdgeInsets.only(left: Diamensions.width10, right: Diamensions.width10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 2,color: Colors.white)
                  ),
                  child: DropdownButton(


                    // Initial Value
                    value: dropdownvalue,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: ColorConstants.whitecolr,
                    ),
                   isExpanded: true,
                    selectedItemBuilder: (BuildContext context) { //<-- SEE HERE
                      return <String>[
                        'Economy',
                        'First',
                        'Business',
                        'Premium',
                      ]
                          .map((String value) {
                        return Center(
                          child: Text(dropdownvalue,
                            style:  TextStyle(color: Colors.white, fontSize: Diamensions.fontsize17),
                          ),
                        );
                      }).toList();
                    },
                    underline: Container(height: 2,color: ColorConstants.backgroundColor,),
                    alignment: Alignment.center,
                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: const TextStyle(
                              color: ColorConstants.iconColror,
                              fontSize: 17),
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
                //Passanger Layout
                Container(
                  width: Diamensions.width310+Diamensions.width10*2,
                  padding: EdgeInsets.only(left: Diamensions.width10+Diamensions.width5,right: Diamensions.width10+Diamensions.width5),
                  margin:  EdgeInsets.only(left: Diamensions.width10, right: Diamensions.width10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(

                        margin: const EdgeInsets.only( top: 10, bottom: 5),
                        child: Stack(
                          children: [

                            Container(
                              padding: EdgeInsets.only(top: Diamensions.height10,bottom: Diamensions.height5,),
                              margin: EdgeInsets.only(top: Diamensions.height5),
                              decoration:  BoxDecoration(
                                  border: Border.all(width: 1.3,color: Colors.white),
                                  borderRadius: BorderRadius.circular(6.0)

                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        if(adultcount >1){
                                          adultcount = adultcount-1;
                                        }
                                      });
                                    },
                                    child: Card(
                                      child: Container(
                                        color: Colors.white,
                                        width: Diamensions.width5*4,
                                        height: Diamensions.width5*4,
                                        margin:  EdgeInsets.all(Diamensions.width1*2),
                                        child: Center(
                                          child: Text("-",style: TextStyle(fontSize: Diamensions.fontsize17),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: Diamensions.width10*3-5,
                                      height: Diamensions.height10*3-5,
                                      child: Center(
                                        child: Text(
                                          "$adultcount",
                                          style:  TextStyle(
                                              color: ColorConstants.whitecolr,
                                              fontSize: Diamensions.fontsize17),
                                        ),
                                      )),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {

                                        adultcount = adultcount+1;

                                      });
                                    },
                                    child: Card(
                                      child: Container(
                                        color: Colors.white,
                                        width: Diamensions.width5*4,
                                        height: Diamensions.width5*4,
                                        margin:  EdgeInsets.all(Diamensions.width1*2),
                                        child: Center(
                                          child: Text("+",style: TextStyle(fontSize: Diamensions.fontsize17),),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                child: Container(
                                  color: ColorConstants.backgroundColor,
                                  child: Text("Adult",style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                left: Diamensions.width10*3,
                                bottom: Diamensions.height40-Diamensions.height1*2

                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Diamensions.height5,
                      ),
                      Container(

                        margin: const EdgeInsets.only( top: 10, bottom: 5),
                        child: Stack(
                          children: [

                            Container(
                              padding: EdgeInsets.only(top: Diamensions.height10,bottom: Diamensions.height5,),
                              margin: EdgeInsets.only(top: Diamensions.height5),
                              decoration:  BoxDecoration(
                                  border: Border.all(width: 1.3,color: Colors.white),
                                  borderRadius: BorderRadius.circular(6.0)

                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        if(childcount >0){
                                          childcount = childcount-1;
                                        }
                                      });
                                    },
                                    child: Card(
                                      child: Container(
                                        color: Colors.white,
                                        width: Diamensions.width5*4,
                                        height: Diamensions.width5*4,
                                        margin:  EdgeInsets.all(Diamensions.width1*2),
                                        child: Center(
                                          child: Text("-",style: TextStyle(fontSize: Diamensions.fontsize17),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: Diamensions.width10*3-5,
                                      height: Diamensions.height10*3-5,
                                      child: Center(
                                        child: Text(
                                          "$childcount",
                                          style:  TextStyle(
                                              color: ColorConstants.whitecolr,
                                              fontSize: Diamensions.fontsize17),
                                        ),
                                      )),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {

                                        childcount = childcount+1;

                                      });
                                    },
                                    child: Card(
                                      child: Container(
                                        color: Colors.white,
                                        width: Diamensions.width5*4,
                                        height: Diamensions.width5*4,
                                        margin:  EdgeInsets.all(Diamensions.width1*2),
                                        child: Center(
                                          child: Text("+",style: TextStyle(fontSize: Diamensions.fontsize17),),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                child: Container(
                                  color: ColorConstants.backgroundColor,
                                  child: Text("Child",style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                left: Diamensions.width10*3,
                                bottom: Diamensions.height40-Diamensions.height1*2
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Diamensions.height5,
                      ),
                      Container(

                        margin: const EdgeInsets.only( top: 10, bottom: 5),
                        child: Stack(
                          children: [

                            Container(
                              padding: EdgeInsets.only(top: Diamensions.height10,bottom: Diamensions.height5,),
                              margin: EdgeInsets.only(top: Diamensions.height5),
                              decoration:  BoxDecoration(
                                  border: Border.all(width: 1.3,color: Colors.white),
                                  borderRadius: BorderRadius.circular(6.0)

                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        if(infantcount >0){
                                          infantcount = infantcount-1;
                                        }
                                      });
                                    },
                                    child: Card(
                                      child: Container(
                                        color: Colors.white,
                                        width: Diamensions.width5*4,
                                        height: Diamensions.width5*4,
                                        margin:  EdgeInsets.all(Diamensions.width1*2),
                                        child: Center(
                                          child: Text("-",style: TextStyle(fontSize: Diamensions.fontsize17),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: Diamensions.width10*3-5,
                                      height: Diamensions.height10*3-5,
                                      child: Center(
                                        child: Text(
                                          "$infantcount",
                                          style:  TextStyle(
                                              color: ColorConstants.whitecolr,
                                              fontSize: Diamensions.fontsize17),
                                        ),
                                      )),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {

                                        infantcount = infantcount+1;

                                      });
                                    },
                                    child: Card(
                                      child: Container(
                                        color: Colors.white,
                                        width: Diamensions.width5*4,
                                        height: Diamensions.width5*4,
                                        margin:  EdgeInsets.all(Diamensions.width1*2),
                                        child: Center(
                                          child: Text("+",style: TextStyle(fontSize: Diamensions.fontsize17),),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                child: Container(
                                  color: ColorConstants.backgroundColor,
                                  child: Text("Infant",style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                left: Diamensions.width10*3,
                                bottom: Diamensions.height40-Diamensions.height1*2
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


                Container(
                  width: 320,
                  margin:
                  const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
                  child: FloatingActionButton.extended(
                    backgroundColor: ColorConstants.greencolor,
                    onPressed: () {
                      final String url = Uri.parse(
                          "https://flights.flydealfare.com/web/air/default.aspx?siid=999886&AirSegCount=1&aCount=$adultcount&sCount=0&cCount=$childcount&yCount=$infantcount&iSCount=0&iLCount=0&Class=$dropdownvalue&Refundable=&AirSeg_1=$departairportCode|$destinationAirportCode|$selectDateText||||3|3")
                          .toString();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                url: url,
                              )));
                    },
                    label: const Text(
                      'Search Now ',
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                  ),
                ),


                Container(
                  margin:
                  const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset('assets/images/reward_large.png')),
                    label: const Text('Price Match Promise'),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> showDateDialog(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(3050),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme(
                      brightness: Brightness.light,
                      primary: ColorConstants.iconColror,
                      onPrimary: Colors.white,
                      secondary: Colors.white,
                      onSecondary: Colors.white,
                      error: Colors.red,
                      onError: Colors.red,
                      background: Colors.white,
                      onBackground: Colors.white,
                      surface: ColorConstants.backgroundColor,
                      onSurface: ColorConstants.backgroundColor)),
              child: child!);
        });

    if (picked != null && picked != selectDateText) {
      setState(() {
        selectDateText = "${picked.month}/${picked.day}/${picked.year}";
      });
    }
  }


}
