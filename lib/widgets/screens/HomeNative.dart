import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

const String DOMAIN_NAME = "samples.flutter.dev";

class SampleNative {
  final platform = const MethodChannel('$DOMAIN_NAME/battery');
  final _batterySubject =
      BehaviorSubject<String>.seeded('Unknown Battery Level.');

  Stream<String> get batteryStream => _batterySubject.stream;

  SampleNative();

  void getBatteryLevel() async {
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      print("battery is : $result");
      
      _batterySubject.add('Battery level at $result % .');
    } on PlatformException catch (e) {
      _batterySubject.add("Failed to get battery level : ${e.message}");
    }
  }

  void dispose() {
    _batterySubject.close();
  }
}

class HomeNative extends StatelessWidget {
  const HomeNative({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<SampleNative>(
      create: (context) => SampleNative(),
      child: const HomeNativeTemplate(),
      dispose: (context, value) => value.dispose(),
    );
  }
}

class HomeNativeTemplate extends StatelessWidget {
  const HomeNativeTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final batteryBloc = Provider.of<SampleNative>(context);

    void onGetBattery() {
      print('get battery');
      batteryBloc.getBatteryLevel();
    }

    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sample Native',
                style: TextStyle(fontFamily: "Raleway", fontSize: 24),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: onGetBattery, child: const Text("GetBattery")),
              StreamBuilder<String>(
                stream: batteryBloc.batteryStream,
                builder: (context, snapshot) {
                  String? batteryLevel = snapshot.data;
                  if (!snapshot.hasData || batteryLevel == null) {
                    return Container();
                  }
                  return Text(batteryLevel);
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
