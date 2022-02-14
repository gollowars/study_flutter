import 'package:arp_scanner/device.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:arp_scanner/arp_scanner.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ArpBloc {
  final _subject = PublishSubject<List<Device>>();
  Stream<List<Device>> get stream => _subject.stream;
  ArpBloc();

  List<Device> deviceList = [];

  void scan() {
    // _subject.add([]);
    ArpScanner.onScanning.listen((Device device) {
      deviceList.add(device);
    });

    ArpScanner.onScanFinished.listen((event) {
      _subject.add(List.of(deviceList));
      deviceList.clear();
    });

    ArpScanner.scan();
  }

  void dispose() {
    _subject.close();
  }
}

class HomeArpScanner extends StatelessWidget {
  const HomeArpScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<ArpBloc>(
      create: (context) => ArpBloc(),
      child: const HomeArpAcannerTemplate(),
      dispose: (context, value) => value.dispose(),
    );
  }
}

class HomeArpAcannerTemplate extends StatelessWidget {
  const HomeArpAcannerTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arpBloc = Provider.of<ArpBloc>(context);

    void startScan() {
      arpBloc.scan();
      EasyLoading.show(status: "loading...");
    }

    arpBloc.stream.listen((devices) {
      EasyLoading.dismiss();
    });

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ArpScanner',
              style: TextStyle(fontFamily: "Raleway", fontSize: 24),
            ),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: startScan, child: const Text('Scan')),
            const SizedBox(height: 4),
            Expanded(
                child: StreamBuilder<List<Device>>(
              stream: arpBloc.stream,
              builder: (context, snapshot) {
                List<Device>? devices = snapshot.data;
                if (!snapshot.hasData || devices == null) {
                  return Container(
                    child: const Text('No Devices'),
                  );
                }

                print('devices length : ${devices.length}');

                return ListView.builder(
                  itemCount: devices.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var device = devices[index];
                    print('list deivce : ${device.ip}');
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('MAC : ${device.mac}',style: const TextStyle(fontFamily: "Raleway", fontSize: 14)),
                            Text('IP : ${device.ip}',style: const TextStyle(fontFamily: "Raleway", fontSize: 14)),
                            Text('HOSTNAME : ${device.hostname}',style: const TextStyle(fontFamily: "Raleway", fontSize: 14)),
                            // Text('TIME : ${device.time}'),
                            // Text('VENDOR : ${device.vendor}'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )),
          ],
        ),
      ),
    )));
  }
}
