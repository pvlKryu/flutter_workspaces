import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';

abstract interface class Repository {
  Future<void> saveWorkSpace(WorkSpaceEntity workspaceEntity);
  Future<void> removeWorkSpace(WorkSpaceEntity workspaceEntity);
  Future<void> searchWorkSpace(String querry);
  Future<void> updateWorkSpace(WorkSpaceEntity oldWorkspaceEntity, WorkSpaceEntity newWorkspaceEntity);
  Future<Set<WorkSpaceEntity>> getWorkSpaces();
  Future<void> saveState(Set<WorkSpaceEntity> workSpaces);
}
