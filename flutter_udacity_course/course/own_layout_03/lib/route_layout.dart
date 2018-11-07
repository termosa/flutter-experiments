import 'package:flutter/material.dart';

class RouteLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget action;
  final GlobalKey<ScaffoldKey> _scaffoldKey;
  const Color backgroundColor = Colors.white;
  const Color textColor = Colors.black;

  RouteLayout({Key key, this.title, this.child, this.action})
      : _scaffoldKey = GlobalKey<ScaffoldKey>()
      : super(key: key) {
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 30.0,
            ),
          ),
          backgroundColor: backgroundColor,
          elevation: 0.0,
        ),
        body: Container(
          child: child,
        ),
        floatingActionButton: action,
      ),
    );
  }
}
