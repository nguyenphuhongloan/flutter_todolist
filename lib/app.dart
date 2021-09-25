
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoapp/src/screens/home_screen.dart';
import 'package:todoapp/src/screens/login_screen.dart';
import 'package:todoapp/src/screens/register_screen.dart';

class App extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AppState();
}
class _AppState extends State <App>{
  Widget build(BuildContext context){
    return FirebaseAuth.instance.currentUser != null ? HomeScreen() : LoginScreen();
  }
}


