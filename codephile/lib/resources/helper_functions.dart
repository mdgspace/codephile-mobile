import 'dart:io';

import 'package:codephile/models/submission.dart';
import 'package:fluttertoast/fluttertoast.dart';

String submissionType(Submission submission) {
  String url = submission.url;
  if (url.contains("codechef")) {
    return "Codechef";
  } else if (url.contains("codeforces")) {
    return "Codeforces";
  } else if (url.contains("hackerrank")) {
    return "Hackerrank";
  } else {
    return "Spoj";
  }
}

Future showConnectivityStatus() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
    }
  } on SocketException catch (_) {
    print('not connected');
    Fluttertoast.showToast(
      msg: "Please check your connection!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 7,
      fontSize: 12.0,
    );
  }
}

String getPlatformIconAssetPath(String platform) {
  platform = platform.toLowerCase();
  switch (platform) {
    case "codechef":
      return "assets/platformIcons/codeChefIcon.png";
      break;
    case "codeforces":
      return "assets/platformIcons/codeForcesIcon.png";
      break;
    case "hackerrank":
      return "assets/platformIcons/hackerRankIcon.png";
      break;
    case "hackerearth":
      return "assets/platformIcons/hackerEarthIcon.png";
      break;
    case "spoj":
      return "assets/platformIcons/spoj.png";
      break;
    default:
      return "assets/platformIcons/otherIcon.jpg";
      break;
  }
}

String getPlatformName(String platform) {
  platform = platform.toLowerCase();
  switch (platform) {
    case "codechef":
      return "CodeChef";
      break;
    case "codeforces":
      return "CodeForces";
      break;
    case "hackerrank":
      return "HackerRank";
      break;
    case "hackerearth":
      return "HackerEarth";
      break;
    case "spoj":
      return "Spoj";
      break;
  }
  return null;
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIos: 7,
    fontSize: 12.0,
  );
}
