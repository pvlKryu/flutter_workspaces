import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:flutter_workspaces/presentation/models/workspace_presentational_model.dart';
import 'package:flutter_workspaces/presentation/widgets/card_widget.dart';

class WorkspacePageWithLib extends StatefulWidget {
  const WorkspacePageWithLib({super.key});

  @override
  State<WorkspacePageWithLib> createState() => _WorkspacePageWithLibState();
}

class _WorkspacePageWithLibState extends State<WorkspacePageWithLib> {
  List<Workspace> workspaces = [
    const Workspace(name: 'Savva', color: Colors.red),
    const Workspace(name: 'Olluco', color: Colors.pink),
    const Workspace(name: 'Loona', color: Colors.purple),
    const Workspace(name: 'Folk', color: Colors.blue),
    const Workspace(name: 'White Rabbit', color: Colors.lightBlue),
    const Workspace(name: 'Sage', color: Colors.green),
    const Workspace(name: 'Maya', color: Colors.orange),
    const Workspace(name: 'Jun', color: Colors.deepOrange),
    const Workspace(name: 'Onest', color: Colors.deepPurple),
    const Workspace(name: 'Пробка на Цветном', color: Colors.lightBlueAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Рабочие пространства'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
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
        child: DraggableGridViewBuilder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          children: workspaces.map((workspace) {
            return DraggableGridItem(
              isDraggable: true,
              child: buildCard(workspace),
            );
          }).toList(),
          isOnlyLongPress: false,
          dragCompletion: onDragAccept,
          dragFeedback: (List<DraggableGridItem> list, int index) {
            return Material(
              color: Colors.transparent,
              child: list[index].child,
            );
          },
        ),
      ),
    );
  }

  Widget buildCard(Workspace workspace) {
    return CardWidget(workspace: workspace);
  }

  void onDragAccept(List<DraggableGridItem> list, int oldIndex, int newIndex) {
    setState(() {
      final item = workspaces.removeAt(oldIndex);
      workspaces.insert(newIndex, item);
    });
  }
}
