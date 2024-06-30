import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'workspace_dto.g.dart';

@JsonSerializable()
class WorkSpaceDto {
  final String title;
  @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
  final Color color;

  const WorkSpaceDto({required this.title, required this.color});

  factory WorkSpaceDto.fromJson(Map<String, dynamic> json) => _$WorkSpaceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WorkSpaceDtoToJson(this);

  static Color _colorFromJson(int colorValue) => Color(colorValue);

  static int _colorToJson(Color color) => color.value;
}
