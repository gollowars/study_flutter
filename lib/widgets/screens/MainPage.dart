import 'package:fasting_timer/bloc/RouteBloc.dart';
import 'package:fasting_timer/constants.dart';
import 'package:fasting_timer/model/TabIconInfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tabPage = TabPage.of(context);
    final routemaster = Routemaster.of(context);

    final routeBlocRepo = Provider.of<RouteBlocRepository>(context);

    print('current Page path : ${routemaster.currentRoute.path}');
    routeBlocRepo.DidChangeStream.listen((params) {
      print(' new path : ${params.routedata.path}');
    });

    return Scaffold(
      body: TabBarView(
        controller: tabPage.controller,
        children: [
          for (final stack in tabPage.stacks) PageStackNavigator(stack: stack),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          border: Border(
            top: BorderSide(
              color: headlineColor,
              width: 2,
            ),
            bottom: BorderSide(
              color: headlineColor,
              width: 2,
            ),
            right: BorderSide(
              color: headlineColor,
              width: 2,
            ),
            left: BorderSide(
              color: headlineColor,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: createNavItem(routemaster, RoutesTabInfoList),
        ),
      ),
    );
  }
}

List<Widget> createNavItem(Routemaster routemaster, List<TabIconInfo> items) {
  final String path = routemaster.currentRoute.path;
  return items.asMap().entries.map((e) {
    var tabInfo = e.value;
    var index = tabInfo.path.indexOf(path);

    var color = (index == -1) ? headlineColor : catch1Color;

    TextStyle tabTextStyle = TextStyle(
        fontFamily: 'Raleway', fontSize: 14, height: 0.7, color: color);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 3),
        IconButton(
            icon: Icon(tabInfo.iconData, color: color),
            onPressed: () => routemaster.push(tabInfo.path)),
        Text(tabInfo.label, style: tabTextStyle)
      ],
    );
  }).toList();
}
