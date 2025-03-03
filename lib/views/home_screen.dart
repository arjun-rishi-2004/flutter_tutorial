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
    final todovm = Provider.of<Todoviewmodel>(context, listen: false);
    todovm.setTodoFromLocal();
  }

  void showAddTaskForm(BuildContext build) {
    const List<String> statuses = <String>['Pending', 'InProgress', 'Completed'];

    final TextEditingController taskNameController = TextEditingController();
  String dropdownValue = statuses.first;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: 
        
        (context,setState){
          return   AlertDialog(
          title: const Text('ADD TASK'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    controller: taskNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your task',
                    ),
                  ),
                  // TextField(controller: passwordController,decoration: InputDecoration(labelText: 'Password'),),
                ),
DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(height: 2, color: Colors.deepPurpleAccent),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items:
          statuses.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value,style: TextStyle(color: Colors.black),));
          }).toList(),
    ),
                Text('Are you sure?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                final todovm =
                Provider.of<Todoviewmodel>(context, listen: false);
                todovm.addTask(
                        taskNameController.text, dropdownValue);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      
        }
        
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todovm = Provider.of<Todoviewmodel>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text("Logged in successfully !"),
            Text('Welcome ${widget.email}',style: TextStyle(fontSize: 20.0)),

            Consumer<Todoviewmodel>(
              builder: (context, todovm, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: todovm.todolist.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Card(
                        color: Colors.blue,
elevation: 5, // Adds shadow effect
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
                      child:ListTile(
                      
                      tileColor: const Color.fromARGB(255, 49, 206, 193),
                      trailing: IconButton(
                        onPressed: () {
                          todovm.deleteTask(index);
                        },
                        icon: Icon(Icons.delete),
                      ),
                      title: Text(todovm.todolist[index]["task_name"]
                      ,style: TextStyle(
                        fontSize: 20
                      ),),
                      subtitle: Text(todovm.todolist[index]["status"]),
                    ) ,
                    );
                    
                  },
                );
              },
            ),
            // Text("Logged in successfully !"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskForm(context);
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
