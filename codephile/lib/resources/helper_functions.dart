import 'package:codephile/models/submission.dart';

String submissionType(Submission submission) {
  String url = submission.url;
  if(url.contains("codechef")){
    return "Codechef";
  }else if(url.contains("codeforces")){
    return "Codeforces";
  }else if(url.contains("hackerrank")){
    return "Hackerrank";
  }else{
    return "Spoj";
  }
}
