import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key, required this.url});
  final String url;

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  late final WebViewController controller;
  @override
  void initState() {
    //log('url: ${widget.url}');
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.endsWith('success')) {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: const Text('Payment Success'),
                  content: const Text('Your payment was successful'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    )
                  ],
                );
              });
              // dialog
              return NavigationDecision.prevent;
            }
            else if (request.url.endsWith('Failed')) {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: const Text('Payment Cancelled'),
                  content: const Text('Your payment was cancelled'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    )
                  ],
                );
              });
              // dialog
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));


  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: WebViewWidget(
                  controller: controller,

                ),
              ),

            ],
          ),
          )
        )
    );
  }
}
