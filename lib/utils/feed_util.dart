import 'package:flutter/material.dart';

import '../data/constants/colors.dart';

class FeedUtil {
  static Map<String, dynamic> getSubmissionStatus(String status) {
    final map = <String, dynamic>{};
    switch (status) {
      case 'AC':
        map['color'] = AppColors.acceptedGreen;
        map['status'] = 'Accepted';
        break;
      case 'WA':
        map['color'] = AppColors.errorRed;
        map['status'] = 'Wrong Answer';
        break;
      case 'CE':
        map['color'] = AppColors.errorRed;
        map['status'] = 'Compilation Error';
        break;
      case 'RE':
        map['color'] = AppColors.errorRed;
        map['status'] = 'Runtime Error';
        break;
      case 'TLE':
        map['color'] = Colors.orange;
        map['status'] = 'Time Limit Exceeded';
        break;
      case 'MLE':
        map['color'] = Colors.orange;
        map['status'] = 'Memory Limit Exceeded';
        break;
      case 'PTL':
        map['color'] = Colors.lightGreen;
        map['status'] = 'Parital Answer';
        break;
      default:
        map['color'] = AppColors.errorRed;
        map['status'] = 'Other';
    }
    return map;
  }
}
