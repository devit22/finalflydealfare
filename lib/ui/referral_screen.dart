
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/output.dart';
import 'package:fly_deal_fare/ui/reward_screen.dart';
import 'package:fly_deal_fare/ui/root_home_screen.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';

import '../models/Data.dart';

class ReferralFormScreen extends StatefulWidget {
  Data? loggedindata;
   ReferralFormScreen({Key? key,this.loggedindata}) : super(key: key);

  @override
  State<ReferralFormScreen> createState() => _ReferralFormScreenState();
}

class _ReferralFormScreenState extends State<ReferralFormScreen> {

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
  var smsmcod = "some";
   var issubmitData = false;
@override
  void dispose() {
    super.dispose();
    emailcontrollere.dispose();
    passwordcontroller.dispose();
    numbercontroller.dispose();
    namecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var i = 0;
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
              'Referral Form',
              style: TextStyle(color: ColorConstants.iconColror),
            ),
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
            ]
        ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Diamensions.height5,
                      ),
                      Divider(thickness: 1.2,color: ColorConstants.greencolor,),
                      SizedBox(
                        height: Diamensions.height5,
                      ),
                      Container(
                        margin:  EdgeInsets.only(left:Diamensions.width10, right:Diamensions.width10),
                        width: MediaQuery.of(context).size.width,
                        child: Material(
                          color: ColorConstants.backgroundColor,
                          elevation: Diamensions.width10,
                          borderRadius: BorderRadius.all(Radius.circular(Diamensions.width10),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [

                                SizedBox(
                                  height: Diamensions.height10*2,
                                ),

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
                                  ),
                                ),
                                SizedBox(
                                  height: Diamensions.height10,
                                ),
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
                                  ),
                                ),
                                SizedBox(
                                  height: Diamensions.height10,
                                ),
                                Container(
                                  width: Diamensions.width310,

                                  child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: namecontroller,
                                      style: const TextStyle(color: ColorConstants.whitecolr),
                                      decoration: const InputDecoration(
                                          labelText: "Enter Name",
                                          labelStyle:
                                          TextStyle(color: ColorConstants.whitecolr),
                                          hintStyle:
                                          TextStyle(color: ColorConstants.whitecolr),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants.whitecolr,
                                                width: 2.0),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants.whitecolr,
                                                width: 2.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ColorConstants.whitecolr,
                                                  width: 2.0)),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: ColorConstants.whitecolr,
                                          ))),
                                ),
                                SizedBox(
                                  height: Diamensions.height10,
                                ),
                                Container(
                                  width: Diamensions.width310,

                                  child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailcontrollere,
                                      style: const TextStyle(color: ColorConstants.whitecolr),
                                      decoration: const InputDecoration(
                                          labelText: "Enter Email",
                                          labelStyle:
                                          TextStyle(color: ColorConstants.whitecolr),
                                          hintStyle:
                                          TextStyle(color: ColorConstants.whitecolr),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants.whitecolr,
                                                width: 2.0),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants.whitecolr,
                                                width: 2.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ColorConstants.whitecolr,
                                                  width: 2.0)),
                                          prefixIcon: Icon(
                                            Icons.email_outlined,
                                            color: ColorConstants.whitecolr,
                                          ))),
                                ),
                                SizedBox(
                                  height: Diamensions.height10,
                                ),
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
                                Container(
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
                                ),
                                SizedBox(
                                  height: Diamensions.height10*2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Diamensions.height5,
                      ),
                      Divider(thickness: 1.2,color: ColorConstants.greencolor,),
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
                            submitvalues();

                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Diamensions.height5,
                      ),
                      Divider(thickness: 1.2,color: ColorConstants.greencolor,),
                      SizedBox(
                        height: Diamensions.height5,
                      ),
                    ],
                  ),
                ),

                Visibility(
                    visible: issubmitData,
                    child: Center(
                      child: const CircularProgressIndicator(color: ColorConstants.greencolor,),
                    )
                )
              ],
            ),
    );
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
        selectDateText = "${picked.year}-${picked.day}-${picked.month}";
      });
    }
  }

  void submitvalues() {
    var departdateText = selectDateText;
setState(() {
  issubmitData = true;
  departdateText = selectDateText;
});
  var  departcity = departSuggestionValue;
  var  descity = destinationSuggestionValue;
  var  nametext = namecontroller.text.toString();
  var  numbertext = "+"+codeg+numbercontroller.text.toString();
   var emailtext = emailcontrollere.text.toString();

   if(departdateText != "" && departcity != "" && descity != ""  && nametext != ""  && numbertext != ""  && emailtext != ""){


     UserApiService.sendreferData(widget.loggedindata!.id!, departcity, descity, departdateText, emailtext, numbertext, nametext).then((value) {


       if(value.data == "Data Insert Completed"){
         ScaffoldMessenger.of(context).showSnackBar(
             const  SnackBar(content:   Text("We will contact You soon"))
         );

         setState(() {
           issubmitData = false;
           Navigator.push(context,
               MaterialPageRoute(builder: (context) => HomeScreen(loggedindata: widget.loggedindata,pageIndex: 0,iscomponentload: true,isLoggedIn: true,bottomindex: 1,))
           );



         });
       }else{
         ScaffoldMessenger.of(context).showSnackBar(
             const  SnackBar(content:   Text("Something went wrong"))
         );

         setState(() {
           issubmitData = false;
         });
       }



     });

   }else{
     ScaffoldMessenger.of(context).showSnackBar(
         const  SnackBar(content:   Text("Please Fill All Fields"))
     );
     setState(() {
       issubmitData = false;
     });
   }

  }
}
