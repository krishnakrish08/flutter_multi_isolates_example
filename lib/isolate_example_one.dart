import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IsolateExampleOne extends StatefulWidget {
  const IsolateExampleOne({super.key});

  @override
  IsolateExampleState createState() => IsolateExampleState();
}

class IsolateExampleState extends State<IsolateExampleOne> {
  String _apiData = 'Fetching data...';
  String _cpuResult = 'Calculating...';

  @override
  void initState() {
    super.initState();
    _fetchApiData();
    _performCpuIntensiveTask();
  }

  Future<void> _fetchApiData() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_fetchData, receivePort.sendPort);

    final sendPort = await receivePort.first as SendPort;
    final responsePort = ReceivePort();
    sendPort.send(responsePort.sendPort);

    final data = await responsePort.first as String;
    setState(() {
      _apiData = data;
    });
  }

  static Future<void> _fetchData(SendPort sendPort) async {
    final responsePort = ReceivePort();
    sendPort.send(responsePort.sendPort);

    const url = 'https://jsonplaceholder.typicode.com/posts/1';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body)['title'];

    final send = await responsePort.first as SendPort;
    send.send(data);
  }

  Future<void> _performCpuIntensiveTask() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_cpuTask, receivePort.sendPort);

    final sendPort = await receivePort.first as SendPort;
    final responsePort = ReceivePort();
    sendPort.send(responsePort.sendPort);

    final result = await responsePort.first as int;
    setState(() {
      _cpuResult = 'Result: $result';
    });
  }

  static void _cpuTask(SendPort sendPort) async {
    final responsePort = ReceivePort();
    sendPort.send(responsePort.sendPort);

    int result = 0;
    /*for (int i = 0; i < 1000; i++) {
      result += i;
    }*/
    for (int i = 0; i < 1000000000; i++) {
      result += i;
    }

    debugPrint('_cpuTask -- $result');

    final send = await responsePort.first as SendPort;
    send.send(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('API Data: $_apiData'),
            const SizedBox(height: 20),
            Text('CPU Task Result: $_cpuResult'),
          ],
        ),
      ),
    );
  }
}
