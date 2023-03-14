

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
class ChatScreen extends StatefulWidget {
  final String? chaturl;
  const ChatScreen({Key? key,this.chaturl}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
      ..loadRequest(Uri.parse(widget.chaturl!));

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
        toolbarHeight: 0,
      ),
      body: WebViewWidget(
        controller: _controller,
          ),
    );
  }
}
