import 'dart:async';
import 'package:netroll/widgets/screens/HomeSQLite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/material.dart';
import 'package:netroll/widgets/screens/HomeReq.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('ja');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const HomeSQLite(),
      debugShowCheckedModeBanner: false,
    );
  }
}
