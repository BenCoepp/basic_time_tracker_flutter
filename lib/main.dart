import 'dart:convert';
import 'dart:io';

import 'package:basic_time_tracker_flutter/Controll_Component.dart';
import 'package:basic_time_tracker_flutter/List_Component.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'data.dart' as data;

void main() {
  runApp(const MyApp());
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
  Future<void> writeToFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File(appDocPath + "\\exportList.json");
    // Write the file
    file.writeAsString(jsonEncode(data.entries));
    final snackBar = SnackBar(
      content: Text('Liste exported to ' + file.path.toString()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                writeToFile();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Center(
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
    );
  }
}
