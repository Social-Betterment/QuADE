import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quade/main.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart' as models;
import 'package:quade/models/config.dart';
import 'package:quade/widgets/readonly_row_widget.dart';

class FindAndReplacePage extends StatefulWidget {
  const FindAndReplacePage({
    super.key,
    this.databaseId,
    this.tableId,
    this.field,
    this.find,
    this.replace,
    this.allPages,
    this.queries,
    this.offset,
    this.limit,
  });

  final String? databaseId;
  final String? tableId;
  final String? field;
  final String? find;
  final String? replace;
  final bool? allPages;
  final List<String>? queries;
  final int? offset;
  final int? limit;

  @override
  State<FindAndReplacePage> createState() => _FindAndReplacePageState();
}

class _FindAndReplacePageState extends State<FindAndReplacePage> {
  Future<List<models.Row>>? _rowsFuture;
  List<models.Row> _rows = [];
  Future<models.Table>? _tableFuture;
  final Map<String, int> _maxColumnWidths = {};

  @override
  void initState() {
    super.initState();
    _tableFuture = _fetchTable();
    _rowsFuture = _tableFuture!.then((table) => _fetchRows(table));
  }

  Future<models.Table> _fetchTable() async {
    final appwriteNotifier =
        Provider.of<AppwriteNotifier>(context, listen: false);
    return await appwriteNotifier.getTable(
      databaseId: widget.databaseId!,
      tableId: widget.tableId!,
    );
  }

  void _calculateMaxWidths(List<models.Row> rows, models.Table table) {
    final allColumnKeys = [
      ...table.columns.map((c) => (c as Map)['key'] as String),
      '\$id',
      '\$createdAt',
      '\$updatedAt'
    ];

    for (var key in allColumnKeys) {
      final labelLength = key.length;
      _maxColumnWidths[key] = labelLength;
    }

    for (var row in rows) {
      final allFields = {
        ...row.data,
        '\$id': row.$id,
        '\$createdAt': row.$createdAt,
        '\$updatedAt': row.$updatedAt,
      };

      for (var entry in allFields.entries) {
        final key = entry.key;
        if (_maxColumnWidths.containsKey(key)) {
          final valueLength = entry.value?.toString().length ?? 0;
          if (valueLength > (_maxColumnWidths[key]!)) {
            _maxColumnWidths[key] = valueLength;
          }
        }
      }
    }
  }

  Future<List<models.Row>> _fetchRows(models.Table table) async {
    final appwriteNotifier =
        Provider.of<AppwriteNotifier>(context, listen: false);
    List<models.Row> allRows = [];
    List<String> queries = widget.queries ?? [];

    if (widget.allPages!) {
      int offset = 0;
      int limit = 100;
      while (true) {
        final rowList = await appwriteNotifier.listRows(
          databaseId: widget.databaseId!,
          tableId: widget.tableId!,
          queries: [...queries, Query.limit(limit), Query.offset(offset)],
        );
        allRows.addAll(rowList.rows);
        if (rowList.rows.length < limit) {
          break;
        }
        offset += limit;
      }
    } else {
      final rowList = await appwriteNotifier.listRows(
        databaseId: widget.databaseId!,
        tableId: widget.tableId!,
        queries: [
          ...queries,
          Query.limit(widget.limit!),
          Query.offset(widget.offset!)
        ],
      );
      allRows.addAll(rowList.rows);
    }
    final filteredRows = allRows
        .where((row) =>
            row.data[widget.field!] != null &&
            row.data[widget.field!].toString().contains(widget.find!))
        .toList();

    _calculateMaxWidths(filteredRows, table);

    setState(() {
      _rows = filteredRows;
    });
    return _rows;
  }

