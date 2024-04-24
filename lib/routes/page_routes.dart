import 'package:flutter/material.dart';
import 'package:the_fire/presentation/auth/splash/splash_screen.dart';
import 'package:the_fire/routes/page_names.dart';

class PageRoutes {
  static final Map<String, WidgetBuilder> routes = {
    PageNames.splashScreen: (_) => const SplashScreen(),
  };
}
