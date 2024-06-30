import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workspaces/domain/use_cases/add_workspace_use_case.dart';
import 'package:flutter_workspaces/domain/use_cases/get_all_workspaces_use_case.dart';
import 'package:flutter_workspaces/domain/use_cases/remove_workspace_usecase.dart';
import 'package:flutter_workspaces/domain/use_cases/save_state_use_case.dart';
import 'package:flutter_workspaces/domain/use_cases/search_workspace_use_case.dart';
import 'package:flutter_workspaces/presentation/pages/workspace_page/bloc/work_space_page_event.dart';
import 'package:flutter_workspaces/presentation/pages/workspace_page/bloc/work_space_page_state.dart';

class WorkSpacePageBloc extends Bloc<WorkSpacePageEvent, WorkSpacePageState> {
  final GetAllWorkSpacesUseCase _getAllWorkSpacesUseCase;
  final AddWorkSpaceUseCase _addWorkSpaceUseCase;
  final SaveStateUseCase _saveStateUseCase;
  final RemoveWorkSpaceUseCase _removeWorkSpaceUseCase;
  final SearchWorkSpacesUseCase _searchWorkSpacesUseCase;

  WorkSpacePageBloc({
    required GetAllWorkSpacesUseCase getAllWorkSpacesUseCase,
    required AddWorkSpaceUseCase addWorkSpaceUseCase,
    required SaveStateUseCase saveStateUseCase,
    required RemoveWorkSpaceUseCase removeWorkSpaceUseCase,
    required SearchWorkSpacesUseCase searchWorkSpacesUseCase,
  })  : _addWorkSpaceUseCase = addWorkSpaceUseCase,
        _removeWorkSpaceUseCase = removeWorkSpaceUseCase,
        _searchWorkSpacesUseCase = searchWorkSpacesUseCase,
        _saveStateUseCase = saveStateUseCase,
        _getAllWorkSpacesUseCase = getAllWorkSpacesUseCase,
        super(WorkSpacePageState.initial()) {
    on<GetAllWorkSpacesEvent>(_getAllWorkSpaces);
    add(GetAllWorkSpacesEvent());
    on<AddWorkSpaceEvent>(_addWorkSpace);
    on<SaveStateEvent>(_saveStateEvent);
    on<RemoveWorkSpaceEvent>(_removeWorkSpaceEvent);
    on<SearchWorkSpaceEvent>(_searchWorkSpaceEvent);
  }

  void _getAllWorkSpaces(GetAllWorkSpacesEvent event, Emitter<WorkSpacePageState> emit) async {
    emit(state.copyWith(isLoading: true));
    final workSpaces = await _getAllWorkSpacesUseCase.call();
    emit(state.copyWith(workSpaces: workSpaces, isLoading: false));
  }

  void _addWorkSpace(AddWorkSpaceEvent event, Emitter<WorkSpacePageState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _addWorkSpaceUseCase.call(event.workSpace);
    final workSpaces = await _getAllWorkSpacesUseCase.call();
    emit(state.copyWith(isLoading: false, workSpaces: workSpaces));
  }

  void _removeWorkSpaceEvent(RemoveWorkSpaceEvent event, Emitter<WorkSpacePageState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _removeWorkSpaceUseCase.call(event.workSpace);
    final workSpaces = await _getAllWorkSpacesUseCase.call();
    emit(state.copyWith(isLoading: false, workSpaces: workSpaces));
  }

  void _saveStateEvent(SaveStateEvent event, Emitter<WorkSpacePageState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _saveStateUseCase.call(event.workSpaces);
    final workSpaces = await _getAllWorkSpacesUseCase.call();
    emit(state.copyWith(isLoading: false, workSpaces: workSpaces));
  }

  void _searchWorkSpaceEvent(SearchWorkSpaceEvent event, Emitter<WorkSpacePageState> emit) async {
    emit(state.copyWith(isLoading: true));

    final workSpaces = await _searchWorkSpacesUseCase.call(event.querry);
    emit(state.copyWith(workSpaces: workSpaces, isLoading: false));
  }
}
