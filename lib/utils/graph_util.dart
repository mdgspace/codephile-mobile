import 'dart:ui';

class GraphUtil {
  static Color? getChartColor(String key) {
    switch (key) {
      case 'ac':
        return const Color(0xFF079D0D);

      case 'ptl':
        return const Color(0xFFA6E063);

      case 'wa':
        return const Color(0xFFF44336);

      case 'tle':
        return const Color(0xFF3F51B5);

      case 're':
        return const Color(0xFF9C27B0);

      case 'ce':
        return const Color(0xFFFF9800);
    }
    return null;
  }
}
