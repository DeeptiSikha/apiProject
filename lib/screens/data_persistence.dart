import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataPersistenceEx extends StatefulWidget {
  @override
  _DataPersistenceEx createState() => _DataPersistenceEx();
}

class _DataPersistenceEx extends State<DataPersistenceEx> {
  String _name = '';

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
    });
  }

  Future<void> _saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = name;
    });
    await prefs.setString('name', name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Persistence in Flutter'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hello $_name!'),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your name',
            ),
            onSubmitted: (String value) {
              _saveName(value);
            },
          ),
        ],
      ),
    );
  }
}