// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:basic_time_tracker_flutter/Controll_Component.dart';
import 'package:basic_time_tracker_flutter/List_Component.dart';
import 'package:basic_time_tracker_flutter/TopBar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'data.dart' as data;
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    final initialSize = Size(720, 480);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Time Tracker";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowBorder(
        color: Colors.transparent,
        width: 0,
        child: Column(
          children: [
            TopBar(),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.width / 3,
                      height: double.infinity,
                      child: ListComponent(),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      height: double.infinity,
                      child: ControllComponent(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
