import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';

sealed class WorkSpacePageEvent {}

class GetAllWorkSpacesEvent extends WorkSpacePageEvent {}

class AddWorkSpaceEvent extends WorkSpacePageEvent {
  final WorkSpaceEntity workSpace;

  AddWorkSpaceEvent({required this.workSpace});
}

class SaveStateEvent extends WorkSpacePageEvent {
  final Set<WorkSpaceEntity> workSpaces;

  SaveStateEvent({required this.workSpaces});
}
