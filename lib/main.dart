import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localstorage_sample/TypeAdapter/user.dart';

late Box box;

/// Modify main method to async.
void main() async {
  /// Initialize Hive with initFlutter() constructor.
  /// If you use Hive for non-flutter dart, you should use init().
  await Hive.initFlutter();

  /// Create instance box.
  /// box like a database table of Hive.
  box = await Hive.openBox('settings');

  /// Register type adapter.
  Hive.registerAdapter(UserAdapter());

  /// Write value to box
  box.put('user', User(name: 'Tarou', age: 14));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Sample',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Read value from box.
    User user = box.get('user');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello, Hive.'),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
              color: Colors.blueGrey[50],
              shadowColor: Colors.grey,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: EdgeInsets.all(120),
                child: Text(user.name),
              )),
          Text(user.name),
          Text(
            user.age.toString(),
          ),
        ],
      )),
    );
  }
}
