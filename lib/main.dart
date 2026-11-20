import 'package:breeze/app/app.dart';
import 'package:breeze/app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  setupLocator();
  runApp(const BreezeApp());
}
