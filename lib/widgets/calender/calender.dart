import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  final today = DateTime.now();
  var monthName;
  var dayName;
  var headerTextColor;
  
  

  void onPageChange(DateTime date, int index) {
    setState(() {
        monthName = DateFormat('MMMM').format(date);
        dayName = DateFormat('EEEE').format(date);
      });
    if (date.day == today.day) {
      setState(() {
        headerTextColor = Theme.of(context).colorScheme.primary;
      });
    } else {
      setState(() {
        headerTextColor = Colors.black;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    monthName = DateFormat('MMMM').format(today);
    dayName = DateFormat('EEEE').format(today);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      // void Function(DateTime, int)? onPageChange,
      // Widget Function(DateTime)? dayTitleBuilder,
      child: DayView(
        onPageChange: (date, index) {
          onPageChange(date, index);
        },
        dayTitleBuilder: (date) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withAlpha(40),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(4),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  dayName,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 10,
                  ),
                ),
                Text(
                  '${date.day} $monthName ${date.year}',
                  style: TextStyle(
                    // color: Theme.of(context).colorScheme.onSurface,
                    color: headerTextColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
        initialDay: today,
        keepScrollOffset: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        heightPerMinute: 1,
        showVerticalLine: false,
      ),
    );
  }
}