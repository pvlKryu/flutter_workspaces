import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';
import 'package:flutter_workspaces/presentation/pages/workspace_page/bloc/work_space_page_bloc.dart';
import 'package:flutter_workspaces/presentation/pages/workspace_page/bloc/work_space_page_event.dart';
import 'package:flutter_workspaces/presentation/pages/workspace_page/bloc/work_space_page_state.dart';
import 'package:flutter_workspaces/presentation/widgets/add_workspace_modal.dart';
import 'package:flutter_workspaces/presentation/widgets/card_widget.dart';
import 'package:get_it/get_it.dart';

class WorkSpacePageWithLib extends StatefulWidget {
  const WorkSpacePageWithLib({super.key});

  @override
  State<WorkSpacePageWithLib> createState() => _WorkSpacePageWithLibState();
}

class _WorkSpacePageWithLibState extends State<WorkSpacePageWithLib> {
  GetIt get getIt => GetIt.I;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkSpacePageBloc>(
      create: (_) => WorkSpacePageBloc(
        getAllWorkSpacesUseCase: getIt(),
        addWorkSpaceUseCase: getIt(),
        saveStateUseCase: getIt(),
      ),
      child: BlocBuilder<WorkSpacePageBloc, WorkSpacePageState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Рабочие пространства'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () async {
                    await showAddWorkspaceDialog(context).then((createdWorkSpace) {
                      if (createdWorkSpace != null) {
                        context.read<WorkSpacePageBloc>().add(
                              AddWorkSpaceEvent(
                                workSpace: WorkSpaceEntity(
                                  title: createdWorkSpace['title'],
                                  color: createdWorkSpace['color'],
                                ),
                              ),
                            );
                      }
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              )
            ],
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_rounded),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      labelText: 'Поиск',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state.workSpaces.isEmpty
                          ? const Center(child: Text('У вас нет рабочих пространств'))
                          : DraggableGridViewBuilder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                              ),
                              children: state.workSpaces.map((workspace) {
                                return DraggableGridItem(
                                  isDraggable: true,
                                  child: buildCard(workspace),
                                );
                              }).toList(),
                              isOnlyLongPress: false,
                              dragCompletion: (List<DraggableGridItem> list, int oldIndex, int newIndex) {
                                onDragAccept(context, state.workSpaces.toList(), oldIndex, newIndex);
                              },
                              dragFeedback: (List<DraggableGridItem> list, int index) {
                                return Material(
                                  color: Colors.transparent,
                                  child: list[index].child,
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buildCard(WorkSpaceEntity workspace) {
    return CardWidget(workspace: workspace);
  }

  void onDragAccept(BuildContext context, List<WorkSpaceEntity> workSpaces, int oldIndex, int newIndex) {
    final item = workSpaces.removeAt(oldIndex);
    workSpaces.insert(newIndex, item);
    context.read<WorkSpacePageBloc>().add(SaveStateEvent(workSpaces: workSpaces.toSet()));
  }
}
