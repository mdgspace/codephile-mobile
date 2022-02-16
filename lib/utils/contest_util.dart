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
}
