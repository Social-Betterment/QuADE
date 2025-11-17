import 'dart:convert';

import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/src/enums.dart'; // Reverted import
import 'package:dart_appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quade/models/appwrite_models.dart';
import 'package:quade/models/config.dart';
import 'package:quade/router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppwriteNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'QuADE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}

class TableState {
  Map<String, String> queryValues;
  List<Map<String, dynamic>> sorts;
  int offset;

  TableState({
    this.queryValues = const {},
    this.sorts = const [],
    this.offset = 0,
  });
}

class AppwriteNotifier extends ChangeNotifier {
  Client? _client;
  TablesDB? _tablesDB;
  final Map<String, TableState> _tableStates = {};

  Client? get client => _client;
  TablesDB? get tablesDB => _tablesDB;

  TableState getTableState(String databaseId, String tableId) {
    final key = '$databaseId/$tableId';
    if (!_tableStates.containsKey(key)) {
      _tableStates[key] = TableState();
    }
    return _tableStates[key]!;
  }

  void setTableState(String databaseId, String tableId, TableState state) {
    final key = '$databaseId/$tableId';
    _tableStates[key] = state;
  }

  void setClient(Config config) {
    _client = Client()
      ..setEndpoint(config.endpoint)
      ..setProject(config.projectId)
      ..setKey(config.devKey);
    _tablesDB = TablesDB(_client!);
    notifyListeners();
  }

  Future<models.DatabaseList> listDatabases() async {
    if (_tablesDB == null) {
      throw Exception("Appwrite client not initialized");
    }
    return await _tablesDB!.list();
  }

  Future<CustomTableList> listTables(String databaseId) async {
    if (_client == null) {
      throw Exception("Appwrite client not initialized");
    }
    final response = await _client!.call(
      HttpMethod.get,
      path: '/tablesdb/$databaseId/tables',
    );
    return CustomTableList.fromJson(json.encode(response.data));
  }

  dynamic _sanitize(dynamic data) {
    if (data is Map<String, dynamic>) {
      final sanitizedMap = <String, dynamic>{};
      data.forEach((key, value) {
        sanitizedMap[key] = _sanitize(value);
      });
      return sanitizedMap;
    } else if (data is List) {
      return data.map((item) => _sanitize(item)).toList();
    } else {
      return data ?? '';
    }
  }

  Future<models.Table> getTable(
      {required String databaseId, required String tableId}) async {
    if (_client == null) {
      throw Exception("Appwrite client not initialized");
    }
    final response = await _client!.call(
      HttpMethod.get,
      path: '/tablesdb/$databaseId/tables/$tableId',
    );

    final sanitizedData = _sanitize(response.data);

    return models.Table.fromMap(sanitizedData as Map<String, dynamic>);
  }

  Future<models.RowList> listRows(
      {required String databaseId,
      required String tableId,
      List<String>? queries}) async {
    if (_tablesDB == null) {
      throw Exception("Appwrite client not initialized");
    }
    return await _tablesDB!
        .listRows(databaseId: databaseId, tableId: tableId, queries: queries);
  }

  Future<models.Row> updateRow(
      {required String databaseId,
      required String tableId,
      required String rowId,
      required Map<String, dynamic> data}) async {
    if (_tablesDB == null) {
      throw Exception("Appwrite client not initialized");
    }
    return await _tablesDB!.updateRow(
        databaseId: databaseId, tableId: tableId, rowId: rowId, data: data);
  }

  Future<models.Transaction> createTransaction() async {
    if (_tablesDB == null) {
      throw Exception("Appwrite client not initialized");
    }
    return await _tablesDB!.createTransaction();
  }

  Future<void> createOperations({
    required String transactionId,
    required List<Map<String, dynamic>> operations,
  }) async {
    if (_tablesDB == null) {
      throw Exception("Appwrite client not initialized");
    }
    await _tablesDB!.createOperations(
      transactionId: transactionId,
      operations: operations,
    );
  }

  Future<void> updateTransaction({
    required String transactionId,
    bool? commit,
    bool? rollback,
  }) async {
    if (_tablesDB == null) {
      throw Exception("Appwrite client not initialized");
    }
    await _tablesDB!.updateTransaction(
      transactionId: transactionId,
      commit: commit,
      rollback: rollback,
    );
  }

  Future<void> deleteRow({
    required String databaseId,
    required String tableId,
    required String rowId,
  }) async {
    if (_tablesDB == null) {
      throw Exception("Appwrite client not initialized");
    }
    await _tablesDB!.deleteRow(
      databaseId: databaseId,
      tableId: tableId,
      rowId: rowId,
    );
  }
}
