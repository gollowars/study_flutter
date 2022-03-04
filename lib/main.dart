import 'package:fasting_timer/bloc/RouteBloc.dart';
import 'package:fasting_timer/widgets/screens/CalendarPage.dart';
import 'package:fasting_timer/widgets/screens/MainPage.dart';
import 'package:fasting_timer/widgets/screens/SettingsPage.dart';
import 'package:fasting_timer/widgets/screens/TimerPage.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:provider/provider.dart';



RouteMap createRoutes(RouteBlocRepository routeBlocRep) {
  final routes = RouteMap(routes: {
    '/': (route) => TabPage(
        child: Provider<RouteBlocRepository>(
          create: (context) => routeBlocRep,
          child: const MainPage(),
          dispose: (context, value) => routeBlocRep.dispose(),
        ),
        paths: const ['/timer', '/records', '/settings']),
    '/timer': (route) => const MaterialPage(child: TimerPage()),
    '/records': (route) => const MaterialPage(child: CalendarPage()),
    '/settings': (route) => const MaterialPage(child: SettingsPage())
  });
  return routes;
}

void main() {
  // create routebloc
  final routeBloc = RouteBloc();
  // create observer
  // observerにbloc渡して route変わったらtriggerさせるようにする。
  final routeObserver = RouteBlocObserver(routeBloc: routeBloc);
  // routeを生成する。
  final routes = createRoutes(RouteBlocRepository(routeBloc: routeBloc));

  runApp(
    MaterialApp.router(
      routerDelegate: RoutemasterDelegate(
        observers: [routeObserver],
        routesBuilder: (_) => routes,
      ),
      routeInformationParser: const RoutemasterParser(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
