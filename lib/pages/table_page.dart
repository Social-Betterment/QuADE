import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quade/main.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart' as models;
import 'package:quade/widgets/row_widget.dart';
import 'package:quade/feature_flags.dart';
import 'package:styled_text/styled_text.dart';

class TablePage extends StatefulWidget {
  const TablePage(
      {super.key,
      this.databaseId,
      this.tableId,
      this.databaseName,
      this.tableName});

  final String? databaseId;
  final String? tableId;
  final String? databaseName;
  final String? tableName;

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  Future<models.Table>? _tableFuture;
  Future<models.RowList>? _rowsFuture;
  Future<List<dynamic>>? _combinedFuture; // New combined future
  int _offset = 0;
  final int _limit = 25;
  final Map<String, int> _maxColumnWidths = {};
  Map<String, TextEditingController> _queryControllers = {};
  List<Map<String, dynamic>> _sorts = [];

  @override
  void initState() {
    super.initState();
    if (widget.databaseId == null || widget.tableId == null) {
      _tableFuture = Future.value(_emptyTable());
      _rowsFuture = Future.value(_emptyRowList());
      _combinedFuture = Future.wait(
          [_tableFuture!, _rowsFuture!]); // Initialize combined future
    } else {
      _loadTableAndRows();
    }
  }

