import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';

abstract interface class Repository {
  Future<void> saveWorkSpace(WorkSpaceEntity workspaceEntity);
  Future<void> removeWorkSpace(WorkSpaceEntity workspaceEntity);
  Future<List<WorkSpaceEntity>> searchWorkSpace(String querry);
  Future<List<WorkSpaceEntity>> getWorkSpaces();
  Future<void> saveState(List<WorkSpaceEntity> workSpaces);
}
