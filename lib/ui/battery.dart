import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Battery battery = Battery();
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          return FutureBuilder<int>(
              future: battery.batteryLevel,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(children: [
                      Container(
                        child: Icon(Icons.battery_full,
                            color: Color(0xFFffcc66), size: 16),
                      ),
                      Text(snapshot.data.toString() + "%",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF707A8C)))
                    ]));
              });
        });
  }
}
