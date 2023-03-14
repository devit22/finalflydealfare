import 'dart:async';

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class OpenPravicyPolicyUrl extends StatefulWidget {

  final String? url;
  final String? title;

  const OpenPravicyPolicyUrl({Key? key,this.url,this.title}) : super(key: key);

  @override
  State<OpenPravicyPolicyUrl> createState() => _OpenPravicyPolicyUrlState();
}

class _OpenPravicyPolicyUrlState extends State<OpenPravicyPolicyUrl> {
  late final WebViewController _controller;


  @override
  void initState() {
    super.initState();

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
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
        title:  Text(
          widget.title!,
          style: TextStyle(color: Colors.blue),
        ),
        actions: [
          NavigationControls(webViewController: _controller )
        ],
      ),


      body: WebViewWidget(controller: _controller),
    );
  }

//   _loadHtmlFromAssets() async {


//     _controller.evaluateJavascript("document.getElementById('gb-widget-1070')[0].style.display='none'");
//     //hide blog
//     _controller.evaluateJavascript("document.getElementsByClassName('mob-header')[0].style.visibility='collapse'");
//    // _controller.evaluateJavascript("document.getElementsByClassName('widget widget_recent_entries opportunity')[0].style.display='none'");
//     //hide footer
//    // _controller.evaluateJavascript("(document).ready(function(){ setTimeout(function(){ var modal = document.getElementById('myModal');modal.style.display = 'none';},1000);});");
//     _controller.evaluateJavascript("document.getElementsByTagName('footer')[0].style.display='none'");
//   }
}

class NavigationControls extends StatelessWidget {

  final WebViewController webViewController;
  const  NavigationControls ({super.key,required this.webViewController});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        onPressed: () async{
          if(await webViewController.canGoBack()){
            await webViewController.goBack();
          }else{
            if(context.mounted){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No Back history found ')),
              );
            }
          }
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      IconButton(
        onPressed: () async{
          if(await webViewController.canGoForward()){
            await webViewController.goForward();
          }else{
            if(context.mounted){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No Forward History found')),
              );
            }
          }
        },
        icon: const Icon(Icons.arrow_forward_ios),
      ),
      IconButton(
        onPressed: () async{
          webViewController.reload();
        },
        icon: const Icon(Icons.replay),

      ),
    ],
    );
  }
}