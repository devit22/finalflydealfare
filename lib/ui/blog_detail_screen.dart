
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogDetailPage extends StatefulWidget {
  final String? blogUrl;
 const   BlogDetailPage({Key? key,this.blogUrl}) : super(key: key);

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {

  late WebViewController _controller;
  final Completer<WebViewController> _controllerCompleter =
  Completer<WebViewController>();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds:3), (){
      _controller.evaluateJavascript("document.getElementsByTagName('header')[0].style.display='none'");
      // print("this is printing after 10 seconds");
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
            'Blog Detail',
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
      body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.blogUrl,
          onWebViewCreated: (WebViewController webViewController) {
            _controllerCompleter.future.then((value) => _controller = value);
            _controllerCompleter.complete(webViewController);
          },
        onPageFinished: (value){

            _controller.evaluateJavascript("document.getElementsByTagName('header')[0].style.display='none'");


        },

          ),

    );
  }

  void _showPopupMenu(Offset offset) async{

    await showMenu(context: context,
      constraints: const BoxConstraints(
          maxWidth: 135,
          maxHeight: 200
      ),
      position: const RelativeRect.fromLTRB(100, 80, 5, 0),
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
                      child: const Text("Canada"))
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
                      child: const  Text("India")
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
                      child: const Text("USA")
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
