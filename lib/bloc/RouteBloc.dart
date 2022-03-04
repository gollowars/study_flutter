import 'package:routemaster/routemaster.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class RouteDidPopParams {
  final Route route;
  final Route? previousRoute;
  const RouteDidPopParams({required this.route, required this.previousRoute});
}

class RouteDidChangeRoute {
  final RouteData routedata;
  final Page page;

  const RouteDidChangeRoute({required this.routedata, required this.page});
}

class RouteBloc {
  final _didPopStream = PublishSubject<RouteDidPopParams>();
  Stream<RouteDidPopParams> get didPopStream => _didPopStream.stream;
  Sink<RouteDidPopParams> get didPopSink => _didPopStream.sink;

  final _didChangeStream = PublishSubject<RouteDidChangeRoute>();
  Stream<RouteDidChangeRoute> get didChangeStream => _didChangeStream.stream;
  Sink<RouteDidChangeRoute> get didChangeSink => _didChangeStream.sink;

  RouteBloc();

  void dispose() {
    _didPopStream.close();
  }
}

class RouteBlocRepository {
  final RouteBloc routeBloc;
  Stream<RouteDidPopParams> get DidPopStream => routeBloc.didPopStream;
  Stream<RouteDidChangeRoute> get DidChangeStream => routeBloc.didChangeStream;
  
  const RouteBlocRepository({required this.routeBloc});
  void dispose() {
    routeBloc.dispose();
  }
}

class RouteBlocObserver extends RoutemasterObserver {
  final RouteBloc routeBloc;
  RouteBlocObserver({required this.routeBloc});

  @override
  void didPop(Route route, Route? previousRoute) {
    print('Popped a route');
    final params =
        RouteDidPopParams(route: route, previousRoute: previousRoute);
    routeBloc.didPopSink.add(params);
  }

  @override
  void didChangeRoute(RouteData routeData, Page page) {
    print('New route: ${routeData.path}');
    final params = RouteDidChangeRoute(routedata: routeData, page: page);
    routeBloc.didChangeSink.add(params);
  }
}