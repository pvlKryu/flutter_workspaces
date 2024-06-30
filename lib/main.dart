import 'package:flutter/material.dart';
import 'package:flutter_workspaces/app.dart';
import 'package:flutter_workspaces/di/di.dart';

void main() {
  BaseDi baseDi = BaseDi();
  baseDi.setUp();
  runApp(const MyApp());
}
