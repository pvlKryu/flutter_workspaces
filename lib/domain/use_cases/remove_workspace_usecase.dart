import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';
import 'package:flutter_workspaces/domain/repository/repository.dart';

final class RemoveWorkSpaceUseCase {
  final Repository _repository;

  const RemoveWorkSpaceUseCase({required Repository repository}) : _repository = repository;

  Future<void> call(WorkSpaceEntity workSpace) async {
    try {
      return await _repository.removeWorkSpace(workSpace);
    } catch (e) {
      throw const FormatException('Что-то пошло не так при удалении пространства');
    }
  }
}
