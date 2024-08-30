import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';

class OutsourcingRoutesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outsource'),
      ),
      body: WebviewScaffold(
        url: 'https://yandex.ru/map-widget/v1/?um=constructor%3AYOUR_CONSTRUCTOR_ID&source=constructor',
        withJavascript: true,
        withZoom: true,
      ),
    );
  }
}
