import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/Data.dart';
import 'package:fly_deal_fare/models/output.dart';
import 'package:fly_deal_fare/ui/SpecialDealSearch.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';
import 'package:fly_deal_fare/utils/radio_button_class.dart';

class Deals extends StatefulWidget {
  Data? loggedindata;
  final bool isLoggedIn;
   Deals({Key? key,required this.loggedindata,this.isLoggedIn = false}) : super(key: key);

  @override
  State<Deals> createState() => _DealsState();
}

class _DealsState extends State<Deals> {

  var selectDateText = "Depart Date";
  var departairportCode = "some";
  var destinationAirportCode = "some";
  var departSuggestionValue = "Depart City";
  var destinationSuggestionValue = "Destination City";
  var fieldText = TextEditingController();
  var isPressed = false;
  var isPressedDes = false;
  var emailcontrollere = TextEditingController();
  var passwordcontroller = TextEditingController();
  var numbercontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var codetextg = "+91 (IN)";
  var codeg = "+91";
  String startDateText = "Depart Date";
  String endDateText = "Return Date";
TypeOfWay _typeOfWay = TypeOfWay.one;

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
  var isDataSubmitted = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDataSubmitted = false;
  }
@override
  void dispose() {
    super.dispose();
    fieldText.dispose();
    emailcontrollere.dispose();
    passwordcontroller.dispose();
    numbercontroller.dispose();
    namecontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var i =0;
    return Scaffold(
      body:  Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Diamensions.height5,
              ),
              const Divider(thickness: 1.2,color: ColorConstants.greencolor,),
              SizedBox(
                width: MediaQuery.of(context).size.width,

                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: Diamensions.height10,vertical: Diamensions.height5),
                  child: Card(
                    elevation: 10,
                    color: ColorConstants.backgroundColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Diamensions.width10,vertical: Diamensions.height5),
                      child: Text("Special Call Only Cheap Flights Deals To India",
                        style: TextStyle(
                          color: ColorConstants.whitecolr,
                          fontSize: Diamensions.fontsize17,

                        ),

                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //     margin: EdgeInsets.symmetric(horizontal: Diamensions.width10),
              //     child: Center(
              //       child: Text("Special Call Only Cheap Flights Deals To India",
              //         style: TextStyle(
              //             color: ColorConstants.backgroundColor,
              //             fontSize: Diamensions.fontsize30-Diamensions.fontsize5,
              //             decoration: TextDecoration.underline
              //         ),
              //       ),
              //     )
              // ),
              const Divider(thickness: 1.2,color: ColorConstants.greencolor,),
              Container(
                margin:  EdgeInsets.only(left: Diamensions.width10, right:  Diamensions.width10, top: Diamensions.height5),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                child: Material(
                  color: ColorConstants.backgroundColor,
                  elevation: Diamensions.width10,
                  borderRadius: BorderRadius.all(Radius.circular(Diamensions.width10),
                  ),
                  child: Column(
                    children: [
                      //Radio buttons
                      Container(
                        width: Diamensions.width310,
                        alignment: Alignment.centerLeft,
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.white, width: 2),
                        //   borderRadius: BorderRadius.circular(5.0),
                        // ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: [
                                  Radio<TypeOfWay>(
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => ColorConstants.whitecolr),
                                    focusColor: MaterialStateColor.resolveWith(
                                            (states) => ColorConstants.whitecolr),
                                    value: TypeOfWay.one,
                                    groupValue: _typeOfWay,
                                    onChanged: (TypeOfWay? value) {
                                      setState(() {
                                        _typeOfWay = value!;
                                      });
                                      print(_typeOfWay.name);
                                    },
                                  ),
                                  const Text('One Way',
                                      style: TextStyle(
                                          color: ColorConstants.whitecolr)),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Radio<TypeOfWay>(
                                    fillColor: MaterialStateColor.resolveWith(
                                            (states) => ColorConstants.whitecolr),
                                    focusColor: MaterialStateColor.resolveWith(
                                            (states) => ColorConstants.whitecolr),
                                    value: TypeOfWay.round,
                                    groupValue: _typeOfWay,
                                    onChanged: (TypeOfWay? value) {
                                      setState(() {
                                        _typeOfWay = value!;
                                      });
                                      print(_typeOfWay.name);
                                    },
                                  ),
                                  const Text('Round Way',
                                      style: TextStyle(color: ColorConstants.whitecolr)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //deepar city
                      Container(
                        width: Diamensions.width310,
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
                              child: const Center(
                                  child: Text(" ERROR! ",style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 25
                                  ),)),
                            );
                          },
                        ),
                      ),

                      SizedBox(
                        height: Diamensions.height10,
                      ),
                      //destination city
                      Container(
                        width: Diamensions.width310,
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
                              child: const Center(
                                  child: Text(" ERROR! ",style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 25
                                  ),)),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: Diamensions.height10,
                      ),
                      Container(
                        width: Diamensions.width310,
                        child: TextFormField(

                          style: const TextStyle(color: ColorConstants.whitecolr),
                          decoration: const InputDecoration(
                            labelText: 'Enter email',
                            labelStyle: TextStyle(color: ColorConstants.whitecolr),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.whitecolr, width: 2.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.whitecolr, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstants.whitecolr, width: 2.0)),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: ColorConstants.whitecolr,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Diamensions.height10,
                      ),
                      Container(
                        width: Diamensions.width310,
                        child: TextFormField(

                          style: const TextStyle(color: ColorConstants.whitecolr),
                          decoration: const InputDecoration(
                            labelText: 'Enter Name',
                            labelStyle: TextStyle(color: ColorConstants.whitecolr),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.whitecolr, width: 2.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.whitecolr, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstants.whitecolr, width: 2.0)),
                            prefixIcon: Icon(
                              Icons.person,
                              color: ColorConstants.whitecolr,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Diamensions.height10,
                      ),
                      //number
                      Container(
                        height: 62.5,

                        width: Diamensions.width310,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: Diamensions.width40*2+Diamensions.width10,
                              child: TextButton(
                                onPressed: () {
                                  showCountryPicker(
                                    context: context,
                                    favorite: <String>['IN'],
                                    //Optional. Shows phone code before the country name.
                                    showPhoneCode: true,
                                    onSelect: (Country country) {


                                      setState(() {
                                        var name = country.countryCode;
                                        codeg = country.phoneCode;

                                        codetextg = "+$codeg ($name)";
                                      });
                                      print("$codetextg");
                                    },
                                    // Optional. Sets the theme for the country list picker.
                                    countryListTheme: CountryListThemeData(
                                      // Optional. Sets the border radius for the bottomsheet.
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(40.0),
                                        topRight: Radius.circular(40.0),
                                      ),
                                      // Optional. Styles the search field.
                                      inputDecoration: InputDecoration(
                                        labelText: 'Search',
                                        hintText: 'Start typing to search',
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child:  Text('$codetextg'),
                              ),
                            ),
                            Flexible(
                              child:Container(
                                margin: EdgeInsets.only(right: 10),
                                child: TextField(
                                  onChanged: (value){
                                  },
                                  style: const TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.number,
                                  controller: numbercontroller,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter Number',
                                    hintStyle: TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Diamensions.height10,
                      ),
                      //depart date layout
                      (_typeOfWay.name == "one")?Container(
                          width: Diamensions.width310,
                          height: Diamensions.height53,
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
                      ): Container(
                        width: Diamensions.width310,


                        child: Row(
                          children: [
                            Container(
                                height: Diamensions.width53,
                                width: Diamensions.width145,
                                margin:  EdgeInsets.only(right: Diamensions.width5,bottom: Diamensions.height5),
                                child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                      fixedSize: const Size(50, 40),
                                      alignment: const AlignmentDirectional(-1.0, 0),
                                      side: const BorderSide(
                                          width: 2,
                                          color: ColorConstants.whitecolr,
                                          style: BorderStyle.solid)),
                                  onPressed: () async {
                                    await roundDateDialog(context);
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month_outlined,
                                    size:  23,
                                    color: ColorConstants.whitecolr,
                                  ),
                                  label: Text(
                                    startDateText,
                                    style: const TextStyle(color: ColorConstants.whitecolr),
                                  ),
                                )),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Container(

                                  height: Diamensions.width53,
                                  margin:  EdgeInsets.only(
                                      left: Diamensions.width10, bottom: Diamensions.height5),
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                        fixedSize: const Size(50, 40),
                                        alignment: const AlignmentDirectional(-1.0, 0),
                                        side: const BorderSide(
                                            width: 2,
                                            color: ColorConstants.whitecolr,
                                            style: BorderStyle.solid)),
                                    onPressed: () async {
                                      await roundDateDialog(context);
                                    },
                                    icon: const Icon(
                                      Icons.calendar_month_outlined,
                                      size: 23,
                                      color: ColorConstants.whitecolr,
                                    ),
                                    label: Text(
                                      endDateText,
                                      style: const TextStyle(color: ColorConstants.whitecolr),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: Diamensions.height10,
                      ),
                      Container(
                        width: Diamensions.width310,
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
                        width: Diamensions.width310+Diamensions.width10*3,
                        padding: EdgeInsets.only(left: Diamensions.width10+Diamensions.width5,right: Diamensions.width10+Diamensions.width5),

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
                                      left: Diamensions.width10*3,
                                      bottom: Diamensions.height40-Diamensions.height1*2,
                                      child:  Container(
                                        color: ColorConstants.backgroundColor,
                                        child: const Text("Adult",style: TextStyle(color: Colors.white),
                                        ),
                                      )

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
                                      left: Diamensions.width10*3,
                                      bottom: Diamensions.height40-Diamensions.height1*2,
                                      child: Container(
                                        color: ColorConstants.backgroundColor,
                                        child: const Text("Child",style: TextStyle(color: Colors.white),
                                        ),
                                      )
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
                                      left: Diamensions.width10*3,
                                      bottom: Diamensions.height40-Diamensions.height1*2,
                                      child: Container(
                                        color: ColorConstants.backgroundColor,
                                        child: Text("Infant",style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Diamensions.height10,
                      ),


                    ],
                  ),
                ),
              ),

              SizedBox(
                height: Diamensions.height5,
              ),
              const Divider(thickness: 1.2,color: ColorConstants.greencolor,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: Diamensions.height10*5,
                margin:  EdgeInsets.only(
                    left: Diamensions.width10*2, right: Diamensions.width10*2, top: Diamensions.width10,bottom: Diamensions.height5),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      elevation: 15,
                      foregroundColor: ColorConstants.whitecolr,
                      backgroundColor: ColorConstants.greencolor,
                      side: const BorderSide(
                        width: 2,
                        color: ColorConstants.whitecolr,
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  onPressed: () {
    if(widget.isLoggedIn){
      showlist();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const  SnackBar(content:   Text("Please Sign In Your Self"))
      );
    }



                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              const Divider(thickness: 1.2,color: ColorConstants.greencolor,),
              SizedBox(
                height: Diamensions.height10,
              ),

            ],
          ),
        ),
        Visibility(
          visible: isDataSubmitted,
            child: const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.greencolor,
              ),
            )
        )
        
      ],
      ),
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
        selectDateText = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }
  Future<void> roundDateDialog(BuildContext context) async {
    final picked = await showDateRangePicker(
        context: context,
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

    if (picked != null) {
      setState(() {
        selectDateText =
        "${picked.start.year}-${picked.start.month}-${picked.start.day}";
        endDateText =
        "${picked.end.year}-${picked.end.month}-${picked.end.day}";
      });
    }
  }
  void showlist() {
  setState(() {
    isDataSubmitted = true;
  });
    var numbertext = numbercontroller.text.toString();
    var finalnumberText = "$codeg$numbertext";
    var departcode = departairportCode;
    var descode = destinationAirportCode;

    if(departairportCode != "some" && descode !=  "some"){

      if(_typeOfWay.name == 'one'){
        var DateSelectText = selectDateText;

        UserApiService.submitsecretdata(widget.loggedindata!.id!, departSuggestionValue, destinationSuggestionValue, dropdownvalue, DateSelectText,"Searched One Way","$adultcount","$childcount","$infantcount", emailcontrollere.text, finalnumberText, namecontroller.text, _typeOfWay.name).then((value) {

          print(value.data);
           Navigator.push(context, MaterialPageRoute(builder: (builder) => SpecialDealSearch(isoneway: "one",fromDate: DateSelectText,depcode: departcode,descode: descode)));
        });

      }else{
        var startDate = startDateText;
        var endDate = endDateText;

        UserApiService.submitsecretdata(widget.loggedindata!.id!, departSuggestionValue, destinationSuggestionValue, dropdownvalue, startDate,endDate,"$adultcount","$childcount","$infantcount", emailcontrollere.text, finalnumberText, namecontroller.text, _typeOfWay.name).then((value) {
          print(value.data);
          Navigator.push(context, MaterialPageRoute(builder: (builder) => SpecialDealSearch(isoneway: "round",depcode: departcode,descode: descode,fromDate: startDate,)));
        });
      }
      setState(() {
        isDataSubmitted = false;
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const  SnackBar(content:   Text("Please select both Airports"))
      );
    }



  }
}
