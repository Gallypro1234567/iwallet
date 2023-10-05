import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwallet/app/theme/app_theme.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late CleanCalendarController calendarController;

  @override
  void initState() {
    var now = DateTime.now();
    calendarController = CleanCalendarController(
      minDate: DateTime(now.year - 1, now.month - 1, now.day),
      maxDate: DateTime(now.year, now.month + 1, now.day),
      onRangeSelected: (firstDate, secondDate) {},
      onDayTapped: (date) {
        Get.back(result: date);
      },
      // readOnly: true,
      onPreviousMinDateTapped: (date) {},
      onAfterMaxDateTapped: (date) {},
      weekdayStart: DateTime.monday,
      initialFocusDate: now,
      initialDateSelected: now,
      endDateSelected: now,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Thêm Giao dịch',
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
        ),
        titleSpacing: 0.0,
      ),
      backgroundColor: Theme.of(context).cardColor,
      body: Column(
        children: [
          Container(
            color: Theme.of(context).highlightColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  'Th2',
                  'Th3',
                  'Th4',
                  'Th5',
                  'Th6',
                  'Th7',
                  'CN',
                ]
                    .map((e) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(child: Text(e)),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: ScrollableCleanCalendar(
              calendarController: calendarController,
              layout: Layout.BEAUTY,
              calendarCrossAxisSpacing: 0,
              daySelectedBackgroundColor: AppTheme.primaryColor,
              showWeekdays: false,
              calendarMainAxisSpacing: 16.0,
              dayBuilder: (context, values) => Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        width: 1.0, color: Theme.of(context).dividerColor),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: values.isSelected ? AppTheme.primaryColor : null,
                  ),
                  child: Center(
                    child: Text(
                      values.text,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          color: values.isSelected ? Colors.white : null,
                          fontWeight: values.isLastDayOfWeek
                              ? FontWeight.w300
                              : FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
