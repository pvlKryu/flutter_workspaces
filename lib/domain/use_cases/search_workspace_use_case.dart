import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';
import 'package:flutter_workspaces/domain/repository/repository.dart';

final class SearchWorkSpacesUseCase {
  final Repository _repository;

  const SearchWorkSpacesUseCase({required Repository repository}) : _repository = repository;

  Future<List<WorkSpaceEntity>> call(String querry) async {
    try {
      return await _repository.searchWorkSpace(querry);
    } catch (e) {
      throw const FormatException('Что-то пошло не так при поиске списка пространств');
    }
  }
}
