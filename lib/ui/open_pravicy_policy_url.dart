

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OpenPravicyPolicyUrl extends StatefulWidget {

  final String? url;
  final String? title;

  const OpenPravicyPolicyUrl({Key? key,this.url,this.title}) : super(key: key);

  @override
  State<OpenPravicyPolicyUrl> createState() => _OpenPravicyPolicyUrlState();
}

class _OpenPravicyPolicyUrlState extends State<OpenPravicyPolicyUrl> {
  late WebViewController _controller;
  final Completer<WebViewController> _controllerCompleter =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        title:  Text(
          widget.title!,
          style: TextStyle(color: ColorConstants.iconColror),
        ),
      ),
      body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.url,
          onWebViewCreated: (WebViewController webViewController) {
            _controllerCompleter.future.then((value) => _controller = value);
            _controllerCompleter.complete(webViewController);
          },
        onPageFinished: (value){
          _loadHtmlFromAssets();
        },
          ),
    );
  }

  _loadHtmlFromAssets() async {


    _controller.evaluateJavascript("document.getElementById('gb-widget-1070')[0].style.display='none'");
    //hide blog
    _controller.evaluateJavascript("document.getElementsByClassName('mob-header')[0].style.visibility='collapse'");
   // _controller.evaluateJavascript("document.getElementsByClassName('widget widget_recent_entries opportunity')[0].style.display='none'");
    //hide footer
   // _controller.evaluateJavascript("(document).ready(function(){ setTimeout(function(){ var modal = document.getElementById('myModal');modal.style.display = 'none';},1000);});");
    _controller.evaluateJavascript("document.getElementsByTagName('footer')[0].style.display='none'");
  }
}
