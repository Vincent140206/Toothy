import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MidtransWebView extends StatefulWidget {
  final String redirectUrl;

  const MidtransWebView({Key? key, required this.redirectUrl}) : super(key: key);

  @override
  State<MidtransWebView> createState() => _MidtransWebViewState();
}

class _MidtransWebViewState extends State<MidtransWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            if (url.contains("success")) {
              Navigator.pop(context, "success");
            } else if (url.contains("pending")) {
              Navigator.pop(context, "pending");
            } else if (url.contains("failed")) {
              Navigator.pop(context, "failed");
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.redirectUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
