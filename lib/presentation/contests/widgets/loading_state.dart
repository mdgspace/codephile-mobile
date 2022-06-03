import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 8,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(25, 15, 15, 0),
              child: CircleAvatar(
                backgroundColor: Color(0xFFE5E5E5),
                radius: 18,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                  width: 150.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: const Color(0xFFE5E5E5),
                  ),
                  height: 14,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  width: 250.r,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: const Color(0xFFE5E5E5),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  width: 250.r,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: const Color(0xFFE5E5E5),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
