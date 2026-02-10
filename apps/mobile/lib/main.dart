import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mobile/Tasks/task_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for Flutter
  await Hive.initFlutter();
  Hive.registerAdapter(TodoItemAdapter());

  // Open a box (like a table)
  await Hive.openBox<TaskItem>('taskBox');

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final TextEditingController controller = TextEditingController();
  final List<String> tasks = [];

  late Box<TaskItem>? box;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    box = await Hive.openBox<TaskItem>('todoBox'); // open here
    setState(() {}); // trigger rebuild
  }

  @override
  Widget build(BuildContext context) {
    if (box == null) return const CircularProgressIndicator();

    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('TManager')),
        resizeToAvoidBottomInset: true, // ensures body resizes
        body: Column(
          children: [
            // Task list takes remaining space
            Expanded(
              child: ListView(
                children: box!.values
                    .map(
                      (item) => ListTile(
                        title: Text(item.title),
                        trailing: Checkbox(
                          value: item.isDone,
                          onChanged: (value) {
                            item.isDone = value!;
                            item.save();
                            setState(() {});
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
              // ValueListenableBuilder(
              //   valueListenable: box.listenable(),
              //   builder: (context, Box<TaskItem> box, _) {
              //     return ListView.builder(
              //       itemCount: box.length,
              //       itemBuilder: (context, index) {
              //         final task = box.getAt(index)!;

              //         return CheckboxListTile(
              //           title: Text(task.title),
              //           value: task.isDone,
              //           onChanged: (value) {
              //             task.isDone = value ?? false;
              //             task.save(); // persist change
              //           },
              //         );
              //       },
              //     );
              //   },
              // ),
              // ListView.builder(
              //   padding: EdgeInsets.all(8),
              //   itemCount: tasks.length,
              //   itemBuilder: (context, index) {
              //     return Card(
              //       margin: EdgeInsets.symmetric(vertical: 4),
              //       child: TaskItem(task: tasks[index]),
              //     );
              //   },
              // ),
            ),

            // Input field at the bottom
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: "Add a Task...",
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (value) {
                          if (value.isEmpty) return;
                          setState(() {
                            box?.add(TaskItem(title: value));
                            controller.clear();
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (controller.text.isEmpty) return;
                        setState(() {
                          tasks.add(controller.text);
                          controller.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
