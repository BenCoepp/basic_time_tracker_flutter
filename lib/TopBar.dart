// ignore_for_file: file_names, override_on_non_overriding_member, prefer_const_constructors, use_key_in_widget_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:basic_time_tracker_flutter/ActionMenu.dart';
import 'data.dart' as data;
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

const sidebarColor = Color(0xFFF6A00C);
const backgroundStartColor = Color(0xFFFFD500);
const backgroundEndColor = Color(0xFFF6A00C);

class TopBar extends StatelessWidget {
  Future<void> writeToFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File(appDocPath + "\\exportList.json");
    // Write the file
    file.writeAsString(jsonEncode(data.entries));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 31,
        color: Color.fromARGB(255, 42, 60, 68),
        child: Column(children: [
          WindowTitleBarBox(
              child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ActionMenu(),
            ),
            Expanded(child: MoveWindow()),
            Center(
              child: Text(
                "Time Tracker",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            Expanded(child: MoveWindow()),
            InkWell(
              onTap: () {
                writeToFile();
              },
              child: Text(
                "Save List",
                style: TextStyle(color: Colors.white),
              ),
            ),
            WindowButtons()
          ])),
        ]));
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: Colors.white,
    mouseOver: Color.fromARGB(255, 62, 213, 152),
    mouseDown: Color(0xFF805306),
    iconMouseOver: Colors.white,
    iconMouseDown: Color(0xFFFFD500));
final closeButtonColors = WindowButtonColors(
    mouseOver: Color.fromARGB(255, 255, 70, 79),
    mouseDown: Color(0xFFB71C1C),
    iconNormal: Colors.white,
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
