import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';
import 'package:flutter_workspaces/domain/repository/repository.dart';

final class AddWorkSpaceUseCase {
  final Repository _repository;

  const AddWorkSpaceUseCase({required Repository repository}) : _repository = repository;

  Future<void> call(WorkSpaceEntity workSpace) async {
    try {
      return await _repository.saveWorkSpace(workSpace);
    } catch (e) {
      throw const FormatException('Что-то пошло не так при добавлении пространства');
    }
  }
}
