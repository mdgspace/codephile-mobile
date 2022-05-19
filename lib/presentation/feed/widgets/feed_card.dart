import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:intl/intl.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/colors.dart';
import '../../../domain/models/grouped_feed.dart';
import '../../../utils/feed_util.dart';
import '../../../utils/platform_util.dart';

class FeedCard extends StatelessWidget {
  FeedCard({
    required this.feed,
    Key? key,
  }) : super(key: key);

  final GroupedFeed feed;
  final ValueNotifier<bool> _dropdownNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // TODO(aman-singh7): Integrate to profile
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: feed.picture?.isEmpty ?? true
                    ? Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.grey7,
                          ),
                        ),
                        child: SizedBox(
                          height: 32.r,
                          width: 32.r,
                          child: SvgPicture.asset(
                            AppAssets.userIcon,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 16.r,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(feed.picture!),
                      ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${feed.fullname!.trim()} solved',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy kk:mm').format(
                          feed.submissions![0].createdAt!,
                        ),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Text(
                      '${feed.name}',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(fontSize: 16.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'on ',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontSize: 12.sp),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                          PlatformUtil.getIcon(
                            PlatformUtil.getNamefromUrl(
                              feed.url,
                            ),
                          ),
                        ),
                        radius: 10.r,
                      ),
                      SizedBox(
                        width: 150.w,
                        child: Text(
                          _makeNonBreaking(
                            ' ${PlatformUtil.getName(PlatformUtil.getNamefromUrl(feed.url))} |'
                            ' ${feed.language}',
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 12.sp),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      ValueListenableBuilder<bool>(
                        valueListenable: _dropdownNotifier,
                        builder: (context, value, _) {
                          return Icon(
                            value
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: AppColors.primary,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onExpansionChanged: (value) => _dropdownNotifier.value = value,
      trailing: const SizedBox(),
      children: [
        Container(
          color: AppColors.grey9,
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
          child: Column(
            children: _buildSubmissions(feed.submissions!),
          ),
        )
      ],
    );
  }

  List<Widget> _buildSubmissions(List<Submissions> submissions) {
    return List.from(
      submissions.map(
        (submission) {
          final response =
              FeedUtil.getSubmissionStatus(submission.status ?? '');
          final isFirst =
              submissions.first.createdAt!.compareTo(submission.createdAt!) ==
                  0;
          final isLast =
              submissions.last.createdAt!.compareTo(submission.createdAt!) == 0;
          return GestureDetector(
            onTap: () {
              FlutterWebBrowser.openWebPage(
                url: feed.url!,
                customTabsOptions: const CustomTabsOptions(
                  defaultColorSchemeParams: CustomTabsColorSchemeParams(
                    toolbarColor: AppColors.primary,
                  ),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(width: 40.r),
                Column(
                  children: <Widget>[
                    Container(
                      height: 9.h,
                      width: 2.w,
                      color: isFirst ? AppColors.white : AppColors.grey10,
                    ),
                    Container(
                      height: 8.h,
                      width: 8.w,
                      decoration: BoxDecoration(
                        color: response['color'],
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      height: 9.h,
                      width: 2.w,
                      color: isLast ? AppColors.white : AppColors.grey10,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                  child: Text(
                    response['status'],
                    style: TextStyle(
                      color: response['color'],
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat('dd-MM-yyyy kk-ss').format(submission.createdAt!),
                  style: const TextStyle(
                    color: AppColors.grey6,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Replaces all empty areas in the text with non-breaking spaces.
  ///
  /// This is to ensure that each (non-empty) character of the string is treated
  /// as a different word. And THAT is needed because Flutter doesn't care about
  /// the `softWrap` parameter if [TextOverflow.ellipsis] is supplied to the
  /// `overflow` parameter.
  String _makeNonBreaking(String str) {
    return str.replaceAll('', '\u{200B}');
  }
}
