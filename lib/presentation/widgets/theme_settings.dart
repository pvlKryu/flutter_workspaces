import 'package:flutter/material.dart';
import 'package:flutter_workspaces/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void showThemeDialog(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Выберите тему'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('Системная'),
              value: ThemeMode.system,
              groupValue: themeProvider.themeMode,
              onChanged: (value) {
                themeProvider.setTheme(value ?? ThemeMode.system);
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Светлая'),
              value: ThemeMode.light,
              groupValue: themeProvider.themeMode,
              onChanged: (value) {
                themeProvider.setTheme(value ?? ThemeMode.system);
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Темная'),
              value: ThemeMode.dark,
              groupValue: themeProvider.themeMode,
              onChanged: (value) {
                themeProvider.setTheme(value ?? ThemeMode.system);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
