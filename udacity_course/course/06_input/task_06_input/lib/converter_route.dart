// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'unit.dart';
import 'formatters.dart';

const _padding = EdgeInsets.all(16.0);

/// [ConverterRoute] where users can input amounts to convert in one [Unit]
/// and retrieve the conversion in another [Unit] for a specific [Category].
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class ConverterRoute extends StatefulWidget {
  /// This [Category]'s name.
  final String name;

  /// Color for this [Category].
  final Color color;

  /// Units for this [Category].
  final List<Unit> units;

  /// This [ConverterRoute] requires the name, color, and units to not be null.
  const ConverterRoute({
    @required this.name,
    @required this.color,
    @required this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}

class _ConverterRouteState extends State<ConverterRoute> {
  // Set some variables, such as for keeping track of the user's input
  // value and units
  double _inputValue;
  Unit inputUnit, outputUnit;

  final Widget compareIcon = Center(
    child: Transform(
      child: Icon(Icons.compare_arrows),
      transform: Matrix4.rotationX(20),
    ),
  );

  // Determine whether you need to override anything, such as initState()
  @override
  initState() {
    super.initState();
    inputUnit = widget.units[0];
    outputUnit = widget.units[1];
  }

  // Add other helper functions. We've given you one, _format()

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  @override
  Widget build(BuildContext context) {
    // Create the 'input' group of widgets. This is a Column that
    // includes the input value, and 'from' unit [Dropdown].
    List<DropdownMenuItem<Unit>> unitsList = widget.units.map((unit) {
      return DropdownMenuItem(
        value: unit,
        child: Text(unit.name),
      );
    }).toList();

    Widget input = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          maxLines: 1,
          maxLength: 14,
          inputFormatters: [
            DecimalTextFormatter(),
          ],
          keyboardType: TextInputType.numberWithOptions(),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Input',
            labelStyle: TextStyle(fontSize: 22.0),
          ),
          onChanged: (String input) {
            setState(() {
              _inputValue = double.parse(input);
            });
          },
        ),
        DropdownButton<Unit>(
          isExpanded: true,
          value: inputUnit,
          items: unitsList,
          onChanged: (unit) {
            setState(() {
              inputUnit = unit;
            });
          },
        ),
      ],
    );

    // Create a compare arrows icon.
    Widget compareIcon = Center(
      child: Padding(
        padding: _padding,
        child: RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.compare_arrows,
            size: 40.0,
          ),
        ),
      ),
    );

    // Create the 'output' group of widgets. This is a Column that
    double outputValue = _inputValue == null
      ? 0
      : _inputValue / inputUnit.conversion * outputUnit.conversion;
    Widget output = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: _padding,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: new BorderRadius.circular(4),
          ),
          child: Text(_format(outputValue)),
        ),
        DropdownButton<Unit>(
          isExpanded: true,
          value: outputUnit,
          items: unitsList,
          onChanged: (unit) {
            setState(() {
              outputUnit = unit;
            });
          },
        ),
      ],
    );

    // Return the input, arrows, and output widgets, wrapped in a Column.
    return Container(
      padding: _padding,
      child: Column(
        children: [
          input,
          compareIcon,
          output,
        ],
      ),
    );
  }
}
