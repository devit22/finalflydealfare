import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/RegisterResponse.dart';
import 'package:fly_deal_fare/ui/login_screen.dart';
import 'package:fly_deal_fare/ui/open_pravicy_policy_url.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';

import '../userapiservices/user_api_services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late bool _passwordVisible;
  bool isvisible = true;
  var emailControler = TextEditingController();
  var passwordControler = TextEditingController();
  var nameControler = TextEditingController();
  var numberControler = TextEditingController();

  bool circularvisibility = false;
  var countrycode = "+91";
  var codetextg = "+91 (IN)";
  var codeg = "+91";

  @override
  void dispose() {
    super.dispose();
     emailControler.dispose();
    passwordControler.dispose();
    nameControler.dispose();
    numberControler.dispose();
  }
  @override
  void initState() {
    _passwordVisible = false;
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
          'Register Screen',
          style: TextStyle(color: ColorConstants.iconColror),
        ),
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

                Container(
                  margin:   EdgeInsets.only(left: Diamensions.width10,right: Diamensions.width10,top: Diamensions.width10),
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,

                  child: Material(
                    color: ColorConstants.backgroundColor,
                    elevation: Diamensions.width10,
                    borderRadius: BorderRadius.all(Radius.circular(Diamensions.width10*2),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin:  EdgeInsets.only(left: Diamensions.width10*2,right: Diamensions.width10*2,top: Diamensions.width10*2,),
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailControler,
                              style: const TextStyle(color: ColorConstants.whitecolr),
                              decoration:  InputDecoration(
                                  labelText: "Enter Email",
                                  labelStyle:  TextStyle(color: ColorConstants.whitecolr) ,
                                  hintStyle: TextStyle(color: ColorConstants.whitecolr),
                                  border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: ColorConstants.whitecolr, width: Diamensions.width1*2),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: ColorConstants.whitecolr, width: Diamensions.width1*2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorConstants.whitecolr, width: Diamensions.width1*2)),
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: ColorConstants.whitecolr,
                                  )
                              )
                          ),
                        ),
                        Container(
                          margin:  EdgeInsets.only(left: Diamensions.width10*2,right: Diamensions.width10*2,top:Diamensions.width10),
                          child: TextFormField(
                              obscureText: !_passwordVisible,
                              keyboardType: TextInputType.text,
                              controller: passwordControler,
                              style: const TextStyle(color: ColorConstants.whitecolr),
                              decoration:  InputDecoration(
                                  labelText: "Enter Password",
                                  labelStyle: const TextStyle(color: ColorConstants.whitecolr) ,
                                  hintStyle: const TextStyle(color: ColorConstants.whitecolr),
                                  border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: ColorConstants.whitecolr, width: Diamensions.width1*2),
                                  ),
                                  disabledBorder:  OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: ColorConstants.whitecolr, width: Diamensions.width1*2),
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorConstants.whitecolr, width: Diamensions.width1*2)),
                                  prefixIcon:  const Icon(
                                    Icons.phonelink_lock,
                                    color: ColorConstants.whitecolr,
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed:(){
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                      icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off,color: ColorConstants.whitecolr,)
                                  )
                              )
                          ),
                        ),
                        Container(
                          width: Diamensions.width310,
                          margin:  EdgeInsets.only(left: Diamensions.width10*2,right: Diamensions.width10*2,top:Diamensions.width10),
                          child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: nameControler,
                              style: const TextStyle(color: ColorConstants.whitecolr),
                              decoration:  InputDecoration(
                                  labelText: "Enter Name",
                                  labelStyle: const TextStyle(color: ColorConstants.whitecolr) ,
                                  hintStyle: const TextStyle(color: ColorConstants.whitecolr),
                                  border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: ColorConstants.whitecolr, width: Diamensions.width1*2),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: ColorConstants.whitecolr, width: Diamensions.width1*2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorConstants.whitecolr, width: Diamensions.width1*2)),
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: ColorConstants.whitecolr,
                                  )
                              )
                          ),
                        ),
                        Container(
                          height: Diamensions.width10*6,

                          margin:  EdgeInsets.only(left: Diamensions.width10+Diamensions.width5, right:Diamensions.width10+Diamensions.width5, top: Diamensions.height10),
                          width: Diamensions.width310,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: Diamensions.width1*2),
                            borderRadius: BorderRadius.circular(Diamensions.width5),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: Diamensions.width10*9,
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
                                        borderRadius:  BorderRadius.only(
                                          topLeft: Radius.circular(Diamensions.width10*4),
                                          topRight: Radius.circular(Diamensions.width10*4),
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
                                  margin: EdgeInsets.only(right: Diamensions.width10),
                                  child: TextField(
                                    onChanged: (value){
                                    },
                                    style: const TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.number,
                                    controller: numberControler,
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
                          child: FloatingActionButton.extended(
                            backgroundColor: ColorConstants.greencolor,
                            onPressed: () {
                              setState(() {
                                if(isvisible){
                                  isvisible = false;
                                }else{
                                  isvisible = true;
                                }
                              });
                              registerUser();
                            },
                            label: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white, fontSize: 19),
                            ),
                          ),
                        ),
                        Container(
                          height: 35,
                          margin: EdgeInsets.only(right: 20),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const LogInScreen()));
                              },
                              child: const  Text(" Already Register? Click here",style: TextStyle(color: ColorConstants.whitecolr),)),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 20),

                            child:   Text("By Joining FlyDealFare you Agree to FlyDealFare",style: TextStyle(color: ColorConstants.whitecolr),)),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: TextButton(
                                  onPressed: (){
                                    String url = "https://flydealfare.com/terms-and-conditions/";
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => OpenPravicyPolicyUrl(
                                          url:url,title: "Term & Condition",)));
                                  },
                                  child: const Text("Term & Condition ",style: TextStyle(color: ColorConstants.iconColror,decoration: TextDecoration.underline),
                                  )
                              ),
                            ),
                            const Text("and ",style: TextStyle(color: ColorConstants.whitecolr,decoration: TextDecoration.underline)),
                            TextButton(
                                onPressed: (){
                                  String url = "https://flydealfare.com/terms-and-conditions/";
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => OpenPravicyPolicyUrl(
                                        url:url,title:"Privacy Policy" ,)));
                                },
                                child: const Text("Privacy Policy",style: TextStyle(color: ColorConstants.iconColror,decoration: TextDecoration.underline),
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Diamensions.height5,
                ),
                Divider(thickness: 1.2,color: ColorConstants.greencolor,),
              ],
            ),
          ),

          Visibility(
            visible: circularvisibility,
            child: const Center(
              child: CircularProgressIndicator(
                backgroundColor: ColorConstants.greencolor,
              ),
            ),
          ),
        ],

      ),
    );
  }

  void registerUser() async{

    var emailText = emailControler.text.toString();
    var passwordText= passwordControler.text.toString();
    var nameText = nameControler.text.toString();
     var numberText = numberControler.text.toString();
    if(emailText == "" || passwordText=="" || nameText==""){
      ScaffoldMessenger.of(context).showSnackBar(
          const  SnackBar(content:   Text(" Plese fill all fields "))
      );
    }else{
      setState(() {
        circularvisibility = true;
       });


    UserApiService.getResgisterelinkList(emailText, passwordText, nameText, numberText, "SignUp").then((value) {

      print(" data => ${value.data}");
      print(" error => ${value.error}");
      print(" status => ${value.status}");
      setState(() {
        circularvisibility = false;
      });
      if(value.data == "User Alredy Exist"){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:   Text(" ${value.data}"))
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:   Text(" ${value.data}"))
        );
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const LogInScreen()));

      }

    });

      // try {
      //   final credential =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //     email: emailText,
      //     password: passwordText,
      //   );
      //   if(credential.user != null){
      //     ScaffoldMessenger.of(context).showSnackBar(
      //         const  SnackBar(content:   Text("User Registered"))
      //     );
      //     Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  LogInScreen()));
      //     setState(() {
      //       circularvisibility = false;
      //     });
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) =>  const LogInScreen())
      //     );
      //   }
      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'weak-password') {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //         const  SnackBar(content:   Text("The password provided is too weak."))
      //     );
      //
      //   } else if (e.code == 'email-already-in-use') {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //         const  SnackBar(content:   Text("The account already exists for that email."))
      //     );
      //     print('');
      //   }
      // } catch (e) {
      //   print(e);
      // }
    }

  }
}
