import 'package:flutter/material.dart';
import './ui/home_screen.dart';

void  main() {
  runApp(const TodoApp());
}
class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do List',
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: const HomeScreen()
    );
  }
}



