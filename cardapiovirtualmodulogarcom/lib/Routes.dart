import 'package:cardapiovirtualmodulogarcom/Apresentacao/HomeGarcom.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    '/home': (_) =>  HomeGarcom(),
  };

  static String initial = '/home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}