Here is the Markdown conversion of the HTML file, focusing on the main article content.

# Transactions

Transactions let you stage multiple database operations and apply them together, atomically. [cite\_start]Use transactions to keep related changes consistent, even when they span multiple databases and tables. [cite: 51]

## How transactions work

1.  Call the `createTransaction` method to create a transaction. [cite\_start]This will return a transaction model, including its ID. [cite: 51, 52]
2.  [cite\_start]Stage operations by passing the `transactionId` parameter to supported row, bulk, and atomic numeric methods. [cite: 52] [cite\_start]You can stage many operations at once with the `createOperations` method. [cite: 52, 53]
3.  [cite\_start]Call the `updateTransaction` method to commit or roll back. [cite: 53]

On commit, Appwrite replays all staged logs in order inside a real database transaction. Staged operations see earlier staged changes (read your own writes). [cite\_start]If any affected row changed outside your transaction, the commit fails with a conflict. [cite: 54]

> **Scope and limitations**
>
> You can stage operations across any database and table within the same transaction. [cite\_start]Schema operations (for example, adding or removing columns) are not included in transactions. [cite: 55]

## Limits

[cite\_start]The maximum number of operations you can stage per transaction depends on your plan: [cite: 56]

| Plan | Max operations per transaction |
| :--- | :--- |
| Free | 100 |
| Pro | 1,000 |
| Scale | 2,500 |

[cite\_start][cite: 57, 58]

## Create a transaction

[cite\_start]Call the `createTransaction` method to begin. [cite: 59] [cite\_start]It returns a transaction model that includes `$id`. [cite: 59] [cite\_start]Pass this ID as `transactionId` to subsequent operations. [cite: 59]

```dart
import 'package:appwrite/appwrite.dart';

final client = Client()
  .setEndpoint('https://<REGION>.cloud.appwrite.io/v1')
  .setProject('<PROJECT_ID>');

final tablesDB = TablesDB(client);

final tx = await tablesDB.createTransaction();
// tx.$id is your transactionId
```

[cite\_start][cite: 63]

## Stage operations

[cite\_start]Add the `transactionId` parameter to supported methods to stage them instead of immediately persisting. [cite: 64]

[cite\_start]When you pass `transactionId`, Appwrite writes the operation to an internal staging area. [cite: 65] [cite\_start]The target table is not modified until you commit the transaction. [cite: 65]

### Stage single operations

[cite\_start]Create, update, upsert, delete, and atomic numeric operations accept `transactionId`, as well as their bulk versions (createRows, updateRows, upsertRows, deleteRows). [cite: 66]

```dart
// Create inside a transaction
await tablesDB.createRow(
  databaseId: '<DATABASE_ID>',
  tableId: '<TABLE_ID>',
  rowId: '<ROW_ID>',
  [cite_start]data: { 'name': 'Walter' }, [cite: 70]
  transactionId: tx.$id
);

// Increment inside a transaction
await tablesDB.incrementRowColumn(
  databaseId: '<DATABASE_ID>',
  tableId: '<TABLE_ID>',
  [cite_start]rowId: '<ROW_ID>', [cite: 71]
  column: 'credits',
  value: 1,
  transactionId: tx.$id
);
```

[cite\_start][cite: 69]

### Stage many with createOperations

[cite\_start]Use the `createOperations` method to stage multiple operations across databases and tables in a single request. [cite: 72] [cite\_start]Provide an array of operation objects: [cite: 72]

```json
[
  {
    [cite_start]"action": "create|update|upsert|increment|decrement|delete|bulkCreate|bulkUpdate|bulkUpsert|bulkDelete", [cite: 74]
    "databaseId": "<DATABASE_ID>",
    "tableId|collectionId": "<TABLE_ID|COLLECTION_ID>",
    [cite_start]"rowId|documentId": "<ROW_ID|DOCUMENT_ID>", [cite: 75]
    "data": {}
  }
]
```

#### [cite\_start]Provide data for each action (createOperations) [cite: 76]

#### Create, update, and upsert

Pass a raw data object.

```json
{ "name": "Walter" }
```

[cite\_start][cite: 78]

#### Increment and decrement

Pass a value and optionally `min`/`max` bounds.

```json
{ "value": 1, "min": 0, "max": 1000, "column": "<COLUMN_NAME>" }
```

[cite\_start][cite: 80]

#### Bulk create and bulk upsert

Pass an array of raw data objects.

```json
[{ "$id": "123", "name": "Walter" }]
```

[cite\_start][cite: 82]

#### Bulk update

[cite\_start]Pass queries and the data to apply. [cite: 83]

```json
{ "queries": [{"method": "equal", "attribute": "status", "values": ["draft"]}], "data": { "status": "published" } }
```

[cite\_start][cite: 85]

#### Bulk delete

[cite\_start]Pass queries to select rows to delete. [cite: 86]

```json
{ "queries": [{"method": "equal", "attribute": "archived", "values": [true]}] }
```

[cite\_start][cite: 88]

```dart
await tablesDB.createOperations(
  transactionId: tx.$id,
  operations: [
    {
      [cite_start]'action': 'create', [cite: 92]
      'databaseId': '<DB_A>',
      'tableId': '<TABLE_1>',
      [cite_start]'rowId': 'u1', [cite: 93]
      'data': { 'name': 'Walter' }
    },
    [cite_start]{ [cite: 94]
      'action': 'increment',
      'databaseId': '<DB_B>',
      [cite_start]'tableId': '<TABLE_2>', [cite: 95]
      'rowId': 'u2',
      [cite_start]'data': { 'value': 1, 'min': 0, 'column': 'credits' } [cite: 96]
    }
  ],
);
```

## Commit or roll back

[cite\_start]When you are done staging operations, call the `updateTransaction` method to finalize the transaction. [cite: 97]

```dart
// Commit
await tablesDB.updateTransaction(
  transactionId: tx.$id,
  commit: true
);

// Roll back
await tablesDB.updateTransaction(
  transactionId: tx.$id,
  rollback: true
);
```

[cite\_start][cite: 100, 101]

## Handle conflicts

On commit, Appwrite verifies that rows affected by your transaction haven’t changed externally since they were staged. [cite\_start]If a conflicting change is detected, the commit fails with a conflict error. [cite: 102] [cite\_start]Resolve the conflict (for example, refetch and re-stage) and try again. [cite: 102]

> **Best practices**
>
> Keep transactions short-lived to reduce the likelihood of conflicts. Stage related updates in the order they must be applied. [cite\_start]Prefer `createOperations` when you need to stage many changes across multiple tables. [cite: 103]