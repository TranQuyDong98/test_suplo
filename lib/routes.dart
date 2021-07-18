import 'package:flutter/material.dart';
import 'package:test_suplo/ui/screens.dart';

class Routes {
  Routes._();
  static const String userScreen = "/user_screen";
  static const String postScreen = '/post_screen';
  static const String postDetailScreen = '/post_detail_screen';

  static String initScreen() => userScreen;

  static final routes = <String, WidgetBuilder>{
    userScreen: (context) => UserScreen(),
  };
}