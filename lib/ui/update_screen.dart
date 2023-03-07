
import 'package:flutter/material.dart';
import 'package:fly_deal_fare/models/Data.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';

import '../colors_class/colors_class.dart';

class UpdateScreen extends StatefulWidget {
  Data? loggedInUser;
   UpdateScreen({Key? key,this.loggedInUser}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  bool circularvisibility = false;
  var emailContrller = TextEditingController();
  var numberController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    emailContrller.dispose();
    numberController.dispose();
    nameController.dispose();
    addressController.dispose();
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
          'UpdateScreen',
          style: TextStyle(color: ColorConstants.iconColror),
        ),
      ),
      body:Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          margin: EdgeInsets.only(left: 15,right: 15),
          width: MediaQuery.of(context).size.width,
          color: ColorConstants.backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                height: 2,
                color: Colors.white,
                thickness: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Text("Update Information ?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22
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
              SizedBox(
                height: 15,
              ),
              Container(
                width: 300,
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    style: const TextStyle(color: ColorConstants.whitecolr),
                    decoration:  InputDecoration(
                        labelText: "${widget.loggedInUser!.name}",
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
                height: 10,
              ),
              Container(
                width: 300,
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailContrller,
                    style: const TextStyle(color: ColorConstants.whitecolr),
                    decoration:  InputDecoration(
                        labelText: " ${widget.loggedInUser!.email}",
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
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: numberController,
                    style: const TextStyle(color: ColorConstants.whitecolr),
                    decoration:  InputDecoration(
                        labelText: " ${widget.loggedInUser!.mobile}",
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
                height: 10,
              ),
              Container(
                width: 300,
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: addressController,
                    style: const TextStyle(color: ColorConstants.whitecolr),
                    decoration:  InputDecoration(
                        labelText: " ${widget.loggedInUser!.address}",
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
                    setState(() {
                      circularvisibility = true;
                    });
                       updatedata(widget.loggedInUser!.id!,widget.loggedInUser!.email!,widget.loggedInUser!.name!,widget.loggedInUser!.mobile!,widget.loggedInUser!.address!);
                  },
                  label: const Text(
                    'Update Data',
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ),
              ),
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

  void updatedata(String id,String emailp,String namep,String numberp,String addressp){
       var emailText = emailContrller.text.toString();
       var nameText = nameController.text.toString();
       var numberText = numberController.text.toString();
       var addressText = addressController.text.toString();

       if(emailText == ""){
         emailText = emailp;
       }
       if(nameText == ""){
         nameText =namep;
       }
       if(numberText == ""){
         numberText = numberp;
       }
       if(addressText == ""){
         addressText = addressp;
       }
         UserApiService.userupdatedata(id, emailText, addressText, nameText, numberText).then((value) => {

         ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content:   Text(" ${value.result}"))
         ),
           setState(() {
             circularvisibility = false;
           }),

         });



  }
}
