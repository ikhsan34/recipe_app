import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InstructionScreen extends StatelessWidget {
  final String sourceUrl;
  const InstructionScreen({super.key, required this.sourceUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructions'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(sourceUrl)),
      )
    );
  }
}