import 'package:flutter/material.dart';
import 'package:flutter_workspaces/presentation/models/workspace_presentational_model.dart';

final class CardWidget extends StatelessWidget {
  final Workspace workspace;

  const CardWidget({super.key, required this.workspace});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: workspace.color,
      elevation: 30,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.more_horiz, color: Colors.white),
            ),
            Text(workspace.name, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
