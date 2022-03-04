import 'package:fasting_timer/model/TabIconInfo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryTextColor = const Color(0xFF414C6B);
Color headlineColor = const Color(0xFF001858);
Color catch1Color = const Color(0xFFF582AE);


List<TabIconInfo> RoutesTabInfoList = [
  const TabIconInfo(
      path: '/timer', iconData: FontAwesomeIcons.utensils, label: "Timer"),
  const TabIconInfo(
      path: '/records',
      iconData: FontAwesomeIcons.calendarAlt,
      label: "Records"),
  const TabIconInfo(
      path: '/settings', iconData: Icons.settings, label: "Settings"),
];
