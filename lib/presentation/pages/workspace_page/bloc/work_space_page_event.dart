import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';

sealed class WorkSpacePageEvent {}

class GetAllWorkSpacesEvent extends WorkSpacePageEvent {}

class AddWorkSpaceEvent extends WorkSpacePageEvent {
  final WorkSpaceEntity workSpace;

  AddWorkSpaceEvent({required this.workSpace});
}

class RemoveWorkSpaceEvent extends WorkSpacePageEvent {
  final WorkSpaceEntity workSpace;

  RemoveWorkSpaceEvent({required this.workSpace});
}

class SaveStateEvent extends WorkSpacePageEvent {
  final List<WorkSpaceEntity> workSpaces;

  SaveStateEvent({required this.workSpaces});
}

class SearchWorkSpaceEvent extends WorkSpacePageEvent {
  final String querry;

  SearchWorkSpaceEvent({required this.querry});
}
