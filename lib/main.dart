import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _todos = []; // List for pending tasks
  final List<String> _dones = []; // List for completed tasks

  String _newTodo = ""; // String to hold new task text

  void _addTodo() {
    setState(() {
      _todos.add(_newTodo);
      _newTodo = "";
    });
  }

  void _markDone(int index) {
    setState(() {
      final task = _todos[index];
      _todos.removeAt(index);
      _dones.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Piistech To-Do List"),
      ),
      body: Column(
        children: [
          // Input field for new tasks
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Add a new task",
              ),
              onChanged: (text) {
                setState(() {
                  _newTodo = text;
                });
              },
              onSubmitted: (text) => _addTodo(),
            ),
          ),
          // Pending tasks section
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: false,
                    onChanged: (value) => _markDone(index),
                  ),
                  title: Text(_todos[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _todos.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // Divider
          Divider(),
          // Done tasks section (optional)
          Text("Done tasks"),
          Expanded(
            child: ListView.builder(
              itemCount: _dones.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_dones[index]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: Icon(Icons.add),
      ),
    );
  }
}
