// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// Check if we need to import anything
import 'category.dart';

// Define any constants
const mainColor = Colors.green[200];

/// Category Route (screen).
///
/// This is the 'home' screen of the Unit Converter. It shows a header and
/// a list of [Categories].
///
/// While it is named CategoryRoute, a more apt name would be CategoryScreen,
/// because it is responsible for the UI at the route's destination.
class CategoryRoute extends StatelessWidget {
  const CategoryRoute();

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    // Create a list of the eight Categories, using the names and colors
    // from above. Use a placeholder icon, such as `Icons.cake` for each
    // Category. We'll add custom icons later.

    // Create a list view of the Categories
    final listView = Container(
      decoration: BoxDecoration(color: mainColor),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _categoryNames.length,
          itemBuilder: (BuildContext context, i) {
            return Category(
              name: _categoryNames[i],
              color: _baseColors[i],
              iconLocation: Icons.cake,
            );
          },
        ),
      ),
    );

    // Create an App Bar
    final appBar = AppBar(
      backgroundColor: mainColor,
      title: Text(
        'Unit Converter',
        style: TextStyle(fontSize: 30.0),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}
