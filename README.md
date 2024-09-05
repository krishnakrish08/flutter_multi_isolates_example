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

## Asynchronous _cpuTask Function:

The _cpuTask function is now marked as async to ensure it can await the responsePort.first call correctly.
This ensures that the SendPort is correctly awaited and the result is sent back to the main isolate.

## Ensuring Correct Data Flow:

The await keyword is used appropriately to ensure that the data is correctly sent and received between the isolates.

# API Isolate: 
The apiIsolate function simulates fetching data from an API. It communicates back to the main isolate using a SendPort.
# CPU-Intensive Task Isolate: 
The computeIsolate function simulates a intensive computational task that counts a sum. Results are sent back to the main isolate via the SendPort.
# UI Trigger and Display
The main UI has buttons to trigger API fetch and computation. It displays results using state variables updated when messages are received from other isolates.
# Security and Performance Notes
Ensure that any data sent between isolates is thread-safe. Dart automatically copies messages between isolates.

For real-world applications, especially involving networking or I/O, consider handling errors and timeouts.

This basic framework can be scaled up with real API calls, error handling, and more complex computations or processes spread across multiple isolates to enhance your application performance and maintain responsiveness.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
