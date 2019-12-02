// Copyright 2019 Xiaoheng Liu. All rights reserved.
// Use of this source code is governed by a the MIT license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:section_list_view/section_list_view/x_section_list_view.dart';

class XSectionListViewExample extends StatefulWidget {
  XSectionListViewExample({Key key}) : super(key: key);

  @override
  _XSectionListViewExampleState createState() =>
      _XSectionListViewExampleState();
}

class _XSectionListViewExampleState extends State<XSectionListViewExample> {
  List<List<String>> dataSources = [];
  @override
  void initState() {
    super.initState();
    var rand = Random();
    for (var i = 0; i < 20; ++i) {
      List<String> sub = [];
      dataSources.add(sub);
      for (var j = 0; j < rand.nextInt(10) + 1; ++j) {
        sub.add("item: $j");
      }
    }
  }

  bool close = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text(close ? "展开" : "收起"),
            onPressed: () {
              setState(() {
                close = !close;
              });
            },
          )
        ],
        title: Text("Section ListView"),
      ),
      body: SafeArea(
        child: Container(
          child: buildList(),
        ),
      ),
    );
  }

  Widget buildList() {
    return XSectionListView(
      numberOfRowsInSection: (section) => dataSources[section].length,
      numbersOfSection: dataSources.length,
      sectionHeaderBuilder: (context, section) {
        return Container(
          height: 50,
          color: Colors.orange,
          child: Row(
            children: <Widget>[
              Text("#${section} section header"),
            ],
          ),
        );
      },
      itemBuilder: (context, indexPath) {
        return Dismissible(
          background: Icon(Icons.check_circle_outline),
          key: Key(
              "$indexPath+${dataSources[indexPath.section][indexPath.item]}"),
          onDismissed: (direction) {
            setState(() {
              dataSources[indexPath.section].removeAt(indexPath.item);
              if (dataSources[indexPath.section].length == 0) {
                dataSources.removeAt(indexPath.section);
              }
            });
          },
          child: GestureDetector(
            onTap: () {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("$indexPath selected"),
                duration: Duration(seconds: 1),
              ));
            },
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Icon(Icons.check_circle_outline),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                      "$indexPath::: ${dataSources[indexPath.section][indexPath.item]}"),
                ],
              ),
            ),
          ),
        );
      },
      sectionFooterBuilder: (context, section) {
        return Container(
            height: 50,
            color: Colors.indigo,
            child: Row(
              children: <Widget>[
                Text("#${section} section footer"),
              ],
            ));
      },
      seperatorBuilder: (context, indexPath) {
        return Divider(
          height: 1,
          color: Colors.black,
          indent: 10,
        );
      },
    );
  }
}
