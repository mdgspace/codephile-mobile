import 'package:codephile/models/grouped_feed.dart';
import 'package:codephile/resources/colors.dart';
import 'package:codephile/resources/strings.dart';
import 'package:codephile/screens/feed/feed_card.dart';
import 'package:codephile/services/feed.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sentry/sentry.dart';

class FeedScreen extends StatefulWidget {
  final String? token;

  const FeedScreen({this.token, Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final SentryClient sentry = SentryClient(SentryOptions(dsn: dsn));
  List<GroupedFeed>? feed;
  bool _empty = false;
  bool _loading = false;
  bool _allLoaded = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _refreshFeed(isUserPrompted: true);
    _scrollController.addListener(_controlScrolling);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: SvgPicture.asset("assets/refresh.svg"),
              onPressed: () {
                setState(() {
                  _loading = true;
                  _empty = false;
                });
                _refreshFeed(isUserPrompted: true);
              })
        ],
        title: const Text(
          "Feed",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (_empty) {
            return Column(
              children: <Widget>[
                const Spacer(flex: 3),
                SvgPicture.asset("assets/emptyFeed.svg"),
                const Padding(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    "Feed looks empty, search and follow some people to see their updates",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF979797)),
                  ),
                ),
                const Spacer(flex: 2)
              ],
            );
          } else if (feed == null) {
            double width = MediaQuery.of(context).size.width;
            return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                            padding: EdgeInsets.fromLTRB(25, 15, 15, 0),
                            child: CircleAvatar(
                                backgroundColor: Color(0xFFE5E5E5),
                                radius: 18)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                                width: width * 2 / 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: const Color(0xFFE5E5E5)),
                                height: 14),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              width: width * 3 / 4,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: const Color(0xFFE5E5E5)),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                              width: width * 3 / 4,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: const Color(0xFFE5E5E5)),
                            )
                          ],
                        )
                      ]);
                });
          } else {
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                ListView.builder(
                  controller: _scrollController,
                  itemCount: feed!.length,
                  itemBuilder: (context, index) {
                    return FeedCard(
                      feed: feed![index],
                      token: widget.token,
                    );
                  },
                ),
                if (_loading && !_allLoaded)
                  const Positioned(
                    bottom: 0,
                    child: SizedBox(
                      height: 80,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: codephileMain,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }

  void _refreshFeed({required bool isUserPrompted}) async {
    setState(() => _loading = true);
    try {
      GroupedFeed? lastSubmission = feed?.last;
      final response = await getFeed(
        widget.token!,
        context,
        before:
            isUserPrompted ? null : lastSubmission?.submissions?.last.createdAt,
      );
      List<GroupedFeed> nextPage = <GroupedFeed>[];
      if (response == null) {
        setState(() {
          _loading = false;
          _empty = true;
        });
      } else {
        for (final feedElement in response) {
          GroupedFeed e = nextPage.firstWhere(
            (grpFeedElement) {
              return grpFeedElement.name == feedElement.submission!.name;
            },
            orElse: () {
              nextPage.add(
                GroupedFeed(
                  fullname: feedElement.fullname,
                  name: feedElement.submission!.name,
                  picture: feedElement.picture,
                  url: feedElement.submission!.url,
                  userId: feedElement.userId,
                  username: feedElement.username,
                  language: feedElement.submission!.language,
                  submissions: [],
                ),
              );
              return nextPage.last;
            },
          );
          e.submissions!.add(Submissions(
              createdAt: feedElement.submission!.createdAt,
              points: feedElement.submission!.points,
              rating: feedElement.submission!.rating,
              status: feedElement.submission!.status,
              tags: feedElement.submission!.tags));
        }
        if (nextPage.isEmpty) _allLoaded = true;
        feed ??= [];
        if (isUserPrompted && _scrollController.hasClients) {
          feed = nextPage;
          _scrollController.animateTo(
            _scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 2000),
            curve: Curves.fastOutSlowIn,
          );
        } else {
          feed!.addAll(nextPage);
        }
        setState(() => _loading = false);
      }
    } catch (error, stackTrace) {
      if (foundation.kReleaseMode) {
        await sentry.captureException(
          error,
          stackTrace: stackTrace,
        );
      } else {
        rethrow;
      }
    }
  }

  void _controlScrolling() {
    final hasReachedEnd = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels <=
        MediaQuery.of(context).size.width / 2;

    if (hasReachedEnd && !_loading && !_allLoaded) {
      _refreshFeed(isUserPrompted: false);
    }
  }
}
