import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'flavor_config.dart';
import 'main.dart';
import 'package:http_proxy/http_proxy.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
    statusBarBrightness: Brightness.light,
  ));

  HttpProxy httpProxy = await HttpProxy.createHttpProxy();
  HttpOverrides.global = httpProxy;
  FlavorConfig(
      flavor: Flavor.DEV,
      values: FlavorValues(
        baseUrl: '',
      ));
  runZonedGuarded(() {
    runApp(const MyApp());
  }, (Object error, StackTrace stack) {});
}
