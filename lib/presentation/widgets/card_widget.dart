import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';
import 'package:flutter_workspaces/presentation/pages/workspace_page/bloc/work_space_page_bloc.dart';
import 'package:flutter_workspaces/presentation/pages/workspace_page/bloc/work_space_page_event.dart';

final class CardWidget extends StatelessWidget {
  final WorkSpaceEntity _workspace;

  const CardWidget({super.key, required WorkSpaceEntity workspace}) : _workspace = workspace;

  @override
  Widget build(BuildContext context) {
    return Card(
      
      color: _workspace.color,
      elevation: 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                icon: const Icon(Icons.delete_forever, color: Colors.white),
                onPressed: () {
                  context.read<WorkSpacePageBloc>().add(
                        RemoveWorkSpaceEvent(
                          workSpace: WorkSpaceEntity(
                            title: _workspace.title,
                            color: _workspace.color,
                          ),
                        ),
                      );
                }),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_workspace.title, style: const TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
