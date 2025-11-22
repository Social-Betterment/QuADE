import 'package:flutter/material.dart';
import 'package:dart_appwrite/models.dart' as models;
import 'dart:math' as math;

class RowWidget extends StatefulWidget {
  const RowWidget({
    super.key,
    required this.row,
    required this.columns,
    required this.onUpdate,
    required this.onDelete,
    required this.maxColumnWidths,
  });

  final models.Row row;
  final List<dynamic> columns;
  final Function(String rowId, Map<String, dynamic> data) onUpdate;
  final Function(String rowId) onDelete;
  final Map<String, int> maxColumnWidths;

  @override
  State<RowWidget> createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  late Map<String, TextEditingController> _controllers;
  late Map<String, dynamic> _originalData;
  late Map<String, bool> _isEdited;

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  @override
  void didUpdateWidget(RowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.row.$id != oldWidget.row.$id) {
      _disposeControllers();
      _initializeState();
    } else {
      // If the same row has been updated from the parent, update controllers
      // for fields that are not being edited by the user.
      _originalData = widget.row.data;
      for (var column in widget.columns) {
        final key = (column['\$id'] ?? column['key']) as String;
        if (_controllers.containsKey(key) && !(_isEdited[key] ?? false)) {
          String newValue;
          if (key == '\$id') {
            newValue = widget.row.$id;
          } else if (key == '\$createdAt') {
            newValue = widget.row.$createdAt;
          } else if (key == '\$updatedAt') {
            newValue = widget.row.$updatedAt;
          } else {
            newValue = _originalData[key]?.toString() ?? '';
          }
          _controllers[key]!.text = newValue;
        }
      }
    }
  }

  void _initializeState() {
    _originalData = widget.row.data;
    _controllers = {};
    _isEdited = {};

    for (var column in widget.columns) {
      final key = (column['\$id'] ?? column['key']) as String;
      String fieldValue;
      if (key == '\$id') {
        fieldValue = widget.row.$id;
      } else if (key == '\$createdAt') {
        fieldValue = widget.row.$createdAt;
      } else if (key == '\$updatedAt') {
        fieldValue = widget.row.$updatedAt;
      } else {
        fieldValue = _originalData[key]?.toString() ?? '';
      }
      _controllers[key] = TextEditingController(text: fieldValue);
      _isEdited[key] = false;
    }
  }

  void _disposeControllers() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _onFieldChanged(String key, String value) {
    setState(() {
      if (key == '\$id' || key == '\$createdAt' || key == '\$updatedAt') {
        _isEdited[key] = false;
      } else {
        _isEdited[key] = _originalData[key]?.toString() != value;
      }
    });
  }

  void _updateField(String key) {
    if (key == '\$id' || key == '\$createdAt' || key == '\$updatedAt') {
      return;
    }
    final data = {key: _getTypedValue(key, _controllers[key]!.text)};
    widget.onUpdate(widget.row.$id, data);
    setState(() {
      _originalData[key] = _getTypedValue(key, _controllers[key]!.text);
      _isEdited[key] = false;
    });
  }

  void _updateAll() {
    final data = <String, dynamic>{};
    for (var key in _isEdited.keys) {
      if ((_isEdited[key] ?? false) &&
          !(key == '\$id' || key == '\$createdAt' || key == '\$updatedAt')) {
        data[key] = _getTypedValue(key, _controllers[key]!.text);
      }
    }
    if (data.isNotEmpty) {
      widget.onUpdate(widget.row.$id, data);
      setState(() {
        for (var key in data.keys) {
          _originalData[key] = data[key];
          _isEdited[key] = false;
        }
      });
    }
  }

  dynamic _getTypedValue(String key, String value) {
    if (key == '\$id' || key == '\$createdAt' || key == '\$updatedAt') {
      return value;
    }
    final column = widget.columns.firstWhere((c) => (c as Map)['key'] == key,
        orElse: () => throw Exception("Column not found for key: $key"));
    switch ((column as Map)['type']) {
      case 'string':
        return value;
      case 'integer':
        return int.tryParse(value) ?? 0;
      case 'double':
        return double.tryParse(value) ?? 0.0;
      case 'boolean':
        return value.toLowerCase() == 'true';
      default:
        return value;
    }
  }

  double _calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: [
                    ...widget.columns.map((column) {
                      final key = (column['\$id'] ?? column['key']) as String;
                      final contentWidth =
                          (widget.maxColumnWidths[key] ?? 10) * 10.0;
                      final labelWidth = _calculateTextWidth(key, textStyle!);
                      final width = math.max(contentWidth, labelWidth) + 40;
                      final isMetaField = key == '\$id' ||
                          key == '\$createdAt' ||
                          key == '\$updatedAt';

                      return Container(
                        width: width,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controllers[key],
                                decoration: InputDecoration(labelText: key),
                                onChanged: (value) =>
                                    _onFieldChanged(key, value),
                                readOnly: isMetaField,
                              ),
                            ),
                            if (_isEdited[key] ?? false)
                              IconButton(
                                icon: const Icon(Icons.check),
                                onPressed: () => _updateField(key),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                    ElevatedButton(
                      onPressed: _updateAll,
                      child: const Text('Update Row'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Delete'),
                      content: const Text(
                          'Are you sure you want to delete this row?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Delete'),
                          onPressed: () {
                            widget.onDelete(widget.row.$id);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
