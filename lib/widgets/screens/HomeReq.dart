import 'package:flutter/material.dart';
import 'package:netroll/constants.dart';

class HomeReq extends StatefulWidget {
  const HomeReq({Key? key}) : super(key: key);

  @override
  State<HomeReq> createState() => _HomeReqState();
}

class _HomeReqState extends State<HomeReq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientEndColor,
      body: const SafeArea(
        child: Center(child: Text('asdfa'),)
      ),
    );
  }
}
