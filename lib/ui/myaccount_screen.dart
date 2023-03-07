import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/Data.dart';
import 'package:fly_deal_fare/ui/update_screen.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';

class MyAccount extends StatefulWidget {
  Data? loggedInuser;

  MyAccount({Key? key, this.loggedInuser}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConstants.backgroundColor,
        child: Center(
          child: Text("My Account Screen will Update soon",
          style: TextStyle(
            color: Colors.white
          ),
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //
      //     children: [
      //       Container(
      //         margin: EdgeInsets.only(top: 20),
      //         alignment: Alignment.topCenter,
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //
      //         ),
      //         child: SizedBox(
      //             height: 130,
      //             width: 130,
      //             child: Image.asset("assets/images/user.png")),
      //       ),
      //       Container(
      //           margin: EdgeInsets.only(top: 5),
      //           alignment: Alignment.topCenter,
      //           child: Text(
      //             "Hi !${widget.loggedInuser!.name}", style: TextStyle(
      //               color: ColorConstants.iconColror,
      //               fontSize: 23
      //           ),
      //           )
      //       ),
      //
      //       Row(
      //         children: [
      //           Container(
      //               margin: const EdgeInsets.only(top: 10, left: 10),
      //               child: const Text("Number:- ",
      //                 style: TextStyle(
      //                     color: ColorConstants.iconColror
      //                 ),
      //               )
      //           ),
      //
      //           Container(
      //               margin: const EdgeInsets.only(top: 10, left: 10),
      //               child: Text("${widget.loggedInuser!.mobile}",
      //                 style: TextStyle(
      //                     color: ColorConstants.iconColror,
      //                     fontSize: 23
      //                 ),
      //               )
      //           ),
      //         ],
      //       ),
      //       Row(
      //         children: [
      //           Container(
      //               margin: const EdgeInsets.only(top: 10, left: 10),
      //               child: const Text("Email:- ",
      //                 style: TextStyle(
      //                     color: ColorConstants.iconColror
      //                 ),
      //               )
      //           ),
      //
      //           Container(
      //               margin: const EdgeInsets.only(top: 10, left: 10),
      //               child: Text("${widget.loggedInuser!.email}",
      //                 style: TextStyle(
      //                     color: ColorConstants.iconColror,
      //                     fontSize: 23
      //                 ),
      //               )
      //           ),
      //         ],
      //       ),
      //       Row(
      //         children: [
      //           Container(
      //               margin: const EdgeInsets.only(top: 10, left: 10),
      //               child: const Text("Address:- ",
      //                 style: TextStyle(
      //                     color: ColorConstants.iconColror
      //                 ),
      //               )
      //           ),
      //
      //           Container(
      //               margin: const EdgeInsets.only(top: 10, left: 10),
      //               child: Text("${widget.loggedInuser!.address}",
      //                 style: TextStyle(
      //                     color: ColorConstants.iconColror,
      //                     fontSize: 23
      //                 ),
      //               )
      //           ),
      //         ],
      //       ),
      //
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton.extended(onPressed: () {
      //   forgotpassworddialog(context);
      // },
      //   icon: Icon(Icons.edit),
      //   label: Text("Edit"),
      // ),
    );
  }

  Future<void> forgotpassworddialog(BuildContext context) async {
    var emailcontrollere = TextEditingController();
    var passwordcontroller = TextEditingController();

    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: const [
                Divider(
                  height: 2,
                  color: Colors.white,
                  thickness: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Verify YourSelf?",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  height: 2,
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
                      width: 300,
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailcontrollere,
                          style: const TextStyle(
                              color: ColorConstants.whitecolr),
                          decoration: const InputDecoration(
                              labelText: "Enter UserName",
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
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 300,
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: passwordcontroller,
                          style: const TextStyle(
                              color: ColorConstants.whitecolr),
                          decoration: const InputDecoration(
                              labelText: "Enter Password",
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
                                Icons.lock_clock,
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
                          var emailext = emailcontrollere.text.toString();
                          var passwordtext = passwordcontroller.text.toString();
                          UserApiService.getLoggedInList(emailext, passwordtext,context).then((value) {

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
                                  MaterialPageRoute(builder: (context) => UpdateScreen(loggedInUser: obj,))
                              );

                            }
                          });
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen(loggedInUser: widget.loggedInuser!,)));
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
}
