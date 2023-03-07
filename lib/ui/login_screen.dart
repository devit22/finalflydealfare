
import 'dart:convert';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/Data.dart';
import 'package:fly_deal_fare/ui/open_pravicy_policy_url.dart';
import 'package:fly_deal_fare/ui/register_screen.dart';
import 'package:fly_deal_fare/ui/root_home_screen.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/diamensions.dart';






class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  late bool _passwordVisible;
  late bool _gmaillayoutVisible = true;
  late bool _numberlayoutVisible = false;
  late bool _otpverifylayoutVisible = false;

  bool circularvisibility = false;
  var emailControler = TextEditingController();
  var passwordControler = TextEditingController();
  var numberControler = TextEditingController();
  var otpControler = TextEditingController();
  var nameControler = TextEditingController();
  var forgotemailController = TextEditingController();
  var countrycode = "+91";
  var codetextg = "+91 (IN)";
  var codeg = "+91";
  var smsmcod = "some";
  var verificationID = "some";
  Data? loggedInUser;
  late FirebaseAuth auth;
  bool _isloggedIn = false;
  Map _userObj = {};
  String nameText="defaule";
  String finalnumber="default";

  //for facebok
  Map<String, dynamic>? _userData;
  //AccessToken? _accessToken;
  bool _checking = true;
  var loggedin = true;
