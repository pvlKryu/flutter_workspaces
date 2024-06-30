import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_workspaces/data/dto/workspace_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<void> saveWorkSpace(WorkSpaceDto workspace);
  Future<void> removeWorkSpace(WorkSpaceDto workspace);
  Future<Set<WorkSpaceDto>> searchWorkSpace(String title);
  Future<void> updateWorkSpace(WorkSpaceDto workspace);
  Future<Set<WorkSpaceDto>> getWorkSpace();
  Future<void> saveState(Set<WorkSpaceDto> workspaces);
}

class LocalDataSourceImpl implements LocalDataSource {
  static const String _key = 'workspaces';

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _initializeDefaults() async {
    final prefs = await _prefs;
    if (!prefs.containsKey(_key)) {
      final defaultWorkspaces = {
        WorkSpaceDto(title: 'Savva', color: Colors.red),
        WorkSpaceDto(title: 'Olluco', color: Colors.pink),
        WorkSpaceDto(title: 'Loona', color: Colors.purple),
        WorkSpaceDto(title: 'Folk', color: Colors.blue),
        WorkSpaceDto(title: 'White Rabbit', color: Colors.lightBlue),
        WorkSpaceDto(title: 'Sage', color: Colors.green),
        WorkSpaceDto(title: 'Maya', color: Colors.orange),
        WorkSpaceDto(title: 'Jun', color: Colors.deepOrange),
        WorkSpaceDto(title: 'Onest', color: Colors.deepPurple),
        WorkSpaceDto(title: 'Пробка на Цветном', color: Colors.lightBlueAccent),
      };
      await prefs.setString(_key, json.encode(defaultWorkspaces.map((e) => e.toJson()).toList()));
    }
  }

  @override
  Future<void> saveWorkSpace(WorkSpaceDto workspace) async {
    final prefs = await _prefs;
    final workspaces = await getWorkSpace();
    workspaces.add(workspace);
    await prefs.setString(_key, json.encode(workspaces.map((e) => e.toJson()).toList()));
  }

  @override
  Future<void> removeWorkSpace(WorkSpaceDto workspace) async {
    final prefs = await _prefs;
    final workspaces = await getWorkSpace();
    workspaces.removeWhere((item) => item.title == workspace.title);
    await prefs.setString(_key, json.encode(workspaces.map((e) => e.toJson()).toList()));
  }

  @override
  Future<Set<WorkSpaceDto>> searchWorkSpace(String title) async {
    final workspaces = await getWorkSpace();
    return workspaces.where((item) => item.title.toLowerCase().contains(title.toLowerCase())).toSet();
  }

  @override
  Future<void> updateWorkSpace(WorkSpaceDto workspace) async {
    await removeWorkSpace(workspace);
    await saveWorkSpace(workspace);
  }

  @override
  Future<Set<WorkSpaceDto>> getWorkSpace() async {
    await _initializeDefaults();
    final prefs = await _prefs;
    final String? jsonString = prefs.getString(_key);
    if (jsonString != null) {
      final List<dynamic> jsonResponse = json.decode(jsonString);
      return jsonResponse.map((json) => WorkSpaceDto.fromJson(json)).toSet();
    }
    return {};
  }

  @override
  Future<void> saveState(Set<WorkSpaceDto> workspaces) async {
    final prefs = await _prefs;
    await prefs.setString(_key, json.encode(workspaces.map((e) => e.toJson()).toList()));
  }
}
