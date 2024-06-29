import 'package:flutter/material.dart';

class WorkspacePageWithoutLib extends StatefulWidget {
  const WorkspacePageWithoutLib({super.key});

  @override
  State<WorkspacePageWithoutLib> createState() => _WorkspacePageWithoutLibState();
}

class _WorkspacePageWithoutLibState extends State<WorkspacePageWithoutLib> {
  List<Workspace> workspaces = [
    Workspace(name: 'Savva', color: Colors.red),
    Workspace(name: 'Olluco', color: Colors.pink),
    Workspace(name: 'Loona', color: Colors.purple),
    Workspace(name: 'Folk', color: Colors.blue),
    Workspace(name: 'White Rabbit', color: Colors.lightBlue),
    Workspace(name: 'Sage', color: Colors.green),
    Workspace(name: 'Maya', color: Colors.orange),
    Workspace(name: 'Jun', color: Colors.deepOrange),
    Workspace(name: 'Onest', color: Colors.deepPurple),
    Workspace(name: 'Пробка на Цветном', color: Colors.lightBlueAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Рабочие пространства'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: workspaces.length,
          itemBuilder: (context, index) {
            return DragTarget<Workspace>(
              onAccept: (receivedWorkspace) {
                setState(() {
                  final currentIndex = workspaces.indexOf(receivedWorkspace);
                  workspaces.removeAt(currentIndex);
                  workspaces.insert(index, receivedWorkspace);
                });
              },
              builder: (context, candidateData, rejectedData) {
                return DraggableCard(
                  workspace: workspaces[index],
                  onDragStarted: () {
                    setState(() {
                      workspaces[index].isBeingDragged = true;
                    });
                  },
                  onDragCompleted: () {
                    setState(() {
                      workspaces[index].isBeingDragged = false;
                    });
                  },
                  onDragEnd: (_) {
                    setState(() {
                      workspaces[index].isBeingDragged = false;
                    });
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class DraggableCard extends StatelessWidget {
  final Workspace workspace;
  final VoidCallback onDragStarted;
  final VoidCallback onDragCompleted;
  final DragEndCallback onDragEnd;

  const DraggableCard({
    super.key,
    required this.workspace,
    required this.onDragStarted,
    required this.onDragCompleted,
    required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: workspace.isBeingDragged ? 0.5 : 1.0,
      child: Draggable<Workspace>(
        data: workspace,
        feedback: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 20, // Keep the size the same as original
            child: Card(
              color: workspace.color,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(workspace.name, style: const TextStyle(color: Colors.white)),
                    const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.more_vert, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        childWhenDragging: Container(),
        onDragStarted: onDragStarted,
        onDragCompleted: onDragCompleted,
        onDraggableCanceled: (_, __) => onDragEnd,
        child: Card(
          color: workspace.color,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(workspace.name, style: const TextStyle(color: Colors.white)),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: onDragStarted,
                    child: const Icon(Icons.more_vert, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Workspace {
  final String name;
  final Color color;
  bool isBeingDragged;

  Workspace({required this.name, required this.color, this.isBeingDragged = false});
}