@override
  void dispose() {
    super.dispose();
     emailControler.dispose();
     passwordControler.dispose();
     numberControler.dispose();
     otpControler.dispose();
     nameControler.dispose();
     forgotemailController.dispose();
  }
  @override
  void initState() {
    _passwordVisible = false;
    auth = FirebaseAuth.instance;
    loggedInUser = new Data(id:"123",name:"Rahoul",email:"rahoul123@gmail.com",mobile: "7889105686",address: "zirakpur",username: "rahoul123@gmail.com",password: "sdfsd324234sdfs",pass_value: "abctest@123",dated: "2022-01-01",last_login: "2022-09-12",source: "Default");
  checkloggedIn();

  }

  void emailandpasswordsigning() async {
    var emailText = emailControler.text.toString();
    var passwordText = passwordControler.text.toString();

    if (emailText == "" || passwordText == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all Fields"))
      );
    } else {
      setState(() {
        circularvisibility = true;
      });

      UserApiService.getLoggedInList(emailText, passwordText,context).then((value) {
        setState(() {
          circularvisibility = false;
        });

        final map = json.decode(value.body.toString()) as Map<String, dynamic>;

        if (map['data'].runtimeType == String) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(" ${map['data']}"))
          );
        } else {
          var obj = Data(id: map['data']['id'],
              name: map['data']['name'],
              email: map['data']['email'],
              mobile: map['data']['mobile'],
              address: map['data']['address'],
              username: map['data']['username'],
              password: map['data']['password'],
              pass_value: map['data']['pass_value'],
              dated: map['data']['dated'],
              last_login: map['data']['last_login'],
              source: map['data']['source'],
          );
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen(loggedindata: obj,iscomponentload: true,isLoggedIn: true))

          );
       }
      });

    }
  }


  void guestuser() async {
    setState(() {
      circularvisibility = true;
    });
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signed in with temporary account.")));
      print("Signed in with temporary account.");
      if (userCredential.user != null) {
        setState(() {
          circularvisibility = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen())
        );
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  void googlesignin(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // final GoogleSignInAccount? googleSignInAccount = await googleSignIn
    //     .signIn();

    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn(
      scopes: ['email', 'profile'],
      hostedDomain: '',
    ).signIn();


    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
          .authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User user = result.user!;

      if (user != null) {
        UserApiService.getResgisterelinkList(
            user.email.toString(), "Not Available", user.displayName.toString(),
            "Not Available", "Gmail").then((value) {
          //
          if (value.data == "Registration Completed") {
            FirebaseFirestore.instance.collection("users").doc(
                auth.currentUser!.uid).set({
              "UserId": value.UserId
            }).then((values) =>
            {
              fetchlogindata(value.UserId!),

            });
          } else if(value.data == "User Alredy Exist") {
            String userid="";
            FirebaseFirestore.instance.collection("users").doc(user.uid).get().then((vardata)  {
               userid  = vardata['UserId'];
               fetchlogindata(userid);
            });
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
                const  SnackBar(content:   Text("Something went wrong"))
            );
          }
        });
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }

    fetchlogindata(String userid)  async{
    UserApiService.getuserlistwithuserid(userid).then((value) =>
    {
      loggedInUser = Data(
          id: value[0].id,
          name: value[0].name,
          email: value[0].email,
          mobile: value[0].mobile,
          address: value[0].address,
          username: value[0].username,
          password: value[0].password,
          pass_value: value[0].passValue,
          dated: value[0].dated,
          last_login: value[0].lastLogin,
          source: value[0].source
      )
    });
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>
            HomeScreen(loggedindata: loggedInUser,
              pageIndex: 0,
              iscomponentload: true,isLoggedIn: true,)));

  }

  // void facebooksignin(BuildContext context) async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   FacebookAuth.instance.login(permissions: ['email','public_profile']).then((
  //       value) async {
  //     print("message => ${value.message}");
  //     print("status => ${value.status}");
  //     print("accesstoken => ${value.accessToken}");
  //
  //
  //     var creditial = FacebookAuthProvider.credential(value.accessToken!.token);
  //     UserCredential result = await auth.signInWithCredential(creditial);
  //     User user = result.user!;
  //
  //     if (user != null) {
  //       UserApiService.getResgisterelinkList(user.email.toString(),"Not Available", user.displayName.toString(), "Not Available", "Facebook").then((value){
  //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
  //       });
  //
  //     }
  //     FacebookAuth.instance.getUserData().then((userdata) async {
  //       userdata.forEach((key, value) {
  //         print("$key => $value");
  //       });
  //       setState(() {
  //         _isloggedIn = true;
  //         _userObj = userdata;
  //       });
  //
  //
  //
  //     });
  //
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign In Screen",
          style: TextStyle(color: ColorConstants.iconColror),
        ),
      ),
      body: (loggedin )? Center(
        child: const CircularProgressIndicator(color: ColorConstants.greencolor,),
      ) :Stack(
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
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: Diamensions.height10*5,
                          margin:  EdgeInsets.only(
                              left: Diamensions.width10*2, right: Diamensions.width10*2, top: Diamensions.height10*2, bottom: Diamensions.height5),
                          child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                  side:  BorderSide(
                                    width: Diamensions.width1*2,
                                    color: ColorConstants.whitecolr,
                                  ),
                                  shape:  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(Diamensions.width10*2)))),
                              onPressed: () {
                                googlesignin(context);
                              },
                              icon: SizedBox(
                                  height: Diamensions.height10*3,
                                  width: Diamensions.width10*3,
                                  child: Image.asset('assets/images/google.png')),
                              label: Text("Google")),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   mainAxisSize: MainAxisSize.max,
                        //   children: [
                        //     // Container(
                        //     //   width: 150,
                        //     //   height: 50,
                        //     //   margin: EdgeInsets.only(top: 10),
                        //     //   child: OutlinedButton.icon(
                        //     //       style: OutlinedButton.styleFrom(
                        //     //           side: const BorderSide(
                        //     //             width: 2,
                        //     //             color: ColorConstants.whitecolr,
                        //     //           ),
                        //     //           shape: const RoundedRectangleBorder(
                        //     //               borderRadius:
                        //     //               BorderRadius.all(Radius.circular(20)))),
                        //     //       onPressed: () {
                        //     //
                        //     //        // facebookloginfunction();
                        //     //       },
                        //     //       icon: SizedBox(
                        //     //           height: 30,
                        //     //           width: 30,
                        //     //           child: Image.asset('assets/images/facebook.png')),
                        //     //       label: Text("Facebook")),
                        //     // ),
                        //
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 2,
                              width: 150,
                              color: ColorConstants.whitecolr,
                            ),
                            const Text(
                              "Or",
                              style: TextStyle(
                                  color: ColorConstants.whitecolr, fontSize: 18),
                            ),
                            Container(
                              height: 2,
                              width: 150,
                              color: ColorConstants.whitecolr,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: Diamensions.width10*15,
                              height: 50,
                              margin:  EdgeInsets.only(top: Diamensions.width10),
                              child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: ColorConstants.whitecolr,
                                      ),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(20)))),
                                  onPressed: () {
                                    setState(() {
                                      _gmaillayoutVisible = true;
                                      _numberlayoutVisible = false;
                                      _otpverifylayoutVisible = false;
                                    });
                                  },
                                  icon: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset('assets/images/gmail.png')),
                                  label: const Text("Gmail")),
                            ),
                            Container(
                              width: Diamensions.width10*15,
                              height: 50,
                              margin: EdgeInsets.only(top: 10),
                              child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        width: 2,
                                        color: ColorConstants.whitecolr,
                                      ),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(20)))),
                                  onPressed: () {
                                    setState(() {
                                      _numberlayoutVisible = true;
                                      _gmaillayoutVisible = false;
                                      _otpverifylayoutVisible = false;
                                    });
                                  },
                                  icon: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset('assets/images/telephone.png')),
                                  label: const Text("Number")),
                            ),
                          ],
                        ),
                        // gmail sign in layout
                        Visibility(
                            visible: _gmaillayoutVisible,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 15,
                                  ),
                                  child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailControler,
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
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 10,
                                  ),
                                  child: TextFormField(
                                      obscureText: !_passwordVisible,
                                      keyboardType: TextInputType.text,
                                      controller: passwordControler,
                                      style: const TextStyle(
                                          color: ColorConstants.whitecolr),
                                      decoration: InputDecoration(
                                          labelText: "Enter Password",
                                          labelStyle: const TextStyle(
                                              color: ColorConstants.whitecolr),
                                          hintStyle: const TextStyle(
                                              color: ColorConstants.whitecolr),
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants.whitecolr,
                                                width: 2.0),
                                          ),
                                          disabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants.whitecolr,
                                                width: 2.0),
                                          ),
                                          enabledBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ColorConstants.whitecolr,
                                                  width: 2.0)),
                                          prefixIcon: const Icon(
                                            Icons.phonelink_lock,
                                            color: ColorConstants.whitecolr,
                                          ),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _passwordVisible = !_passwordVisible;
                                                });
                                              },
                                              icon: Icon(
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: ColorConstants.whitecolr,
                                              )))),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 5),
                                  child: FloatingActionButton.extended(
                                    backgroundColor: ColorConstants.greencolor,
                                    onPressed: () {
                                      emailandpasswordsigning();
                                    },
                                    label: const Text(
                                      'Sign In',
                                      style: TextStyle(color: Colors.white, fontSize: 19),
                                    ),
                                  ),
                                ),
                              ],
                            )),

                        //number and otp layout

                        Visibility(
                            visible: _numberlayoutVisible,
                            child: Column(
                              children: [
                                //number picker layout
                                Container(
                                  height: Diamensions.height10*5,

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
                                    width: Diamensions.width310,
                                    height: Diamensions.height10*6,
                                    margin:  EdgeInsets.only(
                                      left: Diamensions.width10*2,
                                      right: Diamensions.width10*2,
                                      top: Diamensions.width10,
                                    ),
                                    child: TextFormField(
                                        style: const TextStyle(color: ColorConstants.whitecolr),
                                        keyboardType: TextInputType.name,
                                        controller: nameControler,
                                        decoration:  InputDecoration(
                                          labelText: "Enter Name",
                                          labelStyle:
                                          const TextStyle(color: ColorConstants.whitecolr),
                                          hintStyle:
                                          const  TextStyle(color: ColorConstants.whitecolr),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants.whitecolr,
                                                width: Diamensions.width1*2),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants.whitecolr,
                                                width: Diamensions.width1*2),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ColorConstants.whitecolr,
                                                  width: Diamensions.width1*2)),
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            color: ColorConstants.whitecolr,
                                          ),
                                        )
                                    )
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: Diamensions.width10*5,
                                  margin:  EdgeInsets.only(
                                      left: Diamensions.width10*2, right: Diamensions.width10*2, top: Diamensions.height10, bottom: Diamensions.height5),
                                  child: FloatingActionButton.extended(
                                    backgroundColor: ColorConstants.greencolor,
                                    onPressed: () {
                                      setState(() {
                                        _gmaillayoutVisible = false;
                                        _numberlayoutVisible = false;
                                        _otpverifylayoutVisible = true;
                                      });
                                      getotpfunction();
                                    },
                                    label:  Text(
                                      'Get Otp',
                                      style: TextStyle(color: Colors.white, fontSize: Diamensions.fontsize19),
                                    ),
                                  ),
                                ),
                              ],
                            )),

                        //otp and verify layout

                        Visibility(
                            visible: _otpverifylayoutVisible,
                            child: Column(
                              children: [
                                Container(
                                    margin:  EdgeInsets.only(
                                      left: Diamensions.width10*2,
                                      right: Diamensions.width10*2,
                                      top: Diamensions.height10,
                                    ),
                                    child: TextFormField(
                                        style: const TextStyle(color: ColorConstants.whitecolr),
                                        keyboardType: TextInputType.number,
                                        controller: otpControler,
                                        decoration: const InputDecoration(
                                          labelText: "Enter otp",
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
                                            Icons.perm_phone_msg,
                                            color: ColorConstants.whitecolr,
                                          ),
                                        )
                                    )
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: Diamensions.height10*5,
                                  margin: EdgeInsets.only(
                                      left: Diamensions.width10*2, right: Diamensions.width10*2, top: Diamensions.height10, bottom: Diamensions.height5),
                                  child: FloatingActionButton.extended(
                                    backgroundColor: ColorConstants.greencolor,
                                    onPressed: () {
                                      setState(() {
                                        _numberlayoutVisible = true;
                                        _otpverifylayoutVisible = false;
                                      });
                                      veriftywithanothernumber();
                                    },
                                    label:  Text(
                                      'Verify Otp ',
                                      style: TextStyle(color: Colors.white, fontSize: Diamensions.fontsize19),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),

                        //Anonymous Sign In

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: Diamensions.height10*5,
                          margin: EdgeInsets.only(
                              left: Diamensions.width10*2, right: Diamensions.width10*2, top: Diamensions.height10, bottom: Diamensions.height5),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side:  BorderSide(
                                  width: Diamensions.width1*2,
                                  color: ColorConstants.whitecolr,
                                ),
                                shape:  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(Diamensions.width10*2)))),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>  HomeScreen(loggedindata: loggedInUser,pageIndex: 0,iscomponentload: true,isLoggedIn: false,)));
                            },
                            child:  Text(
                              " Sign In As Guest",
                              style: TextStyle(fontSize: Diamensions.fontsize17),
                            ),
                          ),
                        ),

                        //

                        // (Platform.isIOS)? Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   height: 50,
                        //   margin: const EdgeInsets.only(
                        //       left: 20, right: 20, top: 10, bottom: 5),
                        //   child: OutlinedButton.icon(
                        //       style: OutlinedButton.styleFrom(
                        //           side: const BorderSide(
                        //             width: 2,
                        //             color: ColorConstants.whitecolr,
                        //           ),
                        //           shape: const RoundedRectangleBorder(
                        //               borderRadius:
                        //               BorderRadius.all(Radius.circular(20)))),
                        //       onPressed: () {
                        //         signinwithappple();
                        //       },
                        //       icon: SizedBox(
                        //           height: 30,
                        //           width: 30,
                        //           child: Image.asset('assets/images/apple.png')),
                        //       label: const Text("Sign with Apple")),
                        // ):Container(),


                        Container(
                          height: Diamensions.width10*3,
                          margin: EdgeInsets.only(left: Diamensions.width10*2),
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: () {
                                forgotpassworddialog(context);
                              },
                              child: const Text(
                                " forgot Password? Click here",
                                style: TextStyle(color: ColorConstants.whitecolr),
                              )
                          ),
                        ),

                        Container(
                          height: Diamensions.width10*3,
                          margin: EdgeInsets.only(right: Diamensions.width10*2),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const RegisterScreen()));
                              },
                              child: const Text(
                                " Not Register? Click here",
                                style: TextStyle(color: ColorConstants.whitecolr),
                              )
                          ),
                        ),
                        Container(
                          margin:  EdgeInsets.only(left: Diamensions.width10*2),
                          child: const Text(
                            "By Joining FlyDealFare you Agree to FlyDealFare",
                            style: TextStyle(color: ColorConstants.whitecolr),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: Diamensions.width10),
                              child: TextButton(
                                  onPressed: () {
                                    String url = "https://flydealfare.com/terms-and-conditions/";
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => OpenPravicyPolicyUrl(
                                          url:url,title: "Term & Condition",)));
                                  },
                                  child: const Text(
                                    "Term & Condition",
                                    style: TextStyle(
                                        color: ColorConstants.iconColror,
                                        decoration: TextDecoration.underline),
                                  )),
                            ),
                            const Text("and ",
                                style: TextStyle(color: ColorConstants.whitecolr)),
                            TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => const OpenPravicyPolicyUrl(url:"https://flydealfare.com/privacy-policy/",title: "Privacy Policy",)));
                                },
                                child: const Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                      color: ColorConstants.iconColror,
                                      decoration: TextDecoration.underline),
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
                backgroundColor: ColorConstants.iconColror,
              ),
            ),
          ),
        ],

      ),

    );
  }
  void getotpfunction() async {
    var numberText = numberControler.text.toString().trim();
     nameText = nameControler.text.toString().trim();
    if (numberText.isEmpty || numberText == " " || int.parse(numberText) == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("number text should not be empty"))
      );
    } else {

      setState(() {
        _gmaillayoutVisible = false;
        _numberlayoutVisible = false;
        _otpverifylayoutVisible = true;
      });

       finalnumber = "$countrycode$numberText";
      auth = FirebaseAuth.instance;

      await auth.verifyPhoneNumber(
        phoneNumber: finalnumber,
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
        verificationCompleted: (PhoneAuthCredential credential) async {
          smsmcod = credential.smsCode!;
          verfiyuser(smsmcod);
        },
        verificationFailed: (FirebaseAuthException error) {
          if (error.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },

        codeSent: (String verificationId, int? forceResendingToken) async {
          verificationID = verificationId;

          // Create a PhoneAuthCredential with the code

        },
      );
    }
  }

  void verfiyuser(String code) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: code);

    // Sign the user in (or link) with the credential
    var user =  await auth.signInWithCredential(credential);
    if(user != null){
      ScaffoldMessenger.of(context).showSnackBar(
          const  SnackBar(content:   Text("Logged in with number"))
      );


      UserApiService.getResgisterelinkList("Not Available", "Not Available",nameText , finalnumber, "Number").then((value) {

        if (value.data == "Registration Completed") {
          FirebaseFirestore.instance.collection("users").doc(user.user!.uid).set({
            "UserId": value.UserId
          }).then((values) =>
          {
            fetchlogindata(value.UserId!),

          });
        } else if(value.data == "User Alredy Exist") {
          String userid="";
          FirebaseFirestore.instance.collection("users").doc(user.user!.uid).get().then((vardata)  {
            userid  = vardata['UserId'];
            fetchlogindata(userid);
          });
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              const  SnackBar(content:   Text("Something went wrong"))
          );
        }
      });

    }
  }


  void veriftywithanothernumber(){
    var otptext = otpControler.text.toString().trim();
    if(otptext.isEmpty || otptext == " " || int.parse(otptext) == 0){
      ScaffoldMessenger.of(context).showSnackBar(
          const  SnackBar(content:   Text("opt text should not be empty"))
      );
    }else{
      verfiyuser(otptext);
    }

  }

  Future<void> forgotpassworddialog(BuildContext context) async {


    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children:   [
                Divider(
                  height: Diamensions.height1*2,
                  color: Colors.white,
                  thickness: 2,
                ),
                SizedBox(
                  height: Diamensions.height5,
                ),
                const Text("Forgot Password ?",
                style: TextStyle(
                  color: Colors.white
                ),
                ),
                SizedBox(
                  height: Diamensions.height5,
                ),
                Divider(
                  height: Diamensions.height1*2,
                  color: Colors.white,
                  thickness: 2,
                ),
              ],
            ),
            backgroundColor: ColorConstants.backgroundColor,
            content: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: Diamensions.width310-Diamensions.width10,
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: forgotemailController,
                          style:  TextStyle(color: ColorConstants.whitecolr),
                          decoration:  InputDecoration(
                              labelText: "Enter Email or Number",
                              labelStyle:
                              const TextStyle(color: ColorConstants.whitecolr),
                              hintStyle:
                             const TextStyle(color: ColorConstants.whitecolr),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstants.whitecolr,
                                    width: Diamensions.width1*2),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstants.whitecolr,
                                    width: Diamensions.width1*2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.whitecolr,
                                      width: Diamensions.width1*2)),
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: ColorConstants.whitecolr,
                              ))),
                    ),
                    SizedBox(
                      height: Diamensions.width10,
                    ),
                    Container(
                      width: Diamensions.width310 - Diamensions.width10,
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: forgotemailController,
                          style: const TextStyle(color: ColorConstants.whitecolr),
                          decoration: const InputDecoration(
                              labelText: "Enter New Password",
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
                    Container(
                      width: 300,
                      height: 50,
                      margin: const EdgeInsets.only(top: 10, bottom: 5),
                      child: FloatingActionButton.extended(
                        backgroundColor: ColorConstants.greencolor,
                        onPressed: () {
                          sendemail();
                        },
                        label: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }
  void sendemail(){
    var emailtext  = forgotemailController.text.toString();
    if(emailtext.isEmpty== true){
      ScaffoldMessenger.of(context).showSnackBar(
          const  SnackBar(content:   Text(" Please fill email"))
      );
    }else{
      auth.sendPasswordResetEmail(email: emailtext).then((value) => {
      ScaffoldMessenger.of(context).showSnackBar(
      const  SnackBar(content:   Text("Please Check your email "))
      )
      });
      //     .addOnCompleteListener( OnCompleteListener<Void>() {
      // @Override
      // public void onComplete(@NonNull Task<Void> task) {
      // if (task.isSuccessful()) {
      // Log.d(TAG, "Email sent.");
      // }
      // }
      // });
    }
  }

  //  facebookloginfunction() async{
  //
  // //   await FacebookAuth.i.logOut().then((value){
  // // print("logout");
  // //   });
  //   try{
  //
  //     FacebookAuth.instance.logOut();
  //     final result = await FacebookAuth.instance.login(permissions: ['email','public_profile']);
  //
  //
  //    //final result = await FacebookAuth.i.login(,loginBehavior: LoginBehavior.)
  //     if(result.status == LoginStatus.success){
  //       final userData = await FacebookAuth.i.getUserData();
  //       OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
  //
  //       // Sign the user in (or link) with the credential
  //       var user =  await auth.signInWithCredential(credential);
  //
  //
  //       //
  //       // print(userData["email"]);
  //       // print(userData["name"]);
  //       // // UserApiService.getResgisterelinkList(
  //       // //     userData['email'], "Not Available", userData['name'],
  //       // //     "Not Available", "Facebook").then((value) {
  //       // //   Navigator.of(context).push(
  //       // //       MaterialPageRoute(builder: (context) => HomeScreen(loggedindata: loggedInUser,pageIndex: 0,iscomponentload: true,)));
  //       // // });
  //
  //
  //
  //       if(user != null){
  //         ScaffoldMessenger.of(context).showSnackBar(
  //             const  SnackBar(content:   Text("Logged in with Facebook"))
  //         );
  //
  //
  //         UserApiService.getResgisterelinkList(user.user!.email!, "Not Available",user.user!.displayName! , "Not Available", "Facebook").then((value) {
  //
  //           if (value.data == "Registration Completed") {
  //             FirebaseFirestore.instance.collection("users").doc(user.user!.uid).set({
  //               "UserId": value.UserId
  //             }).then((values) =>
  //             {
  //               fetchlogindata(value.UserId!),
  //
  //             });
  //           } else if(value.data == "User Alredy Exist") {
  //             String userid="";
  //             FirebaseFirestore.instance.collection("users").doc(user.user!.uid).get().then((vardata)  {
  //               userid  = vardata['UserId'];
  //               fetchlogindata(userid);
  //             });
  //           }else{
  //             ScaffoldMessenger.of(context).showSnackBar(
  //                 const  SnackBar(content:   Text("Something went wrong"))
  //             );
  //           }
  //         });
  //
  //       }
  //     }
  //   }catch(error){
  //     print("error => ${error.toString()}");
  //   }
  //
  // }

  void checkloggedIn()  async{

   if(auth.currentUser != null){
     String userid="";
     FirebaseFirestore.instance.collection("users").doc(auth.currentUser!.uid).get().then((vardata)  {
       userid  = vardata['UserId'];
       fetchlogindata(userid);
     });

   }else{
     setState(() {
       loggedin = false;
     });
   }
  }

  // void signinwithappple() async{
  //   if(await TheAppleSignIn.isAvailable()){
  //     print("This Device is not eligible for Apple Sign In");
  //   }
  //
  //   final res = await TheAppleSignIn.performRequests([
  //     AppleIdRequest(requestedScopes: [Scope.email,Scope.fullName])
  //   ]);
  //
  //   switch(res.status){
  //     case AuthorizationStatus.authorized:
  //       try{
  //         final AppleIdCredential appleIdCredential = res.credential!;
  //         final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
  //         final credential = oAuthProvider.credential(
  //             idToken: String.fromCharCodes(appleIdCredential.identityToken!),
  //             accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!)
  //         );
  //         await signinwithCredential(credential);
  //       } on PlatformException catch(error){
  //         print("error => ${error.message}");
  //       } on FirebaseAuthException catch (error){
  //         print(error.message);
  //       }
  //       break;
  //     case AuthorizationStatus.error:
  //       print("Apple Authorization failed");
  //       break;
  //     case AuthorizationStatus.cancelled:
  //       print("User cancelled the login");
  //       break;
  //   }
  // }


  signinwithCredential(OAuthCredential credential) {

    auth.signInWithCredential(credential).then((value) {

      if(value != null){
        ScaffoldMessenger.of(context).showSnackBar(
            const  SnackBar(content:   Text("Logged in with Facebook"))
        );


        UserApiService.getResgisterelinkList(value.user!.email!, "Not Available",value.user!.displayName! , "Not Available", "Apple").then((restvalues) {

          if (restvalues.data == "Registration Completed") {
            FirebaseFirestore.instance.collection("users").doc(value.user!.uid).set({
              "UserId": restvalues.UserId
            }).then((values) =>
            {
              fetchlogindata(restvalues.UserId!),

            });
          } else if(restvalues.data == "User Alredy Exist") {
            String userid="";
            FirebaseFirestore.instance.collection("users").doc(value.user!.uid).get().then((vardata)  {
              userid  = vardata['UserId'];
              fetchlogindata(userid);
            });
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
                const  SnackBar(content:   Text("Something went wrong"))
            );
          }
        });

      }
      print("user id => ${value.user!.uid}");
      print("sing in with firebase");
    });
  }
}
