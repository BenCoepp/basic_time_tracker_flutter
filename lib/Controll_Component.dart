// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_null_comparison, unused_local_variable, unnecessary_new, prefer_final_fields

import 'dart:async';
import 'dart:convert';

import 'package:basic_time_tracker_flutter/Item.dart';
import 'package:flutter/material.dart';
import 'data.dart' as data;
import 'package:shared_preferences/shared_preferences.dart';

class ControllComponent extends StatefulWidget {
  const ControllComponent({Key? key}) : super(key: key);
  static const routeName = '/list';
  @override
  State<ControllComponent> createState() => ControllComponentState();
}

class ControllComponentState extends State<ControllComponent> {
  @override
  void initState() {
    super.initState();
  }

  void update() {
    Timer timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
      setState(() {
        time = stopwatch.elapsedMilliseconds / 1000;
      });
    });
  }

  void writeToList() async {
    setState(() {
      DateTime dateTime = new DateTime.now();
      var tempItem = Item(
          date: dateTime.toString(),
          day: dateTime.weekday.toString(),
          time: stopwatch.elapsedMilliseconds / 1000);
      data.entries.add(tempItem);
      saveToLocalStorage();
    });
  }

  Future<void> saveToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("items", jsonEncode(data.entries));
  }

  bool timerActive = false;
  double time = 0;
  Stopwatch stopwatch = Stopwatch();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("$time seconds"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (timerActive == false)
                  IconButton(
                      onPressed: () {
                        stopwatch.start();
                        update();
                        setState(() {
                          timerActive = true;
                        });
                      },
                      icon: Icon(Icons.play_arrow)),
                if (timerActive == true)
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              stopwatch.stop();
                              writeToList();
                              stopwatch.reset();
                              update();
                              timerActive = false;
                            });
                          },
                          icon: Icon(Icons.stop)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              stopwatch.stop();
                              update();
                              timerActive = false;
                            });
                          },
                          icon: Icon(Icons.pause))
                    ],
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
