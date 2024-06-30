import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';
import 'package:flutter_workspaces/domain/repository/repository.dart';

final class GetAllWorkSpacesUseCase {
  final Repository _repository;

  const GetAllWorkSpacesUseCase({required Repository repository}) : _repository = repository;

  Future<List<WorkSpaceEntity>> call() async {
    try {
      return await _repository.getWorkSpaces();
    } catch (e) {
      throw const FormatException('Что-то пошло не так при получении списка пространств');
    }
  }
}
