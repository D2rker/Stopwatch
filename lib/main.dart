import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(StopWatchApp());
}

class StopWatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stop Watch App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black12, // Set a light background color
      ),
      home: StopWatchHomePage(),
    );
  }
}

class StopWatchHomePage extends StatefulWidget {
  @override
  _StopWatchHomePageState createState() => _StopWatchHomePageState();
}

class _StopWatchHomePageState extends State<StopWatchHomePage> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(Duration(milliseconds: 30), _updateTime);
  }

  void _updateTime(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {});
    }
  }

  String _formatTime(int milliseconds) {
    var ms = (milliseconds % 1000) ~/ 10;
    var sec = (milliseconds ~/ 1000) % 60;
    var min = (milliseconds ~/ 60000) % 60;
    return '${min.toString().padLeft(2, '0')}:'
        '${sec.toString().padLeft(2, '0')}:'
        '${ms.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop Watch App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 250,
                  height: 250,
                  child: CircularProgressIndicator(
                    value: _stopwatch.elapsedMilliseconds % 60000 / 60000,
                    strokeWidth: 6,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
                Text(
                  _formatTime(_stopwatch.elapsedMilliseconds),
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Set the stopwatch text color to white
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildControlButton(
                  icon: _stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                  onPressed: _startStopwatch,
                ),
                SizedBox(width: 20),
                _buildControlButton(
                  icon: Icons.stop,
                  onPressed: _resetStopwatch,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({required IconData icon, required VoidCallback onPressed}) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(icon),
      backgroundColor: Colors.blue,
    );
  }

  void _startStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {});
  }
}
