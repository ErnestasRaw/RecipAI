import 'dart:io';

import 'package:flutter/material.dart';
import 'package:receptai/main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // bool enabled = true;
  // String? host = "192.168.1.117";
  // int? port = 8888;
  // try {
  //   ProxySetting settings = await NativeProxyReader.proxySetting;
  //   enabled = settings.enabled;
  //   host = settings.host;
  //   port = settings.port;
  // } catch (e) {
  //   xlog("", error: e);
  // }
  // if (enabled && host != null) {
  //   final proxy = CustomProxy(ipAddress: host, port: port);
  //   proxy.enable();
  //   xlog("proxy enabled");
  // }
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MainApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
