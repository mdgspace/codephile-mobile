// ignore_for_file: unnecessary_string_escapes

import '../data/constants/assets.dart';

class ContestUtil {
  static String getPlatformIcon(String platformName) {
    switch (platformName.toLowerCase()) {
      case 'codechef':
        return AppAssets.codechef;
      case 'codeforces':
        return AppAssets.codeforces;
      case 'hackerearth':
        return AppAssets.hackerEarth;
      case 'hackerrank':
        return AppAssets.hackerRank;
      default:
        return AppAssets.otherPlatform;
    }
  }

  static String getPlatformName(String platformName) {
    switch (platformName.toLowerCase()) {
      case 'codechef':
        return 'CodeChef';
      case 'codeforces':
        return 'CodeForces';
      case 'hackerearth':
        return 'HackerEarth';
      case 'hackerrank':
        return 'HackerRank';
      default:
        return 'Other';
    }
  }

  static String getLabel(int? value) {
    switch (value) {
      case 0:
        return '2 hours';
      case 1:
        return '3 hours';
      case 2:
        return '5 hours';
      case 3:
        return '1 day';
      case 4:
        return '10 days';
      case 5:
        return '1 month';
      case 6:
        return '∞';
      default:
        return '10 days';
    }
  }

  static String getPlatformNamefromUrl(String? url) {
    if (url == null) return '';

    final regExp =
        RegExp('^(?:https?:\/\/)?(?:[^@\/\n]+@)?(?:www\.)?([^:\/?\n]+)');

    final match = regExp.firstMatch(url);

    return match?[1]?.split('.').first ?? '';
  }
}
