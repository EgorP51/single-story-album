import 'package:flutter/material.dart';
import 'package:single_story_album/album/constructor/constructor_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const ConstructorPage(),
    );
  }
}
