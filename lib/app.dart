import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoapp/src/screens/home_screen.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
