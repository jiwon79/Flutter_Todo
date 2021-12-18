import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Todo List', home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _todoItems = [];

  void _addtodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(task);
      });
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mark "${_todoItems[index]}" as done?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('CANCEL')
            ),
            TextButton(
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop();
              },
              child: Text('MARK AS DONE')
            ),
          ]
        );
      }
    );
  }


  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        print(index);
        return _buildTodoItem(_todoItems[index], index);
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return ListTile(
      title: Text(todoText),
      onTap: () => _promptRemoveTodoItem(index)
    );
  }

  void _pushAddToScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Add a new task'),
          ),
          body: TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addtodoItem(val);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: EdgeInsets.all(16)),
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddToScreen,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}
