import 'package:go_router/go_router.dart';
import 'package:quade/pages/configs_page.dart';
import 'package:quade/pages/databases_page.dart';
import 'package:quade/pages/find_and_replace_page.dart';
import 'package:quade/pages/table_page.dart';
import 'package:quade/pages/tables_page.dart';

final router = GoRouter(
  initialLocation: '/configs',
  routes: [
    GoRoute(
      path: '/configs',
      builder: (context, state) => const ConfigsPage(),
    ),
    GoRoute(
      path: '/databases',
      builder: (context, state) {
        final projectId = state.uri.queryParameters['project_id'];
        return DatabasesPage(projectId: projectId);
      },
    ),
    GoRoute(
      path: '/tables',
      builder: (context, state) {
        final databaseId = state.uri.queryParameters['database_id'];
        final databaseName = state.uri.queryParameters['database_name'];
        return TablesPage(databaseId: databaseId, databaseName: databaseName);
      },
    ),
    GoRoute(
      path: '/table',
      builder: (context, state) {
        final databaseId = state.uri.queryParameters['database_id'];
        final tableId = state.uri.queryParameters['table_id'];
        final databaseName = state.uri.queryParameters['database_name'];
        final tableName = state.uri.queryParameters['table_name'];
        return TablePage(
          databaseId: databaseId,
          tableId: tableId,
          databaseName: databaseName,
          tableName: tableName,
        );
      },
    ),
    GoRoute(
      path: '/find_and_replace',
      builder: (context, state) {
        final databaseId = state.uri.queryParameters['database_id'];
        final tableId = state.uri.queryParameters['table_id'];
        final field = state.uri.queryParameters['field'];
        final find = state.uri.queryParameters['find'];
        final replace = state.uri.queryParameters['replace'];
        final allPages = state.uri.queryParameters['all_pages'] == 'true';
        final queries = state.uri.queryParametersAll['queries'];
        final offset = int.tryParse(state.uri.queryParameters['offset'] ?? '0');
        final limit = int.tryParse(state.uri.queryParameters['limit'] ?? '25');
        return FindAndReplacePage(
          databaseId: databaseId,
          tableId: tableId,
          field: field,
          find: find,
          replace: replace,
          allPages: allPages,
          queries: queries,
          offset: offset,
          limit: limit,
        );
      },
    ),
  ],
);
