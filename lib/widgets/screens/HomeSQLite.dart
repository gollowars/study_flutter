import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:netroll/bloc/DogDBBloc.dart';
import 'package:netroll/models/Dog.dart';
import 'package:netroll/providers/db_provider.dart';
import 'package:provider/provider.dart';

import 'package:faker/faker.dart';

class HomeSQLite extends StatelessWidget {
  const HomeSQLite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<DogDBBloc>(
      create: (context) => DogDBBloc(dbProvider: DBProvider()),
      child: const HomeSQLiteTemplate(),
      dispose: (context, value) => value.dispose(),
    );
  }
}

class HomeSQLiteTemplate extends StatelessWidget {
  const HomeSQLiteTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dbmanager = Provider.of<DogDBBloc>(context);



    dbmanager.dogListStream.listen((dogs) {
      print('-----------');
      for (var dog in dogs) {
        print(dog);
      }
    });

    void addDog() {
      var name = faker.person.name();
      var age = math.Random().nextInt(30);
      final dog = Dog(name: name, age: age);
      dbmanager.add(dog);
    }

    void deleteDog(Dog dog) {
      dbmanager.delete(dog);
    }

    dbmanager.fetchAll();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addDog,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SafeArea(
            child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Sample SQLite",
                  style: TextStyle(fontFamily: 'Raleway', fontSize: 24),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<Dog>>(
                  stream: dbmanager.dogListStream,
                  builder: (context, snapshot) {
                    List<Dog>? dogs = snapshot.data;
                    if (dogs == null) {
                      return Container();
                    }

                    return ListView.builder(
                      itemCount: dogs.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var dog = dogs[index];

                        void onDelete(BuildContext context) {
                          deleteDog(dog);
                        }

                        return Slidable(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.deepPurple[400],
                                border: const Border(
                                    bottom: BorderSide(color: Colors.white))),
                            child: ListTile(
                              leading: const Icon(
                                Icons.account_box,
                                color: Colors.white,
                              ),
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dog.name,
                                    style: const TextStyle(
                                        fontFamily: "Raleway",
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text('age : ${dog.age}',
                                      style: const TextStyle(
                                          fontFamily: "Raleway",
                                          fontSize: 16,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: onDelete,
                                flex: 1,
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
