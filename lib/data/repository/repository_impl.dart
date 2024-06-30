import 'package:flutter_workspaces/data/dto/workspace_dto.dart';
import 'package:flutter_workspaces/data/local_data_source/local_data_source.dart';
import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';
import 'package:flutter_workspaces/domain/repository/repository.dart';

final class RepositoryImpl implements Repository {
  final LocalDataSource _localDataSource;

  RepositoryImpl({required LocalDataSource localDataSource}) : _localDataSource = localDataSource;

  @override
  Future<Set<WorkSpaceEntity>> getWorkSpaces() async {
    final workSpacesDtoSet = await _localDataSource.getWorkSpace();
    final entitySet = workSpacesDtoSet.map((workspace) {
      return WorkSpaceEntity(title: workspace.title, color: workspace.color);
    }).toSet();
    return entitySet;
  }

  @override
  Future<void> removeWorkSpace(WorkSpaceEntity workspaceEntity) async {}

  @override
  Future<void> saveWorkSpace(WorkSpaceEntity workspaceEntity) async {
    await _localDataSource.saveWorkSpace(WorkSpaceDto(title: workspaceEntity.title, color: workspaceEntity.color));
  }

  @override
  Future<void> searchWorkSpace(String querry) {
    // TODO: implement searchWorkSpace
    throw UnimplementedError();
  }

  @override
  Future<void> updateWorkSpace(WorkSpaceEntity oldWorkspaceEntity, WorkSpaceEntity newWorkspaceEntity) {
    // TODO: implement updateWorkSpace
    throw UnimplementedError();
  }

  @override
  Future<void> saveState(Set<WorkSpaceEntity> workSpaces) async {
    final dtoSet = workSpaces.map((workspace) {
      return WorkSpaceDto(title: workspace.title, color: workspace.color);
    }).toSet();
    await _localDataSource.saveState(dtoSet);
  }
}
