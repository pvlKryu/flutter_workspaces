import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';
import 'package:flutter_workspaces/domain/repository/repository.dart';

final class SaveStateUseCase {
  final Repository _repository;

  const SaveStateUseCase({required Repository repository}) : _repository = repository;

  Future<void> call(Set<WorkSpaceEntity> workSpaces) async {
    try {
      return await _repository.saveState(workSpaces);
    } catch (e) {
      throw const FormatException('Что-то пошло не так при сохранении стейта списка пространств');
    }
  }
}
