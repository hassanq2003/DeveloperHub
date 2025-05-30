import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart" show SharedPreferences;

void main() => runApp(MaterialApp(home: CounterPage()));

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    loadCounter();
  }

  void loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => counter = prefs.getInt('counter') ?? 0);
  }

  void updateCounter(int value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => counter = value);
    await prefs.setInt('counter', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Persistent Counter")),
      body: Center(
        child: Text("Counter: $counter", style: TextStyle(fontSize: 32)),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => updateCounter(counter + 1),
            child: Icon(Icons.add),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => updateCounter(counter - 1),
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
