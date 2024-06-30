import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workspaces/domain/use_cases/add_workspace_use_case.dart';
import 'package:flutter_workspaces/domain/use_cases/get_all_workspaces_use_case.dart';
import 'package:flutter_workspaces/domain/use_cases/save_state_use_case.dart';
import 'package:flutter_workspaces/presentation/pages/workspace_page/bloc/work_space_page_event.dart';
import 'package:flutter_workspaces/presentation/pages/workspace_page/bloc/work_space_page_state.dart';

class WorkSpacePageBloc extends Bloc<WorkSpacePageEvent, WorkSpacePageState> {
  final GetAllWorkSpacesUseCase _getAllWorkSpacesUseCase;
  final AddWorkSpaceUseCase _addWorkSpaceUseCase;
  final SaveStateUseCase _saveStateUseCase;

  WorkSpacePageBloc({
    required GetAllWorkSpacesUseCase getAllWorkSpacesUseCase,
    required AddWorkSpaceUseCase addWorkSpaceUseCase,
    required SaveStateUseCase saveStateUseCase,
  })  : _addWorkSpaceUseCase = addWorkSpaceUseCase,
        _saveStateUseCase = saveStateUseCase,
        _getAllWorkSpacesUseCase = getAllWorkSpacesUseCase,
        super(WorkSpacePageState.initial()) {
    on<GetAllWorkSpacesEvent>(_getAllWorkSpaces);
    add(GetAllWorkSpacesEvent());
    on<AddWorkSpaceEvent>(_addWorkSpace);
    on<SaveStateEvent>(_saveStateEvent);
    // on<CountRate>(_countRate);
    // on<OnChangeFromTo>(_onChangeFromTo);
  }

  void _getAllWorkSpaces(GetAllWorkSpacesEvent event, Emitter<WorkSpacePageState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(Duration(seconds: 5), () {
      print("This is printed after 5 seconds.");
    });

    print('This is printed when Timer ends');
    final workSpaces = await _getAllWorkSpacesUseCase.call();
    emit(state.copyWith(workSpaces: workSpaces, isLoading: false));
  }

  void _addWorkSpace(AddWorkSpaceEvent event, Emitter<WorkSpacePageState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _addWorkSpaceUseCase.call(event.workSpace);
    final workSpaces = await _getAllWorkSpacesUseCase.call();
    emit(state.copyWith(isLoading: false, workSpaces: workSpaces));
  }

  void _saveStateEvent(SaveStateEvent event, Emitter<WorkSpacePageState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _saveStateUseCase.call(event.workSpaces);
    final workSpaces = await _getAllWorkSpacesUseCase.call();
    emit(state.copyWith(isLoading: false, workSpaces: workSpaces));
  }

  // void _saveChoosenCurrency(SaveChoosenCurrency event, Emitter<WorkSpacePageState> emit) {
  //   final String currency = event.shortName;
  //   final bool isCurrencyEmpty = currency.isEmpty;

  //   if (event.type == AdressType.from) {
  //     emit(state.copyWith(
  //       fromCurrencyChoosen: currency,
  //       toAmmount: isCurrencyEmpty ? 0.0 : state.toAmmount,
  //       toCurrencyChoosen: isCurrencyEmpty ? '' : state.toCurrencyChoosen,
  //     ));
  //   } else if (event.type == AdressType.to) {
  //     emit(state.copyWith(
  //       toCurrencyChoosen: currency,
  //       toAmmount: isCurrencyEmpty ? 0.0 : state.toAmmount,
  //     ));
  //   }
  // }

  // void _countRate(CountRate event, Emitter<ConverterScreenState> emit) async {
  //   if (event.ammount <= 0 || state.fromCurrencyChoosen.isEmpty == true || state.toCurrencyChoosen.isEmpty == true) {
  //     emit(state.copyWith(toAmmount: 0));
  //     return;
  //   }

  //   emit(state.copyWith(isLoading: true));
  //   UseCaseResult result = await getCurrentRateBaseUseCase.call(
  //       amount: event.ammount, currencyFrom: state.fromCurrencyChoosen, currencyTo: state.toCurrencyChoosen);

  //   if (result.isSuccesful) {
  //     emit(state.copyWith(toAmmount: result.value, isLoading: false));
  //   } else {
  //     emit(state.copyWith(isError: true, isLoading: false));
  //   }
  // }

  // void _onChangeFromTo(OnChangeFromTo event, Emitter<ConverterScreenState> emit) {
  //   emit(state.copyWith(
  //     isError: false,
  //     fromCurrencyChoosen: state.toCurrencyChoosen,
  //     toCurrencyChoosen: state.fromCurrencyChoosen,
  //   ));
  // }
}
