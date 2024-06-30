import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future<Map<String, dynamic>?> showAddWorkspaceDialog(BuildContext context) async {
  TextEditingController nameController = TextEditingController();
  Color pickerColor = Colors.blue;
  final _formKey = GlobalKey<FormState>();

  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Добавить рабочее пространство'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Заголовок'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста введите заголовок';
                  }
                  return null;
                },
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
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pop({'title': nameController.text, 'color': pickerColor});
              }
            },
          ),
        ],
      );
    },
  );
}
