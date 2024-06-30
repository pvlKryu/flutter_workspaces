import 'package:equatable/equatable.dart';
import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';

class WorkSpacePageState extends Equatable {
  final List<WorkSpaceEntity> workSpaces;
  final bool isLoading;
  final String fromCurrencyChoosen;
  final String toCurrencyChoosen;
  final double? fromAmmount;
  final double? toAmmount;

  const WorkSpacePageState._({
    required this.workSpaces,
    this.isLoading = true,
    this.fromAmmount,
    this.toAmmount,
    this.fromCurrencyChoosen = '',
    this.toCurrencyChoosen = '',
  });

  factory WorkSpacePageState.initial() {
    return const WorkSpacePageState._(workSpaces: []);
  }

  WorkSpacePageState copyWith({
    List<WorkSpaceEntity>? workSpaces,
    bool? isLoading,
    String? fromCurrencyChoosen,
    String? toCurrencyChoosen,
    double? fromAmmount,
    double? toAmmount,
  }) {
    return WorkSpacePageState._(
      workSpaces: workSpaces ?? this.workSpaces,
      isLoading: isLoading ?? this.isLoading,
      fromCurrencyChoosen: fromCurrencyChoosen ?? this.fromCurrencyChoosen,
      toCurrencyChoosen: toCurrencyChoosen ?? this.toCurrencyChoosen,
      fromAmmount: fromAmmount ?? this.fromAmmount,
      toAmmount: toAmmount ?? this.toAmmount,
    );
  }

  @override
  List<Object?> get props => [workSpaces, isLoading, fromCurrencyChoosen, toCurrencyChoosen, fromAmmount, toAmmount];
}
