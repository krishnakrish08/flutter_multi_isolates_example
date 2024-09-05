import 'package:flutter/material.dart';
import 'package:flutter_multi_isolates_example/isolate_example_one.dart';
import 'package:flutter_multi_isolates_example/isolates_example_two.dart';

class IsolatesHomeScreen extends StatelessWidget {
  const IsolatesHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Isolates Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const IsolateExampleOne();
                    },
                  ),
                );
              },
              child: const Text(" Isolates Example 1"),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const IsolatesExampleTwo();
                    },
                  ),
                );
              },
              child: const Text(" Isolates Example 2"),
            )
          ],
        ),
      ),
    );
  }
}
