import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome to Flutter",
      home: Scaffold(
        appBar: AppBar(title: const Text("hello")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("STATELESS TEXT"), 
            MyContainer(title: "ashikawa",)
          ],
        )),
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
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Text("count : $_counter "),
          ElevatedButton(onPressed: _incrementCounter, child: const Icon(Icons.add))
        ]);
  }
}
