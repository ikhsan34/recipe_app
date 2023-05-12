import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InstructionScreen extends StatefulWidget {
  final String sourceUrl;
  const InstructionScreen({super.key, required this.sourceUrl});

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {

  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructions'),
      ),
      body: Stack(
        children: [
          progress < 1.0 ? LinearProgressIndicator(value: progress) : const SizedBox(),
          InAppWebView(
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                transparentBackground: true
              )
            ),
            onProgressChanged: (controller, progress) {
              setState(() {
                this.progress = progress / 100;
              });
            },
            initialUrlRequest: URLRequest(url: Uri.parse(widget.sourceUrl)),
          ),
        ]
      )
    );
  }
}