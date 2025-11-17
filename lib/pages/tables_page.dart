import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quade/main.dart';
import 'package:quade/models/appwrite_models.dart';

class TablesPage extends StatefulWidget {
  const TablesPage({super.key, this.databaseId, this.databaseName});

  final String? databaseId;
  final String? databaseName;

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  Future<CustomTableList>? _tablesFuture;

  @override
  void initState() {
    super.initState();
    _loadTables();
  }

  @override
  void didUpdateWidget(covariant TablesPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.databaseId != widget.databaseId ||
        oldWidget.databaseName != widget.databaseName) {
      _loadTables();
    }
  }

  void _loadTables() {
    if (widget.databaseId == null) return;
    final appwriteNotifier =
        Provider.of<AppwriteNotifier>(context, listen: false);
    setState(() {
      _tablesFuture = appwriteNotifier.listTables(widget.databaseId!);
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
            const Icon(Icons.table_chart),
          ],
        ),
      ),
      body: FutureBuilder<CustomTableList>(
        future: _tablesFuture,
        builder: (context, snapshot) {
          if (widget.databaseId == null) {
            return const Center(child: Text('No database selected.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.tables.isEmpty) {
            return const Center(child: Text('No tables found.'));
          }

          final tables = snapshot.data!.tables;
          return ListView.builder(
            itemCount: tables.length,
            itemBuilder: (context, index) {
              final table = tables[index];
              return ListTile(
                title: Text(table.name),
                subtitle: Text(table.$id),
                onTap: () {
                  context.go(
                      '/table?database_id=${widget.databaseId}&database_name=${widget.databaseName}&table_id=${table.$id}&table_name=${table.name}');
                },
              );
            },
          );
        },
      ),
    );
  }
}
