import 'package:flutter/material.dart';
import 'package:flutter_workspaces/presentation/models/workspace_presentational_model.dart';

class CardWidget extends StatelessWidget {
  final Workspace workspace;
  const CardWidget({super.key, required this.workspace});

  @override
  Widget build(BuildContext context) {
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
}
