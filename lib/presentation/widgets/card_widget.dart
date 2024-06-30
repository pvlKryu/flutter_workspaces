import 'package:flutter/material.dart';
import 'package:flutter_workspaces/domain/entities/workspace_entity.dart';

final class CardWidget extends StatelessWidget {
  final WorkSpaceEntity workspace;

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
            Text(workspace.title, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
