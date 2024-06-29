import 'package:flutter/material.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WorkspacePage(),
    );
  }
}

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  _WorkspacePageState createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
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
              child: buildCard(context, workspace),
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

  Widget buildCard(BuildContext context, Workspace workspace) {
    return Card(
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
    );
  }

  void onDragAccept(List<DraggableGridItem> list, int oldIndex, int newIndex) {
    setState(() {
      final item = workspaces.removeAt(oldIndex);
      workspaces.insert(newIndex, item);
    });
  }
}

class Workspace {
  final String name;
  final Color color;

  Workspace({required this.name, required this.color});
}
