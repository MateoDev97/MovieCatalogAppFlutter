import 'package:flutter/material.dart';
import 'package:movies_app/views/views.dart';

class AppRoutes {
  static const initialRoute = 'homeView';

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll(
        {'homeView': (BuildContext context) => const HomeView()});
    appRoutes.addAll(
        {'detailView': (BuildContext context) => const DetailView()});
    
    return appRoutes;
  }
}
