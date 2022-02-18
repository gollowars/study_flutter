import 'package:netroll/models/Dog.dart';
import 'package:netroll/providers/db_provider.dart';
import 'package:rxdart/rxdart.dart';

class DogDBBloc {
  final DBProvider dbProvider;
  DogDBBloc({required this.dbProvider});

  final _dogListSubject = PublishSubject<List<Dog>>();
  Stream<List<Dog>> get dogListStream => _dogListSubject.stream;

  Future<void> fetchAll() async {
    final dogs = await dbProvider.loadAll();
    _dogListSubject.add(dogs);
  }

  Future<int> add(Dog dog) async {
    final int id = await dbProvider.insert(dog);
    fetchAll();
    return id;
  }

  Future<int> delete(Dog dog) async {
    final int id = await dbProvider.delete(dog);
    fetchAll();
    return id;
  }

  void dispose() {
    _dogListSubject.close();
  }
}
