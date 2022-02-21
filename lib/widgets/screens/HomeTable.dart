import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:netroll/utils.dart';

class HomeTable extends StatefulWidget {
  const HomeTable({Key? key}) : super(key: key);

  @override
  _HomeTableState createState() => _HomeTableState();
}

class _HomeTableState extends State<HomeTable> {
  final CalendarFormat _calformat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List> _eventList = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    _eventList = {
      DateTime.now().subtract(const Duration(days: 2)): [
        'Event A6',
        'Event B6'
      ],
      DateTime.now().add(const Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8',
        'Event D8',
        'Event D8',
        'Event D8',
        'Event D8',
        'Event D8',
        'Event D8',
        'Event D8',
        'Event D8',
        'Event D8',
        'Event D8',
      ],
      DateTime.now().add(const Duration(days: 3)):
          {'Event A9', 'Event A9', 'Event B9'}.toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final _events =
        LinkedHashMap<DateTime, List>(equals: isSameDay, hashCode: getHashCode)
          ..addAll(_eventList);

    List getEventForDay(DateTime day) {
      return _events[day] ?? [];
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              calendarFormat: _calformat,
              headerStyle: const HeaderStyle(formatButtonVisible: false),
              eventLoader: getEventForDay,
              selectedDayPredicate: (day) {
                bool isSameFlag = isSameDay(_selectedDay, day);
                print('${day.month}/${day.day} ,SameDay :$isSameFlag');
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                print('onSelect!!');
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });

                  getEventForDay(selectedDay);
                }
              },
              // onFormatChanged: (format) {
              //   if (_calformat != format) {
              //     // Call `setState()` when updating calendar format
              //     setState(() {
              //       _calformat = format;
              //     });
              //   }
              // },
              // onPageChanged: (focusedDay) {
              //   // No need to call `setState()` here
              //   _focusedDay = focusedDay;
              // },
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: getEventForDay(_selectedDay!)
                  .map((e) => ListTile(
                    title: Text(e.toString()),
                  ))
                  .toList(),
              )
            ),

          ],
        )
      ),
    );
  }
}
