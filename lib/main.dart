import 'package:flutter/material.dart';
import 'package:flutter_workspaces/app.dart';
import 'package:flutter_workspaces/di/di.dart';
import 'package:flutter_workspaces/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  BaseDi baseDi = BaseDi();
  baseDi.setUp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}
