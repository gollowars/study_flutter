import 'package:flutter/material.dart';
import 'package:netroll/widgets/screens/HomeNative.dart';
// import 'package:netroll/widgets/screens/HomeReq.dart';

void main() {
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
      home: const HomeNative(),
      debugShowCheckedModeBanner: false,
    );
  }
}
