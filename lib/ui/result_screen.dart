import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ResultScreen extends StatefulWidget {
  final String? url;
  const ResultScreen({Key? key, this.url}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late WebViewController _controller;
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  @override
  void initState() {
    // if (Platform.isAndroid) {
    //   WebView.platform = SurfaceAndroidWebView();
    // }
    super.initState();
    Future.delayed(Duration(seconds: 15), (){
      _controller.evaluateJavascript("document.getElementsByClassName('click-to-call')[0].style.display='none'");
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
          'Result Screen',
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
          initialUrl: widget.url,
          onWebViewCreated: (WebViewController webViewController) {
            _controllerCompleter.future.then((value) => _controller = value);
            _controllerCompleter.complete(webViewController);
          }),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Do you want to Starting Screen'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: ColorConstants.iconColror,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text('Yes',
                        style: TextStyle(
                          color: ColorConstants.iconColror,
                        )),
                  ),
                ],
              ));
      return Future.value(true);
    }
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
}