  void _showTransactionDialog() async {
    final table = await _tableFuture;
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by clicking outside
      builder: (BuildContext context) {
        return TransactionDialog(
          rows: _rows,
          table: table!,
          databaseId: widget.databaseId!,
          tableId: widget.tableId!,
          field: widget.field!,
          find: widget.find!,
          replace: widget.replace!,
        );
      },
    ).then((_) {
      // After dialog is closed, pop the FindAndReplacePage
      if (mounted) {
        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Find and Replace'),
            const SizedBox(width: 16),
            IconButton(
              icon: const Icon(Icons.key),
              onPressed: () => context.go('/configs'),
            ),
            const Text('>'),
            IconButton(
              icon: const Icon(Icons.storage),
              onPressed: () => context.go('/databases'),
            ),
            const Text('>'),
            IconButton(
              icon: const Icon(Icons.table_chart),
              onPressed: () =>
                  context.go('/tables?database_id=${widget.databaseId}'),
            ),
            const Text('>'),
            IconButton(
              icon: const Icon(Icons.view_list),
              onPressed: () => context.go(
                  '/table?database_id=${widget.databaseId}&table_id=${widget.tableId}'),
            ),
            const Text('>'),
            const Icon(Icons.find_replace),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: _showTransactionDialog,
            child: const Text('Write All to Database'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Future.wait([_tableFuture!, _rowsFuture!]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found.'));
          }
          final table = snapshot.data![0] as models.Table;

          if (_rows.isEmpty) {
            return const Center(child: Text('No matching rows found.'));
          }

          final allColumns = [
            ...table.columns,
            {'\$id': '\$id', 'key': '\$id', 'type': 'string'},
            {'\$id': '\$createdAt', 'key': '\$createdAt', 'type': 'string'},
            {'\$id': '\$updatedAt', 'key': '\$updatedAt', 'type': 'string'},
          ];

          return ListView.builder(
            itemCount: _rows.length,
            itemBuilder: (context, index) {
              final row = _rows[index];
              return ReadOnlyRowWidget(
                row: row,
                columns: allColumns,
                maxColumnWidths: _maxColumnWidths,
                highlightedField: widget.field,
                highlightedFind: widget.find,
                highlightedValue: widget.replace,
              );
            },
          );
        },
      ),
    );
  }
}

class TransactionDialog extends StatefulWidget {
  final List<models.Row> rows;
  final models.Table table;
  final String databaseId;
  final String tableId;
  final String field;
  final String find;
  final String replace;

  const TransactionDialog({
    super.key,
    required this.rows,
    required this.table,
    required this.databaseId,
    required this.tableId,
    required this.field,
    required this.find,
    required this.replace,
  });

  @override
  State<TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  String _status = "Preparing transaction...";
  String? _error;
  bool _isFinished = false;
  bool _isCancelled = false;

  @override
  void initState() {
    super.initState();
    _runTransaction();
  }

