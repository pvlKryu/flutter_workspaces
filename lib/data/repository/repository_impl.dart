import 'package:flutter_workspaces/data/dto/workspace_dto.dart';
import 'package:flutter_workspaces/data/local_data_source/local_data_source.dart';
import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';
import 'package:flutter_workspaces/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final LocalDataSource _localDataSource;

  RepositoryImpl({required LocalDataSource localDataSource}) : _localDataSource = localDataSource;

  @override
  Future<List<WorkSpaceEntity>> getWorkSpaces() async {
    final workSpacesDtoList = await _localDataSource.getWorkSpace();
    return workSpacesDtoList.map((workspace) => workspace.toEntity()).toList();
  }

  @override
  Future<void> removeWorkSpace(WorkSpaceEntity workspaceEntity) async {
    await _localDataSource.removeWorkSpace(WorkSpaceDto.fromEntity(workspaceEntity));
  }

  @override
  Future<void> saveWorkSpace(WorkSpaceEntity workspaceEntity) async {
    await _localDataSource.saveWorkSpace(WorkSpaceDto.fromEntity(workspaceEntity));
  }

  @override
  Future<List<WorkSpaceEntity>> searchWorkSpace(String query) async {
    final searchedDto = await _localDataSource.searchWorkSpace(query);
    return searchedDto.map((workspace) => workspace.toEntity()).toList();
  }

  @override
  Future<void> saveState(List<WorkSpaceEntity> workSpaces) async {
    final dtoList = workSpaces.map((workspace) => WorkSpaceDto.fromEntity(workspace)).toList();
    await _localDataSource.saveState(dtoList);
  }
}
