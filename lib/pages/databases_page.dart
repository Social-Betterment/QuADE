import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quade/main.dart';
import 'package:dart_appwrite/models.dart' as models;

class DatabasesPage extends StatefulWidget {
  const DatabasesPage({super.key, this.projectId});

  final String? projectId;

  @override
  State<DatabasesPage> createState() => _DatabasesPageState();
}

class _DatabasesPageState extends State<DatabasesPage> {
  String? _currentProjectId;
  Future<models.DatabaseList>? _databasesFuture;

  @override
  void initState() {
    super.initState();
    _currentProjectId = widget.projectId;
    _loadDatabases();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appwriteNotifier = Provider.of<AppwriteNotifier>(context);
    // A simple way to check if the client has been updated.
    // A more robust solution might involve a dedicated property in the notifier.
    if (appwriteNotifier.client?.endPoint != _currentProjectId) {
      _loadDatabases();
    }
  }

  void _loadDatabases() {
    final appwriteNotifier =
        Provider.of<AppwriteNotifier>(context, listen: false);
    if (appwriteNotifier.client != null) {
      setState(() {
        _databasesFuture = appwriteNotifier.listDatabases();
        _currentProjectId = appwriteNotifier.client!.endPoint;
      });
    }
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
            const Icon(Icons.storage),
            const SizedBox(width: 8),
            const Text("Databases")
          ],
        ),
      ),
      body: FutureBuilder<models.DatabaseList>(
        future: _databasesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.databases.isEmpty) {
            return const Center(child: Text('No databases found.'));
          }

          final databases = snapshot.data!.databases;
          return ListView.builder(
            itemCount: databases.length,
            itemBuilder: (context, index) {
              final database = databases[index];
              return ListTile(
                title: Text(database.name),
                subtitle: Text(database.$id),
                onTap: () {
                  context.go(
                      '/tables?database_id=${database.$id}&database_name=${database.name}');
                },
              );
            },
          );
        },
      ),
    );
  }
}
