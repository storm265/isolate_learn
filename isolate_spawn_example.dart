import 'dart:isolate';

void main(List<String> arguments) async {
  
  void calcSum(SendPort sendPort) {
    int sum = 0;
    for (var i = 0; i < 999; i++) {
      sum += 1;
      print('sum $sum');
      sendPort.send(sum);
    }
    sendPort.send(null);
  }

  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(calcSum, receivePort.sendPort);
  receivePort.listen((message) {
    print(message);
  });
  isolate.kill();
}
