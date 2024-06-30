import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future<Map<String, dynamic>?> showAddWorkspaceDialog(BuildContext context) async {
  TextEditingController nameController = TextEditingController();
  Color pickerColor = Colors.blue;

  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Добавить рабочее пространство'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            const SizedBox(height: 20),
            const Text('Выберите цвет'),
            const SizedBox(height: 10),
            BlockPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                pickerColor = color;
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Отменить'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Добавить'),
            onPressed: () {
              Navigator.of(context).pop({'title': nameController.text, 'color': pickerColor});
            },
          ),
        ],
      );
    },
  );
}