  Future<void> _runTransaction() async {
    final appwriteNotifier =
        Provider.of<AppwriteNotifier>(context, listen: false);
    final config = appwriteNotifier.config!;
    final plan = config.plan;

    int getBatchSize(Plan plan) {
      switch (plan) {
        case Plan.free:
          return 100;
        case Plan.pro:
          return 1000;
        case Plan.scale:
          return 2500;
      }
    }

    final batchSize = getBatchSize(plan);
    final numBatches = (widget.rows.length / batchSize).ceil();
    models.Transaction? currentTx;

    try {
      for (int i = 0; i < numBatches; i++) {
        if (_isCancelled) throw Exception("Cancelled by user.");

        final batchRows =
            widget.rows.skip(i * batchSize).take(batchSize).toList();

        setState(() {
          _status = "Processing batch ${i + 1} of $numBatches...";
        });

        // 1. Create transaction
        setState(() {
          _status = "Creating transaction for batch ${i + 1} of $numBatches...";
        });
        if (_isCancelled) throw Exception("Cancelled by user.");
        currentTx = await appwriteNotifier.createTransaction();

        // 2. Stage operations
        setState(() {
          _status = "Staging changes for batch ${i + 1} of $numBatches...";
        });
        if (_isCancelled) throw Exception("Cancelled by user.");
        final operations = batchRows.map((row) {
          final originalValue = row.data[widget.field]?.toString() ?? '';
          final replacedValue =
              originalValue.replaceAll(widget.find, widget.replace);

          // Get the column type to convert the replaced value properly
          final column = widget.table.columns.firstWhere(
            (c) => (c as Map)['key'] == widget.field,
            orElse: () => {'type': 'string'},
          ) as Map;
          final columnType = column['type'] as String;

          // Convert the replaced value to the proper type
          dynamic typedValue;
          switch (columnType) {
            case 'boolean':
              typedValue = replacedValue.toLowerCase() == 'true';
              break;
            case 'integer':
              typedValue = int.tryParse(replacedValue) ?? 0;
              break;
            case 'double':
              typedValue = double.tryParse(replacedValue) ?? 0.0;
              break;
            default:
              typedValue = replacedValue;
          }

          final updatedData = {
            widget.field: typedValue,
          };
          return {
            'action': 'update',
            'databaseId': widget.databaseId,
            'tableId': widget.tableId,
            'rowId': row.$id,
            'data': updatedData,
          };
        }).toList();

        if (operations.isNotEmpty) {
          await appwriteNotifier.createOperations(
            transactionId: currentTx.$id,
            operations: operations,
          );
        }

        // 3. Commit with retry
        if (_isCancelled) throw Exception("Cancelled by user.");
        const maxRetries = 5;
        bool committed = false;
        for (int attempt = 0; attempt < maxRetries; attempt++) {
          if (_isCancelled) throw Exception("Cancelled by user.");
          try {
            setState(() {
              _status =
                  "Committing batch ${i + 1} (Attempt ${attempt + 1}/$maxRetries)...";
            });
            await appwriteNotifier.updateTransaction(
              transactionId: currentTx.$id,
              commit: true,
            );
            committed = true;
            break; // Success
          } on AppwriteException catch (e) {
            if (e.code == 400 && e.type == 'transaction_not_ready') {
              if (attempt + 1 >= maxRetries) {
                rethrow; // Max retries reached
              }
              final waitMs = 500 * (1 << attempt); // 500ms, 1s, 2s, 4s
              setState(() {
                _status =
                    "Waiting for batch ${i + 1}... (Attempt ${attempt + 1}/$maxRetries)";
              });
              await Future.delayed(Duration(milliseconds: waitMs));
            } else {
              rethrow; // Re-throw other Appwrite exceptions
            }
          }
        }

        if (!committed) {
          throw Exception(
              "Batch ${i + 1} could not be committed after $maxRetries attempts.");
        }
      }

      setState(() {
        _status = "All transactions complete!";
        _isFinished = true;
      });
    } catch (e) {
      if (_isCancelled) {
        if (currentTx != null) {
          await appwriteNotifier.updateTransaction(
              transactionId: currentTx.$id, rollback: true);
        }
        setState(() {
          _status = "Transaction Cancelled.";
          _error = null;
        });
      } else {
        if (currentTx != null) {
          await appwriteNotifier.updateTransaction(
              transactionId: currentTx.$id, rollback: true);
        }
        setState(() {
          _status = "Transaction Failed!";
          _error = e.toString();
        });
      }
      setState(() {
        _isFinished = true;
      });
    }
  }

  void _cancel() {
    if (_isFinished) return;
    setState(() {
      _isCancelled = true;
      _status = "Cancelling...";
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Processing Changes'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_isFinished) const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(_status, textAlign: TextAlign.center),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(
              _error!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_isFinished) {
              Navigator.of(context).pop();
            } else {
              _cancel();
            }
          },
          child: Text(_isFinished ? 'Close' : 'Cancel'),
        ),
      ],
    );
  }
}
