import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  const Clock({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  bool _short = true;

  void toogle() {
    setState(() {
      _short = !_short;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return GestureDetector(
            child: Container(
              child: Text(
                  DateFormat(_short ? 'hh:mm' : 'MM/dd/yyyy hh:mm:ss')
                      .format(DateTime.now()),
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF707A8C))),
            ),
            onTap: toogle);
      },
    );
  }
}
