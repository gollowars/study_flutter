import 'package:flutter/material.dart';
import 'package:netroll/widgets/screens/HomeArpScanner.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.dark
    ..backgroundColor = Colors.green
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black;
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
      home: const HomeArpScanner(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}
