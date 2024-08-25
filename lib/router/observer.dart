import 'package:flutter/material.dart';

class GoRouteObserver extends RouteObserver {
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Route pushed: ${route.settings.name}');
  }

  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Route popped: ${route.settings.name}');
  }

  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    print('Route replaced: ${newRoute?.settings.name}');
  }
}
