import 'package:flutter/material.dart';
import 'package:todo_app/todoApp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoApp()); //   return MaterialApp(
  }
}
