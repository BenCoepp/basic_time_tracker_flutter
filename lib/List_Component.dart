// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_null_comparison, unused_local_variable, unnecessary_new, prefer_final_fields

import 'dart:async';
import 'dart:convert';

import 'package:basic_time_tracker_flutter/Item.dart';
import 'package:flutter/material.dart';
import 'data.dart' as data;
import 'package:shared_preferences/shared_preferences.dart';

class ListComponent extends StatefulWidget {
  const ListComponent({Key? key}) : super(key: key);
  static const routeName = '/list';
  @override
  State<ListComponent> createState() => ListComponentState();
}

class ListComponentState extends State<ListComponent> {
  @override
  void initState() {
    super.initState();
    Timer timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
      setState(() {});
    });
    getFromLocalStorage();
  }

  Future<void> getFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tempJSON = jsonDecode(prefs.getString('items').toString()) as List;
    data.entries = tempJSON.map((tagJson) => Item.fromJson(tagJson)).toList();
  }

  Future<void> saveToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("items", jsonEncode(data.entries));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),
            itemCount: data.entries.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Text(data.entries[index].date),
                title: Text(data.entries[index].day),
                trailing: Text(data.entries[index].time.toString()),
                onLongPress: () {
                  setState(() {
                    data.entries.removeAt(index);
                    saveToLocalStorage();
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
