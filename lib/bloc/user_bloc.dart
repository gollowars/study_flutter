import 'dart:ffi';

import 'package:netroll/models/user.dart';
import 'package:netroll/repositories/api_repository.dart';
import 'package:rxdart/rxdart.dart';

class UsersBloc {
  final _subject = PublishSubject<UserResponse>();
  final _loadingSubject = BehaviorSubject<bool>.seeded(false);

  UsersBloc();

  Stream<UserResponse> get stream => _subject.stream;
  Sink<UserResponse> get sink => _subject.sink;
  Stream<bool> get isLoadingStream => _loadingSubject.stream;

  void fetch() async {
    _loadingSubject.add(true);
    final _response = await UsersRepository().fetch();
    sink.add(_response);
    _loadingSubject.add(false);
  }

  void dispose() {
    _subject.close();
    _loadingSubject.close();
  }
}
