import 'package:flutter/material.dart';




//provided by flutter alarm clock package
class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter alarm clock example'),
      ),
      body: Center(
          child: Column(children: <Widget>[
        Container(
          margin: const EdgeInsets.all(25),
          child: TextButton(
            child: const Text(
              'Create alarm at 23:59',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              // FlutterAlarmClock.createAlarm(4, 40);
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(25),
          child: TextButton(
            child: const Text(
              'Show alarms',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              // FlutterAlarmClock.showAlarms();
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(25),
          child: TextButton(
            child: const Text(
              'Create timer for 42 seconds',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              // FlutterAlarmClock.createTimer(42);
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(25),
          child: TextButton(
            child: const Text(
              'Show Timers',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              // FlutterAlarmClock.showTimers();
            },
          ),
        ),
      ])),
    );
  }
}