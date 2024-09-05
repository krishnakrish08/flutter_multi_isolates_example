import 'dart:isolate';

import 'package:flutter/material.dart';

class IsolatesExampleTwo extends StatefulWidget {
  const IsolatesExampleTwo({super.key});

  @override
  State<IsolatesExampleTwo> createState() => _IsolatesExampleTwoState();
}

class _IsolatesExampleTwoState extends State<IsolatesExampleTwo> {
  String data = 'No Data';
  String computationResult = 'No Computation Done';

  void fetchApiData() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(apiIsolate, receivePort.sendPort);
    receivePort.listen((message) {
      setState(() {
        data = message;
      });
    });
  }

  void runComputation() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(computeIsolate, receivePort.sendPort);
    receivePort.listen((result) {
      setState(() {
        computationResult = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Multi-Isolate Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: fetchApiData,
              child: const Text('Fetch API Data'),
            ),
            Text(data),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: runComputation,
              child: const Text('Run Heavy Computation'),
            ),
            Text(computationResult),
          ],
        ),
      ),
    );
  }

  // Simulate an API call
  static void apiIsolate(SendPort sendPort) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    sendPort.send('Data fetched from API!');
  }

  // Simulate a CPU-intensive task
  static void computeIsolate(SendPort sendPort) {
    int sum = 0;
    for (int i = 0; i < 1e8; i++) {
      sum += i;
    }
    sendPort.send('Computation result: $sum');
  }
}
