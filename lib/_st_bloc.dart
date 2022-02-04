import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Text(ref.read(stringStateProvider))
    return MaterialApp(
      title: "Welcome to Flutter",
      home: Scaffold(
        appBar: AppBar(title: const Text("hello")),
        body: Provider<CounterBloc>(
            create: (context) => CounterBloc(),
            dispose: (context, value) => value.dispose(),
            child: const MyBody()),
      ),
    );
  }
}

class CounterBloc {
  // final _actionController = StreamController<void>();
  // Sink<void> get increment => _actionController.sink;

  // final _decrementController = StreamController<void>();
  // Sink<void> get decrement => _decrementController.sink;

  final _countController = StreamController<int>();
  Stream<int> get count => _countController.stream;

  int _count = 0;

  void increment() {
    _count++;
    _countController.sink.add(_count);
  }

  void decrement() {
    _count--;
    _countController.sink.add(_count);
  }

  void clear() {
    _count = 0;
    _countController.sink.add(_count);
  }

  CounterBloc() {
    // _actionController.stream.listen((_) {
    //   _count++;
    //   _countController.sink.add(_count);
    // });
  }

  void dispose() {
    // _actionController.close();
    _countController.close();
  }
}

class MyBody extends StatelessWidget {
  const MyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterBloc = Provider.of<CounterBloc>(context);
    void add() {
      counterBloc.increment();
    }

    void remove() {
      counterBloc.decrement();
    }

    void clear() {
      counterBloc.clear();
    }

    return Center(
      child: Column(
        children: [
          const Text('Study BLoC'),
          StreamBuilder(
              initialData: 0,
              stream: counterBloc.count,
              builder: (context, snapshot) {
                return Text("Count is : ${snapshot.data}");
              }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: add, child: const Text('Inc')),
                ElevatedButton(onPressed: remove, child: const Text('Dec')),
                ElevatedButton(onPressed: clear, child: const Text('Clear'))
              ],
            )
        ],
      ),
    );
  }
}

class MyContainer extends StatefulWidget {
  const MyContainer({Key? key, this.title = ''}) : super(key: key);

  final String title;
  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("count : $_counter "),
      ElevatedButton(onPressed: _incrementCounter, child: const Icon(Icons.add))
    ]);
  }
}
