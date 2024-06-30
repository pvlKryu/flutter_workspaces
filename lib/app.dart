import 'package:flutter/material.dart';
import 'package:flutter_workspaces/presentation/pages/workspace_page/workspace_page_with_lib.dart';
import 'package:flutter_workspaces/presentation/pages/workspace_page_without_lib.dart';
import 'package:flutter_workspaces/presentation/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    /// С использованием сторонней либы
    return MaterialApp(
      themeMode: themeProvider.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const WorkSpacePageWithLib(),
      debugShowCheckedModeBanner: false,
    );

    /// Самописный вариант (функционал по драггу тот же, но без анимации)
    /// здесь только UI
    // return const MaterialApp(
    //   home: WorkSpacePageWithoutLib(),
    //   debugShowCheckedModeBanner: false,
    // );
  }
}
