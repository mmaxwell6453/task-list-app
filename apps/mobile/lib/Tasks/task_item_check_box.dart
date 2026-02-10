import 'package:flutter/material.dart';

class TaskCheckBox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged; // callback

  const TaskCheckBox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (value) {
        onChanged(value!);
      },
      shape: CircleBorder(), // circular checkbox
      side: const BorderSide(color: Colors.purple, width: 2),
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.purple;
        }
        return Colors.black;
      }),
    );
  }
}
