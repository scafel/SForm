import 'package:flutter/material.dart';

import 'basic.dart';
import 'dynamic.dart';

void main() {
  print("load success");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("load success");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    print("load success");
    return Scaffold(
      appBar: AppBar(
        title: const Text("示例"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("基本使用"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SFormPage(),
                ),
              );
            },
          ),
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          ListTile(
            title: const Text("动态表单"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DynamicSFormPage(),
                ),
              );
            },
          ),
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
