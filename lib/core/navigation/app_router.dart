import 'package:flutter/material.dart';
import 'package:movie_app/views/shell/main_shell.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.shell:
        return MaterialPageRoute(builder: (_) => const MainShell());

      default:
        return MaterialPageRoute(builder: (_) => const MainShell());
    }
  }
}
