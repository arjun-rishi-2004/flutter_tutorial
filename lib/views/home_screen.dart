import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_modal/todoviewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  const HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final todovm = Provider.of<Todoviewmodel>(context,listen: false);
    todovm.setTodoFromLocal();

  }
  @override
  Widget build(BuildContext context) {
    final todovm1 = Provider.of<Todoviewmodel>(context,listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Logged in successfully !"),
            // Text('Email:${widget.email} ${todovm.name} ${todovm.password}'),
            Consumer<Todoviewmodel>(
              builder: (context, todovm, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: todovm.todolist.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: IconButton(
                        onPressed: () {
                          todovm.deleteTask(index);
                        },
                        icon: Icon(Icons.delete),
                      ),
                      title: Text(todovm.todolist[index]["task_name"]),
                    );
                  },
                );
              },
            ),
            Text("Logged in successfully !"),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: (){
        todovm1.addTask();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      )
    );

  }
}
