import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
class ResultScreen extends StatefulWidget {
  final String? url;
  const ResultScreen({Key? key, this.url}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late final WebViewController _controller;
 


  @override
  void initState() {
    super.initState();

  Future.delayed(Duration(seconds: 15), (){
      _controller.runJavaScript("document.getElementsByClassName('click-to-call')[0].style.display='none'");
      // print("this is printing after 10 seconds");
    });
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageFinished: (String url) {


            //hide blog
            //hide whatsup
            _controller.runJavaScript("document.getElementsByClassName('q8c6tt-2 dJvETY')[0].style.visibility='collapse'");
            //hide header
            _controller.runJavaScript("document.getElementsByClassName('mob-header')[0].style.visibility='collapse'");
            // _controller.evaluateJavascript("document.getElementsByClassName('widget widget_recent_entries opportunity')[0].style.display='none'");
            //hide footer
            // _controller.evaluateJavascript("(document).ready(function(){ setTimeout(function(){ var modal = document.getElementById('myModal');modal.style.display = 'none';},1000);});");

            //hide footer
            _controller.runJavaScript("document.getElementsByTagName('footer')[0].style.display='none'");



            // Future.delayed(Duration(seconds: 3),(){
            // _controller.runJavaScript("document.getElementsByClassName('meshim_widget_components_mobileChatButton_TappingScreen')[0].style.display='none'");
            // });

          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url!));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
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
      body: WebViewWidget(
         controller: _controller,
          ),
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
