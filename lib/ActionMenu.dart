// ignore_for_file: non_constant_identifier_names, camel_case_types, unnecessary_null_comparison, annotate_overrides, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, use_key_in_widget_constructors
// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '/data.dart' as data;
import 'package:flutter/material.dart';

class ActionMenu extends StatefulWidget {
  ActionMenu_Widget createState() => ActionMenu_Widget();
}

class ActionMenu_Widget extends State<ActionMenu> {
  Future<void> writeToFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File(appDocPath + "\\exportList.json");
    // Write the file
    file.writeAsString(jsonEncode(data.entries));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          cardColor: Color.fromARGB(255, 42, 60, 68),
          dividerTheme: DividerThemeData(color: Colors.white),
          tooltipTheme: TooltipThemeData(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          )),
      child: PopupMenuButton(
        onSelected: (value) {
          if (value == 1) {
            writeToFile();
          }
        },
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text(
            "Actions",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        tooltip: "",
        offset: Offset(0, 28),
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          PopupMenuItem(
            height: 20,
            value: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                children: [
                  Text(
                    "Save List to File",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Spacer(
                    flex: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
