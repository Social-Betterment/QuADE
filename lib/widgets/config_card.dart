import 'package:flutter/material.dart';
import 'package:quade/models/config.dart';

class ConfigCard extends StatefulWidget {
  const ConfigCard({
    super.key,
    required this.config,
    required this.onSave,
    required this.onLoad,
    required this.onDelete,
  });

  final Config config;
  final Function(Config) onSave;
  final Function(Config) onLoad;
  final VoidCallback onDelete;

  @override
  State<ConfigCard> createState() => _ConfigCardState();
}

class _ConfigCardState extends State<ConfigCard> {
  late final TextEditingController _endpointController;
  late final TextEditingController _projectIdController;
  late final TextEditingController _devKeyController;

  @override
  void initState() {
    super.initState();
    _endpointController = TextEditingController(text: widget.config.endpoint);
    _projectIdController = TextEditingController(text: widget.config.projectId);
    _devKeyController = TextEditingController(text: widget.config.devKey);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _endpointController,
              decoration: const InputDecoration(labelText: 'Endpoint'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _projectIdController,
              decoration: const InputDecoration(labelText: 'Project ID'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _devKeyController,
              decoration: const InputDecoration(labelText: 'API Key'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: widget.onDelete,
                ),
                const Text('Warning: Delete your configuration after use\nif you are not on a trusted device.',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                )),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    final newConfig = Config(
                      endpoint: _endpointController.text,
                      projectId: _projectIdController.text,
                      devKey: _devKeyController.text,
                    );
                    widget.onSave(newConfig);
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => widget.onLoad(widget.config),
                  child: const Text('Load'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
