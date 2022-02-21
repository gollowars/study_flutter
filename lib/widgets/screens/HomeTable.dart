import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:netroll/constants.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:netroll/utils.dart';

class HomeTable extends StatefulWidget {
  const HomeTable({Key? key}) : super(key: key);

  @override
  _HomeTableState createState() => _HomeTableState();
}

class _HomeTableState extends State<HomeTable> {
  CalendarFormat _calformat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List> _eventList = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    _eventList = {
      DateTime.now().subtract(const Duration(days: 2)): ['Event 1', 'Event 2'],
      DateTime.now().add(const Duration(days: 1)): [
        'Event 3 本日のタスク',
        'Event 4 asd;flkjasdf',
        'Event 5 hello world',
        'Event 6 vomit vomit',
        'Event 7 table_calendar',
        'Event 8',
        'Event 9',
        'Event 10',
        'Event 11',
        'Event 12',
        'Event 13',
        'Event 14',
        'Event 15',
        'Event 16',
      ],
      DateTime.now().add(const Duration(days: 3)):
          {'Event 17', 'Event 18', 'Event 19'}.toList(),
    };
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return Positioned(
      right: 5,
      bottom: 5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.redAccent,
        ),
        width: 16.0,
        height: 16.0,
        child: Center(
          child: Text(
            '${events.length}',
            style: const TextStyle().copyWith(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.all(14),
              child: Text("Sample Calendar",
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 24,
                      fontWeight: FontWeight.bold))),
          TableCalendar(
            locale: 'ja_JP',
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calformat,
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
              formatButtonTextStyle:
                  const TextStyle(fontFamily: 'Raleway', color: Colors.white),
            ),
            eventLoader: getEventForDay,
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return _buildEventsMarker(date, events);
                }
              },
              selectedBuilder: (context, day, focusedDay) {},
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TableWeekDayStyle,
                weekendStyle: TableWeekEndDayStyle),
            calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                todayDecoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0)),
                selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0)),
                weekendDecoration: BoxDecoration(
                    color: Colors.amber[100],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0)),
                holidayDecoration: BoxDecoration(
                    color: Colors.amber[100],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0)),
                defaultDecoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5.0))),
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
            onFormatChanged: (format) {
              if (_calformat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calformat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
              child: ListView(
            shrinkWrap: true,
            children: getEventForDay(_selectedDay!)
                .map((e) => Container(
                  decoration:  const BoxDecoration(
                    color: Colors.blue,
                    border: Border(bottom: BorderSide( color: Colors.white ))
                  ),
                  child: ListTile(
                      leading: const Icon(Icons.alarm,color: Colors.white,),
                      title: Text(e.toString(),style: const TextStyle(fontFamily: 'Raleway', color: Colors.white),),
                    ),
                ))
                .toList(),
          )),
        ],
      )),
    );
  }
}
