import 'package:flutter/material.dart';
import 'package:dart_appwrite/models.dart' as models;
import 'dart:math' as math;

class ReadOnlyRowWidget extends StatelessWidget {
  const ReadOnlyRowWidget({
    super.key,
    required this.row,
    required this.columns,
    required this.maxColumnWidths,
    this.highlightedField,
    this.highlightedFind,
    this.highlightedValue,
  });

  final models.Row row;
  final List<dynamic> columns;
  final Map<String, int> maxColumnWidths;
  final String? highlightedField;
  final String? highlightedFind;
  final String? highlightedValue;

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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 16.0, // horizontal spacing
          runSpacing: 16.0, // vertical spacing
          children: columns.map((column) {
            final key = (column['\$id'] ?? column['key']) as String;
            final contentWidth = (maxColumnWidths[key] ?? 10) * 10.0;
            final labelWidth = _calculateTextWidth(key, textStyle!);
            final width = math.max(contentWidth, labelWidth) + 40;
            final isHighlighted = highlightedField == key;

            String fieldValue;
            if (key == '\$id') {
              fieldValue = row.$id;
            } else if (key == '\$createdAt') {
              fieldValue = row.$createdAt;
            } else if (key == '\$updatedAt') {
              fieldValue = row.$updatedAt;
            } else {
              fieldValue = row.data[key]?.toString() ?? '';
            }

            if (isHighlighted &&
                highlightedFind != null &&
                highlightedValue != null) {
              fieldValue =
                  fieldValue.replaceAll(highlightedFind!, highlightedValue!);
            }

            return Container(
              width: width,
              color: isHighlighted ? Colors.green.withAlpha(76) : null,
              child: TextField(
                controller: TextEditingController(text: fieldValue),
                decoration: InputDecoration(labelText: key),
                readOnly: true,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
