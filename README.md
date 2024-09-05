# flutter_multi_isolates_example

A Multiple Isolate Example in Flutter project.

## Fetching Data from an API:

We create a new isolate using Isolate.spawn and pass a function _fetchData to it.
The _fetchData function makes an HTTP GET request to fetch data from an API.
The data is then sent back to the main isolate using SendPort.

## Performing a CPU-Intensive Task:

Similarly, we create another isolate for the CPU-intensive task using Isolate.spawn and pass a function _cpuTask to it.
The _cpuTask function performs a simple but CPU-intensive calculation (summing numbers from 0 to 1 billion).
The result is sent back to the main isolate using SendPort.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