  @override
  void didUpdateWidget(covariant TablePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.databaseId != widget.databaseId ||
        oldWidget.tableId != widget.tableId ||
        oldWidget.databaseName != widget.databaseName ||
        oldWidget.tableName != widget.tableName) {
      if (widget.databaseId == null || widget.tableId == null) {
        setState(() {
          _tableFuture = Future.value(_emptyTable());
          _rowsFuture = Future.value(_emptyRowList());
          _combinedFuture = Future.wait(
              [_tableFuture!, _rowsFuture!]); // Initialize combined future
        });
      } else {
        _loadTableAndRows();
      }
    }
  }

  @override
  void dispose() {
    _saveState();
    for (var controller in _queryControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveState() {
    if (widget.databaseId == null || widget.tableId == null) return;
    final appwriteNotifier =
        Provider.of<AppwriteNotifier>(context, listen: false);
    final queryValues = {
      for (var entry in _queryControllers.entries) entry.key: entry.value.text,
    };
    final newState = TableState(
      queryValues: queryValues,
      sorts: _sorts,
      offset: _offset,
    );
    appwriteNotifier.setTableState(
        widget.databaseId!, widget.tableId!, newState);
  }

  void _loadState() {
    if (widget.databaseId == null || widget.tableId == null) return;
    final appwriteNotifier =
        Provider.of<AppwriteNotifier>(context, listen: false);
    final tableState =
        appwriteNotifier.getTableState(widget.databaseId!, widget.tableId!);
    _sorts = List.from(tableState.sorts); // Create a growable copy
    _offset = tableState.offset;
    tableState.queryValues.forEach((key, value) {
      if (_queryControllers.containsKey(key)) {
        _queryControllers[key]!.text = value;
      }
    });
  }

  models.Table _emptyTable() {
    return models.Table.fromMap({
      '\$id': '',
      '\$createdAt': '',
      '\$updatedAt': '',
      '\$permissions': [],
      'name': '',
      'databaseId': '',
      'collection': '',
      'attributes': [],
      'indexes': [
        {
          '\$id': '',
          '\$createdAt': '',
          '\$updatedAt': '',
          'key': '',
          'type': '',
          'status': '',
          'error': '',
          'attributes': [],
          'orders': [],
        }
      ],
      'documentSecurity': false,
      'enabled': false,
      'rowSecurity': false,
      'columns': [],
    });
  }

  models.RowList _emptyRowList() {
    return models.RowList(
      total: 0,
      rows: [],
    );
  }

  void _loadTableAndRows() {
    if (widget.databaseId == null || widget.tableId == null) {
      setState(() {
        _tableFuture = Future.value(_emptyTable());
        _rowsFuture = Future.value(_emptyRowList());
        _combinedFuture = Future.wait(
            [_tableFuture!, _rowsFuture!]); // Initialize combined future
      });
      return;
    }
    final appwriteNotifier =
        Provider.of<AppwriteNotifier>(context, listen: false);
    setState(() {
      _tableFuture = appwriteNotifier.getTable(
          databaseId: widget.databaseId!, tableId: widget.tableId!);
      _tableFuture!.then((table) {
        _queryControllers = {
          for (var col in table.columns)
            if (col is Map<String, dynamic> && col.containsKey('key'))
              col['key'] as String: TextEditingController()
            else
              '': TextEditingController(), // Provide a default or handle error
          '\$id': TextEditingController(),
          '\$createdAt': TextEditingController(),
          '\$updatedAt': TextEditingController(),
        };
        _loadState();
        final queries = _buildQueries();
        _loadRows(queries: queries);
      });
    });
  }

  void _loadRows({List<String>? queries}) {
    if (widget.databaseId == null || widget.tableId == null) {
      setState(() {
        _rowsFuture = Future.value(_emptyRowList());
        _combinedFuture = Future.wait(
            [_tableFuture!, _rowsFuture!]); // Update combined future
      });
      return;
    }
    final appwriteNotifier =
        Provider.of<AppwriteNotifier>(context, listen: false);

    List<String> allQueries = queries ?? [];
    allQueries.addAll([Query.limit(_limit), Query.offset(_offset)]);

    final newRowsFuture = appwriteNotifier.listRows(
        databaseId: widget.databaseId!,
        tableId: widget.tableId!,
        queries: allQueries);

    setState(() {
      _rowsFuture = newRowsFuture;
      _combinedFuture =
          Future.wait([_tableFuture!, _rowsFuture!]); // Update combined future
      _rowsFuture!.then((rowList) {
        _calculateMaxWidths(rowList.rows);
      });
    });
  }

  void _deleteRow(String rowId) {
    if (widget.databaseId == null || widget.tableId == null) return;
    final appwriteNotifier =
        Provider.of<AppwriteNotifier>(context, listen: false);
    appwriteNotifier
        .deleteRow(
            databaseId: widget.databaseId!,
            tableId: widget.tableId!,
            rowId: rowId)
        .then((_) {
      // Reload rows after deletion
      _loadRows(queries: _buildQueries());
    });
  }

  void _calculateMaxWidths(List<models.Row> rows) {
    for (var row in rows) {
      // Include meta fields
      final metaFields = {
        '\$id': row.$id,
        '\$createdAt': row.$createdAt,
        '\$updatedAt': row.$updatedAt,
      };

      for (var entry in metaFields.entries) {
        final key = entry.key;
        final valueLength = entry.value.toString().length;
        if (valueLength > (_maxColumnWidths[key] ?? 0)) {
          setState(() {
            _maxColumnWidths[key] = valueLength;
          });
        }
      }

      // Include data fields
      for (var key in row.data.keys) {
        final valueLength = row.data[key]?.toString().length ?? 0;
        if (valueLength > (_maxColumnWidths[key] ?? 0)) {
          setState(() {
            _maxColumnWidths[key] = valueLength;
          });
        }
      }
    }
  }

  void _updateRow(String rowId, Map<String, dynamic> data) {
    if (widget.databaseId == null || widget.tableId == null) return;
    final appwriteNotifier =
        Provider.of<AppwriteNotifier>(context, listen: false);
    appwriteNotifier.updateRow(
        databaseId: widget.databaseId!,
        tableId: widget.tableId!,
        rowId: rowId,
        data: data);
  }

  void _applyFilters() {
    _offset = 0; // Reset to first page when applying new filters
    final queries = _buildQueries();
    _loadRows(queries: queries);
  }

  void _clearFilters() {
    for (var controller in _queryControllers.values) {
      controller.clear();
    }
    _sorts.clear();
    _offset = 0;
    _loadRows();
  }

  List<String> _buildQueries() {
    final queries = <String>[];
    _queryControllers.forEach((key, controller) {
      String value = controller.text.trim();
      if (value.isNotEmpty) {
        if (value.contains(',')) {
          final values = value.split(',').map((v) => v.trim()).toList();
          queries.add(Query.equal(key, values));
        } else if (value.startsWith('!=')) {
          queries.add(Query.notEqual(key, value.substring(2)));
        } else if (value.startsWith('>=')) {
          queries.add(Query.greaterThanEqual(key, value.substring(2)));
        } else if (value.startsWith('>')) {
          queries.add(Query.greaterThan(key, value.substring(1)));
        } else if (value.startsWith('<=')) {
          queries.add(Query.lessThanEqual(key, value.substring(2)));
        } else if (value.startsWith('<')) {
          queries.add(Query.lessThan(key, value.substring(1)));
        } else if (value.startsWith('*') && value.endsWith('*')) {
          queries
              .add(Query.contains(key, value.substring(1, value.length - 1)));
        } else if (value.startsWith('*')) {
          queries.add(Query.endsWith(key, value.substring(1)));
        } else if (value.endsWith('*')) {
          queries
              .add(Query.startsWith(key, value.substring(0, value.length - 1)));
        } else if (value.toLowerCase() == 'isnull') {
          queries.add(Query.isNull(key));
        } else if (value.toLowerCase() == 'isnotnull') {
          queries.add(Query.isNotNull(key));
        } else {
          queries.add(Query.equal(key, value));
        }
      }
    });
    for (var sort in _sorts) {
      if (sort['direction'] == 'asc') {
        queries.add(Query.orderAsc(sort['field']));
      } else {
        queries.add(Query.orderDesc(sort['field']));
      }
    }
    return queries;
  }

  void _toggleSort(String key) {
    setState(() {
      int index = _sorts.indexWhere((sort) => sort['field'] == key);
      if (index == -1) {
        _sorts.add(
            {'field': key, 'direction': 'asc', 'priority': _sorts.length + 1});
      } else {
        if (_sorts[index]['direction'] == 'asc') {
          _sorts[index]['direction'] = 'desc';
        } else {
          _sorts.removeAt(index);
        }
      }
      // Recalculate priorities
      for (int i = 0; i < _sorts.length; i++) {
        _sorts[i]['priority'] = i + 1;
      }
    });
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Query by Example Help'),
        content: StyledText(
          text: '''Enter values in the text fields to filter the rows.<br/><br/>
                  <bold>Operators:</bold><br/>
                  <bold>No operator</bold> - Equals (e.g., <italic>John</italic>)<br/>
                  <bold>!=</bold> - Not equal (e.g., <italic>!=John</italic>)<br/>
                  <bold>&gt;</bold> - Greater than (e.g., <italic>&gt;10</italic>)<br/>
                  <bold>&gt;=</bold> - Greater than or equal (e.g., <italic>&gt;=10</italic>)<br/>
                  <bold>&lt;</bold> - Less than (e.g., <italic>&lt;10</italic>)<br/>
                  <bold>&lt;=</bold> - Less than or equal (e.g., <italic>&lt;=10</italic>)<br/>
                  <bold>*text*</bold> - Contains (e.g., <italic>*world*</italic>)<br/>
                  <bold>text*</bold> - Starts with (e.g., <italic>hello*</italic>)<br/>
                  <bold>*text</bold> - Ends with (e.g., <italic>*world</italic>)<br/>
                  <bold>isNull</bold> - Is null<br/>
                  <bold>isNotNull</bold> - Is not null<br/><br/>
                  <bold>OR Queries:</bold><br/>
                  Separate multiple values with a comma for an OR query (e.g., <italic>John,Jane</italic>).''',
          tags: {
            'bold': StyledTextTag(
                style: const TextStyle(fontWeight: FontWeight.bold)),
            'italic': StyledTextTag(
                style: const TextStyle(fontStyle: FontStyle.italic)),
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showFindAndReplaceDialog() {
    String? selectedField;
    final findController = TextEditingController();
    final replaceController = TextEditingController();
    bool allPages = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Find and Replace'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: selectedField,
                    hint: const Text('Select Field'),
                    onChanged: (value) {
                      setState(() {
                        selectedField = value;
                      });
                    },
                    items: _queryControllers.keys
                        .where((key) =>
                            key != '\$id' &&
                            key != '\$createdAt' &&
                            key != '\$updatedAt')
                        .map((key) => DropdownMenuItem(
                              value: key,
                              child: Text(key),
                            ))
                        .toList(),
                  ),
                  TextField(
                    controller: findController,
                    decoration: const InputDecoration(labelText: 'Find'),
                  ),
                  TextField(
                    controller: replaceController,
                    decoration: const InputDecoration(labelText: 'Replace'),
                  ),
                  Row(
                    children: [
                      const Text('All Pages'),
                      Switch(
                        value: allPages,
                        onChanged: (value) {
                          setState(() {
                            allPages = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedField != null) {
                      final queries = _buildQueries();
                      context.push(Uri(
                        path: '/find_and_replace',
                        queryParameters: {
                          'database_id': widget.databaseId!,
                          'table_id': widget.tableId!,
                          'field': selectedField!,
                          'find': findController.text,
                          'replace': replaceController.text,
                          'all_pages': allPages.toString(),
                          'offset': _offset.toString(),
                          'limit': _limit.toString(),
                          'queries': queries,
                        },
                      ).toString());
                    }
                  },
                  child: const Text('Review...'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showMassDeleteDialog(int totalRows) {
    showDialog(
      context: context,
      builder: (context) {
        return MassDeleteDialog(
          totalRows: totalRows,
          onConfirm: () {
            _startMassDeleteTransaction();
          },
        );
      },
    );
  }

  void _startMassDeleteTransaction() {
    final queries = _buildQueries();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return MassDeleteTransactionDialog(
          databaseId: widget.databaseId!,
          tableId: widget.tableId!,
          queries: queries,
        );
      },
    ).then((success) {
      if (success == true) {
        _offset = 0;
        _loadRows(); // Reload data on success
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
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
              onPressed: () => context.go(
                  '/tables?database_id=${widget.databaseId}&database_name=${widget.databaseName}'),
            ),
            const Text('>'),
            const Icon(Icons.view_list),
            const SizedBox(width: 8),
            Text("Table: ${widget.tableName ?? ''}")
          ],
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _combinedFuture, // Use the combined future
        builder: (context, snapshot) {
          if (widget.databaseId == null || widget.tableId == null) {
            return const Center(child: Text('No table selected.'));
          }
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
          final rowList = snapshot.data![1] as models.RowList;
          final rows = rowList.rows;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Query by Example',
                            style: Theme.of(context).textTheme.titleLarge),
                        IconButton(
                          icon: const Icon(Icons.help_outline),
                          onPressed: _showHelpDialog,
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        ..._queryControllers.keys.map((key) {
                          final sort = _sorts.firstWhere(
                              (s) => s['field'] == key,
                              orElse: () => {});
                          final hasSort = sort.isNotEmpty;
                          final sortPriority = hasSort ? sort['priority'] : '';
                          final sortIcon = hasSort
                              ? sort['direction'] == 'asc'
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward
                              : Icons.sort;

                          return SizedBox(
                            width: 200,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _queryControllers[key],
                                    decoration: InputDecoration(labelText: key),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(sortIcon),
                                  onPressed: () => _toggleSort(key),
                                ),
                                if (hasSort) Text('$sortPriority'),
                              ],
                            ),
                          );
                        }).toList(),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: _applyFilters,
                          child:
                              const Text('Apply Filter/Sort'), // Renamed button
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _clearFilters,
                          child: const Text('Clear Filter/Sort'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _showFindAndReplaceDialog,
                          child: const Text('Find & Replace...'),
                        ),
                        if (featureFlagMassDelete) ...[
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: rowList.total > 0
                                ? () => _showMassDeleteDialog(rowList.total)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Mass Delete'),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: rows.length,
                  itemBuilder: (context, index) {
                    final row = rows[index];
                    final List<Map<String, dynamic>> allColumns = [
                      ...table.columns
                          .map((col) => col as Map<String, dynamic>),
                      {'\$id': '\$id', 'type': 'string'},
                      {'\$id': '\$createdAt', 'type': 'string'},
                      {'\$id': '\$updatedAt', 'type': 'string'},
                    ];
                    return RowWidget(
                      key: ValueKey(row.$id),
                      row: row,
                      columns: allColumns,
                      onUpdate: _updateRow,
                      onDelete: _deleteRow,
                      maxColumnWidths: _maxColumnWidths,
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: _offset > 0
                        ? () {
                            setState(() {
                              _offset -= _limit;
                            });
                            _saveState();
                            final queries = _buildQueries();
                            _loadRows(queries: queries);
                          }
                        : null,
                  ),
                  Text(
                      'Page ${(_offset / _limit).floor() + 1} of ${(rowList.total / _limit).ceil()}'),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: _offset + _limit < rowList.total
                        ? () {
                            setState(() {
                              _offset += _limit;
                            });
                            _saveState();
                            final queries = _buildQueries();
                            _loadRows(queries: queries);
                          }
                        : null,
                  ),
                  Text('Total: ${rowList.total}')
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

class MassDeleteDialog extends StatefulWidget {
  final int totalRows;
  final VoidCallback onConfirm;

  const MassDeleteDialog(
      {super.key, required this.totalRows, required this.onConfirm});

  @override
  State<MassDeleteDialog> createState() => _MassDeleteDialogState();
}

class _MassDeleteDialogState extends State<MassDeleteDialog> {
  final _controller = TextEditingController();
  bool _canDelete = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final enteredValue = int.tryParse(_controller.text);
      final canDelete = enteredValue == widget.totalRows;
      if (canDelete != _canDelete) {
        setState(() {
          _canDelete = canDelete;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Do you really want to DELETE multiple rows?'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            const Text('ALL the rows in the current query will be DELETED.'),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Type the total count of the rows',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        if (_canDelete)
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
              widget.onConfirm();
            },
            child: const Text('Delete'),
          ),
      ],
    );
  }
}

class MassDeleteTransactionDialog extends StatefulWidget {
  final String databaseId;
  final String tableId;
  final List<String> queries;

  const MassDeleteTransactionDialog({
    super.key,
    required this.databaseId,
    required this.tableId,
    required this.queries,
  });

  @override
  State<MassDeleteTransactionDialog> createState() =>
      _MassDeleteTransactionDialogState();
}

class _MassDeleteTransactionDialogState
    extends State<MassDeleteTransactionDialog> {
  String _status = "Preparing transaction...";
  String? _error;
  bool _isFinished = false;
  bool _isCancelled = false;
  models.Transaction? _tx;
  bool _canCancel = true;

  @override
  void initState() {
    super.initState();
    _runMassDeleteTransaction();
  }

  Future<List<models.Row>> _fetchAllRows() async {
    if (!mounted) return [];
    final appwriteNotifier =
        Provider.of<AppwriteNotifier>(context, listen: false);
    List<models.Row> allRows = [];
    int offset = 0;
    const limit = 100;

    while (true) {
      if (_isCancelled) break;
      final rowList = await appwriteNotifier.listRows(
        databaseId: widget.databaseId,
        tableId: widget.tableId,
        queries: [...widget.queries, Query.limit(limit), Query.offset(offset)],
      );
      allRows.addAll(rowList.rows);
      if (!mounted) return [];
      setState(() {
        _status = "Fetched ${allRows.length} rows...";
      });

      if (rowList.rows.length < limit) {
        break;
      }
      offset += limit;
    }
    return allRows;
  }

  Future<void> _runMassDeleteTransaction() async {
    if (!mounted) return;
    final appwriteNotifier =
        Provider.of<AppwriteNotifier>(context, listen: false);

    try {
      // 1. Fetch ALL rows
      setState(() {
        _status = "Fetching all rows to be deleted...";
      });
      if (_isCancelled) throw Exception("Cancelled by user.");
      final rowsToDelete = await _fetchAllRows();

      if (rowsToDelete.isEmpty) {
        if (!mounted) return;
        setState(() {
          _status = "No rows found to delete.";
          _isFinished = true;
        });
        return;
      }

      // 2. Create transaction
      if (!mounted) return;
      setState(() {
        _status = "Creating transaction...";
      });
      if (_isCancelled) throw Exception("Cancelled by user.");
      _tx = await appwriteNotifier.createTransaction();

      // 3. Stage delete operations
      if (!mounted) return;
      setState(() {
        _status = "Staging ${rowsToDelete.length} deletions...";
      });
      if (_isCancelled) throw Exception("Cancelled by user.");
      final operations = rowsToDelete
          .map((row) => {
                'action': 'delete',
                'databaseId': widget.databaseId,
                'tableId': widget.tableId,
                'rowId': row.$id,
              })
          .toList();

      const batchSize = 1000;
      for (int i = 0; i < operations.length; i += batchSize) {
        if (_isCancelled) throw Exception("Cancelled by user.");
        final batch = operations.sublist(
            i,
            i + batchSize > operations.length
                ? operations.length
                : i + batchSize);
        await appwriteNotifier.createOperations(
          transactionId: _tx!.$id,
          operations: batch,
        );
        if (!mounted) return;
        setState(() {
          _status =
              "Staged ${i + batch.length}/${rowsToDelete.length} deletions...";
        });
      }

      // 4. Commit with retry
      if (_isCancelled) throw Exception("Cancelled by user.");
      setState(() {
        _canCancel = false;
      }); // Cannot cancel during commit phase
      const maxRetries = 5;
      bool committed = false;
      for (int attempt = 0; attempt < maxRetries; attempt++) {
        if (_isCancelled) throw Exception("Cancelled by user.");
        try {
          if (!mounted) return;
          setState(() {
            _status =
                "Committing transaction (Attempt ${attempt + 1}/$maxRetries)...";
          });
          await appwriteNotifier.updateTransaction(
            transactionId: _tx!.$id,
            commit: true,
          );
          committed = true;
          break; // Success
        } on AppwriteException catch (e) {
          if (e.code == 400 && e.type == 'transaction_not_ready') {
            if (attempt + 1 >= maxRetries) {
              rethrow; // Max retries reached
            }
            final waitMs = 500 * (1 << attempt);
            if (!mounted) return;
            setState(() {
              _status =
                  "Waiting for transaction... (Attempt ${attempt + 1}/$maxRetries)";
            });
            await Future.delayed(Duration(milliseconds: waitMs));
          } else {
            rethrow;
          }
        }
      }

      if (committed) {
        if (!mounted) return;
        setState(() {
          _status = "Transaction Complete";
          _isFinished = true;
        });
      } else {
        throw Exception(
            "Transaction could not be committed after $maxRetries attempts.");
      }
    } catch (e) {
      if (!mounted) return;
      if (_isCancelled) {
        if (_tx != null) {
          await appwriteNotifier.updateTransaction(
              transactionId: _tx!.$id, rollback: true);
        }
        setState(() {
          _status = "Transaction Cancelled.";
          _error = null;
        });
      } else {
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
    if (!_canCancel) return;
    setState(() {
      _isCancelled = true;
      _status = "Cancelling...";
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Processing Mass Deletion'),
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
              Navigator.of(context).pop(_status == "Transaction Complete");
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
