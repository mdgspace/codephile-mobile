import 'dart:developer';

import 'package:flutter/material.dart';

class AppNavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('[NAV] [PUSH] { from ${previousRoute?.settings.name} to ${route.settings.name} }');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    log('[NAV] [REPLACE] { from ${oldRoute?.settings.name} to ${newRoute?.settings.name} }');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    log('[NAV] [REMOVE] { from ${route.settings.name} to ${previousRoute?.settings.name} }');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    log('[NAV] [POP] { from ${route.settings.name} to ${previousRoute?.settings.name} }');
  }
}
