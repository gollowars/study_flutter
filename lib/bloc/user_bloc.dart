import 'package:netroll/models/user.dart';
import 'package:netroll/repositories/api_repository.dart';
import 'package:rxdart/rxdart.dart';

class UsersBloc {
  final _subject = PublishSubject<UserResponse>();

  UsersBloc();

  Stream<UserResponse> get stream => _subject.stream;
  Sink<UserResponse> get sink => _subject.sink;

  void fetch() async {
    final _response = await UsersRepository().fetch();
    sink.add(_response);
  }

  void dispose() {
    _subject.close();
  }
}
