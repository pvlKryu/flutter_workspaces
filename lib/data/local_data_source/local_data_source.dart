import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_workspaces/data/dto/workspace_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<void> saveWorkSpace(WorkSpaceDto workspace);
  Future<void> removeWorkSpace(WorkSpaceDto workspace);
  Future<List<WorkSpaceDto>> searchWorkSpace(String title);
  Future<List<WorkSpaceDto>> getWorkSpace();
  Future<void> saveState(List<WorkSpaceDto> workspaces);
}

class LocalDataSourceImpl implements LocalDataSource {
  static const String _key = 'workspaces';
  SharedPreferences? _prefs;

  Future<SharedPreferences> get _sharedPrefs async {
    if (_prefs != null) {
      return _prefs!;
    }
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> _initializeDefaults() async {
    final prefs = await _sharedPrefs;
    if (!prefs.containsKey(_key)) {
      final defaultWorkspaces = [
        const WorkSpaceDto(title: 'Savva', color: Colors.red),
        const WorkSpaceDto(title: 'Olluco', color: Colors.pink),
        const WorkSpaceDto(title: 'Loona', color: Colors.purple),
        const WorkSpaceDto(title: 'Folk', color: Colors.blue),
        const WorkSpaceDto(title: 'White Rabbit', color: Colors.lightBlue),
        const WorkSpaceDto(title: 'Sage', color: Colors.green),
        const WorkSpaceDto(title: 'Maya', color: Colors.orange),
        const WorkSpaceDto(title: 'Jun', color: Colors.deepOrange),
        const WorkSpaceDto(title: 'Onest', color: Colors.deepPurple),
        const WorkSpaceDto(title: 'Пробка на Цветном', color: Colors.lightBlueAccent),
      ];
      await prefs.setString(_key, json.encode(defaultWorkspaces.map((e) => e.toJson()).toList()));
    }
  }

  @override
  Future<void> saveWorkSpace(WorkSpaceDto workspace) async {
    try {
      final prefs = await _sharedPrefs;
      final workspaces = await getWorkSpace();
      workspaces.add(workspace);
      await prefs.setString(_key, json.encode(workspaces.map((e) => e.toJson()).toList()));
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  @override
  Future<void> removeWorkSpace(WorkSpaceDto workspace) async {
    try {
      final prefs = await _sharedPrefs;
      final workspaces = await getWorkSpace();
      workspaces.removeWhere((item) => item.title == workspace.title);
      await prefs.setString(_key, json.encode(workspaces.map((e) => e.toJson()).toList()));
    } catch (e) {
      // Handle error
      rethrow;
    }
  }

  @override
  Future<List<WorkSpaceDto>> searchWorkSpace(String title) async {
    final workspaces = await getWorkSpace();
    return workspaces.where((item) => item.title.toLowerCase().contains(title.toLowerCase())).toList();
  }

  @override
  Future<List<WorkSpaceDto>> getWorkSpace() async {
    try {
      await _initializeDefaults();
      final prefs = await _sharedPrefs;
      final String? jsonString = prefs.getString(_key);
      if (jsonString != null) {
        final List<dynamic> jsonResponse = json.decode(jsonString);
        return jsonResponse.map((json) => WorkSpaceDto.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      // Handle error
      return [];
    }
  }

  @override
  Future<void> saveState(List<WorkSpaceDto> workspaces) async {
    try {
      final prefs = await _sharedPrefs;
      await prefs.setString(_key, json.encode(workspaces.map((e) => e.toJson()).toList()));
    } catch (e) {
      // Handle error
      rethrow;
    }
  }
}
