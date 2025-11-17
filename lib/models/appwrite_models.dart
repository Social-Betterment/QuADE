import 'dart:convert';

class CustomTableList {
  final List<CustomTable> tables;

  CustomTableList({required this.tables});

  factory CustomTableList.fromJson(String source) {
    final Map<String, dynamic> map = json.decode(source);
    return CustomTableList(
      tables: List<CustomTable>.from(
          map['tables']?.map((x) => CustomTable.fromMap(x)) ?? []),
    );
  }
}

class CustomTable {
  final String $id;
  final String name;
  final List<CustomColumn> columns;
  final List<CustomIndex> indexes;

  CustomTable({
    required this.$id,
    required this.name,
    required this.columns,
    required this.indexes,
  });

  factory CustomTable.fromMap(Map<String, dynamic> map) {
    return CustomTable(
      $id: map['\$id'] ?? '',
      name: map['name'] ?? '',
      columns: List<CustomColumn>.from(
          map['columns']?.map((x) => CustomColumn.fromMap(x)) ?? []),
      indexes: List<CustomIndex>.from(
          map['indexes']?.map((x) => CustomIndex.fromMap(x)) ?? []),
    );
  }
}

class CustomColumn {
  final String key;
  final String type;
  final String status;
  final String? error; // Can be null
  final bool required;
  final bool array;

  CustomColumn({
    required this.key,
    required this.type,
    required this.status,
    this.error,
    required this.required,
    required this.array,
  });

  factory CustomColumn.fromMap(Map<String, dynamic> map) {
    return CustomColumn(
      key: map['key'] ?? '',
      type: map['type'] ?? '',
      status: map['status'] ?? '',
      error: map['error'],
      required: map['required'] ?? false,
      array: map['array'] ?? false,
    );
  }
}

class CustomIndex {
  final String $id;
  final String key;
  final String type;
  final String status;
  final String? error; // Can be null
  final List<String> columns;
  final List<String?> orders; // This is the fix: allow null in orders

  CustomIndex({
    required this.$id,
    required this.key,
    required this.type,
    required this.status,
    this.error,
    required this.columns,
    required this.orders,
  });

  factory CustomIndex.fromMap(Map<String, dynamic> map) {
    return CustomIndex(
      $id: map['\$id'] ?? '',
      key: map['key'] ?? '',
      type: map['type'] ?? '',
      status: map['status'] ?? '',
      error: map['error'],
      columns: List<String>.from(map['columns']?.map((x) => x) ?? []),
      orders: List<String?>.from(
          map['orders']?.map((x) => x) ?? []), // Handle nulls
    );
  }
}
