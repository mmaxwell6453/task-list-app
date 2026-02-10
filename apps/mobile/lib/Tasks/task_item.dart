// import 'package:flutter/material.dart';
// import 'package:mobile/Tasks/task_item_check_box.dart';

import 'package:hive/hive.dart';

part 'task_item.g.dart';

@HiveType(typeId: 0)
class TaskItem extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isDone;

  TaskItem({required this.title, this.isDone = false});
}

// class TaskItem extends StatefulWidget {
//   final String task;
//   const TaskItem({required this.task, super.key});

//   @override
//   State<TaskItem> createState() => _TaskItemState();
// }

// class _TaskItemState extends State<TaskItem> {
//   bool isChecked = false;

//   void handleCheckboxChanged(bool newValue) {
//     setState(() {
//       isChecked = newValue; // update parent state
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: TaskCheckBox(
//         isChecked: isChecked,
//         onChanged: handleCheckboxChanged,
//       ),
//       title: Text(
//         widget.task,
//         style: TextStyle(
//           color: Colors.purple[300],
//           decoration: isChecked ? TextDecoration.lineThrough : null,
//         ),
//       ),
//     );
//   }
// }
