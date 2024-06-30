import 'package:flutter_workspaces/data/local_data_source/local_data_source.dart';
import 'package:flutter_workspaces/data/repository/repository_impl.dart';
import 'package:flutter_workspaces/domain/repository/repository.dart';
import 'package:flutter_workspaces/domain/use_cases/add_workspace_use_case.dart';
import 'package:flutter_workspaces/domain/use_cases/get_all_workspaces_use_case.dart';
import 'package:flutter_workspaces/domain/use_cases/remove_workspace_usecase.dart';
import 'package:flutter_workspaces/domain/use_cases/save_state_use_case.dart';
import 'package:flutter_workspaces/domain/use_cases/search_workspace_use_case.dart';
import 'package:get_it/get_it.dart';

class BaseDi {
  final GetIt getIt = GetIt.instance;

  void setUp() {
    getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
    getIt.registerLazySingleton<Repository>(() => RepositoryImpl(localDataSource: getIt.get()));
    getIt.registerFactory<GetAllWorkSpacesUseCase>(() => GetAllWorkSpacesUseCase(repository: getIt.get()));
    getIt.registerFactory<AddWorkSpaceUseCase>(() => AddWorkSpaceUseCase(repository: getIt.get()));
    getIt.registerFactory<SaveStateUseCase>(() => SaveStateUseCase(repository: getIt.get()));
    getIt.registerFactory<RemoveWorkSpaceUseCase>(() => RemoveWorkSpaceUseCase(repository: getIt.get()));
    getIt.registerFactory<SearchWorkSpacesUseCase>(() => SearchWorkSpacesUseCase(repository: getIt.get()));
  }
}
