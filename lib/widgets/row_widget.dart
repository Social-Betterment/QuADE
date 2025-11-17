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
    this.highlightedField,
    this.highlightedFind,
    this.highlightedValue,
  });

  final models.Row row;
  final List<dynamic> columns;
  final Function(String rowId, Map<String, dynamic> data) onUpdate;
  final Function(String rowId) onDelete;
  final Map<String, int> maxColumnWidths;
  final String? highlightedField;
  final String? highlightedFind;
  final String? highlightedValue;

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
    _originalData = widget.row.data;
    _controllers = {};
    _isEdited = {};

    // Initialize for meta fields
    _controllers['\$id'] = TextEditingController(text: widget.row.$id);
    _isEdited['\$id'] = false;
    _controllers['\$createdAt'] =
        TextEditingController(text: widget.row.$createdAt);
    _isEdited['\$createdAt'] = false;
    _controllers['\$updatedAt'] =
        TextEditingController(text: widget.row.$updatedAt);
    _isEdited['\$updatedAt'] = false;

    // Initialize for data fields
    for (var key in _originalData.keys) {
      _controllers[key] =
          TextEditingController(text: _originalData[key]?.toString() ?? '');
      _isEdited[key] = false;
    }
  }

  void _onFieldChanged(String key, String value) {
    setState(() {
      // For meta fields, we don't allow editing, so _isEdited should always be false
      if (key == '\$id' || key == '\$createdAt' || key == '\$updatedAt') {
        _isEdited[key] = false;
      } else {
        _isEdited[key] = _originalData[key]?.toString() != value;
      }
    });
  }

  void _updateField(String key) {
    // Meta fields are not editable
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
      // Only update editable fields
      if (_isEdited[key]! &&
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
    // Meta fields are always strings and not editable
    if (key == '\$id' || key == '\$createdAt' || key == '\$updatedAt') {
      return value;
    }
    final column = widget.columns.firstWhere((c) => (c as Map)['key'] == key,
        orElse: () => throw Exception("Column not found"));
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
    final textStyle =
        Theme.of(context).textTheme.titleMedium; // Or another appropriate style
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
                  spacing: 16.0, // horizontal spacing
                  runSpacing: 16.0, // vertical spacing
                  children: [
                    ...widget.columns.map((column) {
                      final key = (column['\$id'] ?? column['key']) as String;
                      final contentWidth =
                          (widget.maxColumnWidths[key] ?? 10) * 10.0;
                      final labelWidth = _calculateTextWidth(key, textStyle!);
                      final width = math.max(contentWidth, labelWidth) +
                          40; // + padding for icon and extra space
                      final isHighlighted = widget.highlightedField == key;

                      // Get value for meta fields or data fields
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

                      if (!_controllers.containsKey(key)) {
                        _controllers[key] =
                            TextEditingController(text: fieldValue);
                        _isEdited[key] = false;
                      } else {
                        _controllers[key]!.text = fieldValue;
                      }

                      if (isHighlighted &&
                          widget.highlightedFind != null &&
                          widget.highlightedValue != null) {
                        _controllers[key]!.text = fieldValue.replaceAll(
                            widget.highlightedFind!, widget.highlightedValue!);
                      }

                      final isMetaField = key == '\$id' ||
                          key == '\$createdAt' ||
                          key == '\$updatedAt';

                      return Container(
                        width: width,
                        color:
                            isHighlighted ? Colors.green.withAlpha(76) : null,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controllers[key],
                                decoration: InputDecoration(labelText: key),
                                onChanged: (value) =>
                                    _onFieldChanged(key, value),
                                readOnly: isMetaField || isHighlighted,
                              ),
                            ),
                            if (_isEdited[key]!)
                              IconButton(
                                icon: const Icon(Icons.check),
                                onPressed: () => _updateField(key),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                    // "Update All" button as the last child of Wrap
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
                      content:
                          const Text('Are you sure you want to delete this row?'),
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