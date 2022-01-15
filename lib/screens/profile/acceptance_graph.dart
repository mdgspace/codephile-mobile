import 'package:codephile/models/activity_details.dart';
import 'package:codephile/resources/strings.dart';
import 'package:date_utils/date_utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';
import 'package:flutter/foundation.dart' as foundation;

class AcceptanceGraph extends StatefulWidget {
  final List<ActivityDetails>? activityDetails;
  const AcceptanceGraph({this.activityDetails, Key? key}) : super(key: key);
  @override
  _AcceptanceGraphState createState() => _AcceptanceGraphState();
}

class _AcceptanceGraphState extends State<AcceptanceGraph> {
  final SentryClient sentry = SentryClient(SentryOptions(dsn: dsn));
  late List<String> weekLabels;
  late double width;
  late DateTime now;
  late int currentTriplet;
  late int currentYear;
  late List<DateTime> range;
  late List<DateTime> renderRange;
  late List<String> monthLabels;
  late Map<DateTime?, int?> input;
  late int column;

  @override
  void initState() {
    super.initState();
    weekLabels = ["S", "M", "T", "W", "T", "F", "S"];
    now = DateTime.now();
    currentYear = now.year;
    currentTriplet = ((now.month - 1) ~/ 3) + 1;
    dataSetup();
  }

  void dataSetup() async {
    range = utils.DateUtils.daysInRange(
      DateTime(currentYear, currentTriplet * 3 - 2),
      utils.DateUtils.lastDayOfMonth(
        DateTime(currentYear, currentTriplet * 3),
      ),
    ).toList();
    range.add(
      utils.DateUtils.lastDayOfMonth(
        DateTime(currentYear, currentTriplet * 3),
      ),
    );
    renderRange = utils.DateUtils.daysInRange(
      utils.DateUtils.firstDayOfWeek(range.first),
      utils.DateUtils.lastDayOfWeek(range.last),
    ).toList();
    renderRange.add(utils.DateUtils.lastDayOfWeek(range.last));
    switch (currentTriplet) {
      case 1:
        monthLabels = ["Jan", "Feb", "Mar"];
        break;
      case 2:
        monthLabels = ["Apr", "May", "Jun"];
        break;
      case 3:
        monthLabels = ["Jul", "Aug", "Sep"];
        break;
      case 4:
        monthLabels = ["Oct", "Nov", "Dec"];
        break;
    }
    try {
      input = Map<DateTime?, int?>.fromIterable(
        renderRange,
        key: (element) => DateTime(element.year, element.month, element.day),
        value: (element) {
          if (!range.contains(
            DateTime(element.year, element.month, element.day),
          )) {
            return null;
          } else {
            return 0;
          }
        },
      );
      for (var element in widget.activityDetails!) {
        if (input.containsKey(element.createdAt)) {
          input[element.createdAt] =
              (element.correct! - (element.total! - element.correct!));
        }
      }
      column = input.length ~/ 7;
    } catch (error, stackTrace) {
      if (foundation.kReleaseMode) {
        await sentry.captureException(
          error,
          stackTrace: stackTrace,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Acceptance Graph",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                currentYear.toString(),
                style: const TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            const SizedBox(
              width: 40,
            ),
            SizedBox(
              width: 20,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    if (currentTriplet == 1) {
                      currentYear--;
                      currentTriplet = 4;
                    } else {
                      currentTriplet--;
                    }
                    dataSetup();
                  });
                },
              ),
            ),
            SizedBox(
              width: (width - 100) / 3,
              child: Text(
                monthLabels[0],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF979797),
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              width: (width - 100) / 3,
              child: Text(
                monthLabels[1],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF979797),
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              width: (width - 100) / 3,
              child: Text(
                monthLabels[2],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF979797),
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              width: 20,
              child: IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      if (currentTriplet == 4) {
                        currentYear++;
                        currentTriplet = 1;
                      } else {
                        currentTriplet++;
                      }
                      dataSetup();
                    });
                  }),
            ),
            const SizedBox(width: 20)
          ],
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: weekLabels
                  .map(
                    (e) => SizedBox(
                      width: 22,
                      height: 22,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          e,
                          style: const TextStyle(
                            color: Color(0xFF979797),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(width: 18),
            SizedBox(
              width: width - 100,
              child: Row(
                children: _buildWeekColumns(),
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
          child: Row(
            children: const [
              Spacer(),
              Text("-5"),
              SizedBox(width: 80),
              Text("5"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 100,
              height: 10,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.white, Colors.green],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _buildWeekColumns() {
    List<Column> weekColumns = <Column>[];
    for (int i = 0; i < column; i++) {
      weekColumns.add(Column(children: _buildWeekDays(i)));
    }
    return weekColumns;
  }

  List<Widget> _buildWeekDays(int i) {
    List<Container> weekDays = <Container>[];
    for (int j = 0; j < 7; j++) {
      DateTime date = DateTime(
        renderRange[i * 7 + j].year,
        renderRange[i * 7 + j].month,
        renderRange[i * 7 + j].day,
      );
      weekDays.add(
        Container(
          margin: const EdgeInsets.all(2),
          width: (width - 100 - 4 * column) / column,
          height: 18,
          color: input[date] == null ? Colors.white : getColor(input[date]!),
        ),
      );
    }
    return weekDays;
  }

  Color getColor(int index) {
    if (index <= -5) {
      return const Color.fromRGBO(255, 0, 0, 1);
    } else if (index == -4) {
      return const Color.fromRGBO(255, 0, 0, 0.8);
    } else if (index == -3) {
      return const Color.fromRGBO(255, 0, 0, 0.6);
    } else if (index == -2) {
      return const Color.fromRGBO(255, 0, 0, 0.4);
    } else if (index == -1) {
      return const Color.fromRGBO(255, 0, 0, 0.2);
    } else if (index == 0) {
      return const Color(0xFFEEEEEE);
    } else if (index == 1) {
      return const Color.fromRGBO(0, 255, 0, 0.2);
    } else if (index == 2) {
      return const Color.fromRGBO(0, 255, 0, 0.4);
    } else if (index == 3) {
      return const Color.fromRGBO(0, 255, 0, 0.6);
    } else if (index == 4) {
      return const Color.fromRGBO(0, 255, 0, 0.8);
    } else {
      return const Color.fromRGBO(0, 255, 0, 1);
    }
  }
}
