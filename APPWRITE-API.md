# TablesDB `SERVER`

**Platform:** `Dart`
**Version:** `Cloud`

The TablesDB service allows you to create structured tables of rows, query and filter lists of rows, and manage an
advanced set of read and write access permissions.

All data returned by the TablesDB service are represented as structured JSON rows.

The TablesDB service can contain multiple databases, each database can contain multiple tables. A table is a group of
similarly structured rows. The accepted structure of rows is defined
by [table columns](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/tables%23columns). The table columns help you ensure all your user-submitted
data is validated and stored according to the table structure.

Using Appwrite permissions architecture, you can assign read or write access to each table or row in your project for
either a specific user, team, user role, or even grant it with public access (`any`). You can learn more
about [how Appwrite handles permissions and access control](https://appwrite.io/docs/products/databases/permissions).

```text
Base URL
https://<REGION>.cloud.appwrite.io/v1
```

## On This Page

### tablesdb

  * [Create database](https://www.google.com/search?q=%23create)
  * [Get database](https://www.google.com/search?q=%23get)
  * [List databases](https://www.google.com/search?q=%23list)
  * [Update database](https://www.google.com/search?q=%23update)
  * [Delete database](https://www.google.com/search?q=%23delete)

### tables

  * [Create table](https://www.google.com/search?q=%23createTable)
  * [Get table](https://www.google.com/search?q=%23getTable)
  * [List tables](https://www.google.com/search?q=%23listTables)
  * [Update table](https://www.google.com/search?q=%23updateTable)
  * [Delete table](https://www.google.com/search?q=%23deleteTable)

### columns

  * [Create boolean column](https://www.google.com/search?q=%23createBooleanColumn)
  * [Create datetime column](https://www.google.com/search?q=%23createDatetimeColumn)
  * [Create email column](https://www.google.com/search?q=%23createEmailColumn)
  * [Create enum column](https://www.google.com/search?q=%23createEnumColumn)
  * [Create float column](https://www.google.com/search?q=%23createFloatColumn)
  * [Create integer column](https://www.google.com/search?q=%23createIntegerColumn)
  * [Create IP address column](https://www.google.com/search?q=%23createIpColumn)
  * [Create line column](https://www.google.com/search?q=%23createLineColumn)
  * [Create point column](https://www.google.com/search?q=%23createPointColumn)
  * [Create polygon column](https://www.google.com/search?q=%23createPolygonColumn)
  * [Create relationship column](https://www.google.com/search?q=%23createRelationshipColumn)
  * [Create string column](https://www.google.com/search?q=%23createStringColumn)
  * [Create URL column](https://www.google.com/search?q=%23createUrlColumn)
  * [Get column](https://www.google.com/search?q=%23getColumn)
  * [List columns](https://www.google.com/search?q=%23listColumns)
  * [Update boolean column](https://www.google.com/search?q=%23updateBooleanColumn)
  * [Update dateTime column](https://www.google.com/search?q=%23updateDatetimeColumn)
  * [Update email column](https://www.google.com/search?q=%23updateEmailColumn)
  * [Update enum column](https://www.google.com/search?q=%23updateEnumColumn)
  * [Update float column](https://www.google.com/search?q=%23updateFloatColumn)
  * [Update integer column](https://www.google.com/search?q=%23updateIntegerColumn)
  * [Update IP address column](https://www.google.com/search?q=%23updateIpColumn)
  * [Update line column](https://www.google.com/search?q=%23updateLineColumn)
  * [Update point column](https://www.google.com/search?q=%23updatePointColumn)
  * [Update polygon column](https://www.google.com/search?q=%23updatePolygonColumn)
  * [Update relationship column](https://www.google.com/search?q=%23updateRelationshipColumn)
  * [Update string column](https://www.google.com/search?q=%23updateStringColumn)
  * [Update URL column](https://www.google.com/search?q=%23updateUrlColumn)
  * [Delete column](https://www.google.com/search?q=%23deleteColumn)

### indexes

  * [Create index](https://www.google.com/search?q=%23createIndex)
  * [Get index](https://www.google.com/search?q=%23getIndex)
  * [List indexes](https://www.google.com/search?q=%23listIndexes)
  * [Delete index](https://www.google.com/search?q=%23deleteIndex)

### rows

  * [Create row](https://www.google.com/search?q=%23createRow)
  * [Create rows](https://www.google.com/search?q=%23createRows)
  * [Get row](https://www.google.com/search?q=%23getRow)
  * [List rows](https://www.google.com/search?q=%23listRows)
  * [Update row](https://www.google.com/search?q=%23updateRow)
  * [Update rows](https://www.google.com/search?q=%23updateRows)
  * [Upsert a row](https://www.google.com/search?q=%23upsertRow)
  * [Upsert rows](https://www.google.com/search?q=%23upsertRows)
  * [Delete row](https://www.google.com/search?q=%23deleteRow)
  * [Delete rows](https://www.google.com/search?q=%23deleteRows)
  * [Increment row column](https://www.google.com/search?q=%23incrementRowColumn)
  * [Decrement row column](https://www.google.com/search?q=%23decrementRowColumn)

### transactions

  * [Create operations](https://www.google.com/search?q=%23createOperations)
  * [Create transaction](https://www.google.com/search?q=%23createTransaction)
  * [Get transaction](https://www.google.com/search?q=%23getTransaction)
  * [List transactions](https://www.google.com/search?q=%23listTransactions)
  * [Update transaction](https://www.google.com/search?q=%23updateTransaction)
  * [Delete transaction](https://www.google.com/search?q=%23deleteTransaction)

-----

## tablesdb

### Create database

Create a new Database.

**Request**

  * `databaseId` (string, **required**): Unique Id. Choose a custom ID or generate a random ID with `ID.unique()`. Valid chars are a-z, A-Z, 0-9, period, hyphen, and underscore. Can't start with a special char. Max length is 36 chars.
  * `name` (string, **required**): Database name. Max length: 128 chars.
  * `enabled` (boolean): Is the database enabled? When set to 'disabled', users cannot access the database but Server SDKs with an API key can still read and write to the database. No data is lost when this is toggled.

**Response**

  * **201** (application/json): [Database](https://appwrite.io/docs/references/cloud/models/database)

<!-- end list -->

```text
Endpoint
POST /tablesdb
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

Database result = await tablesDB.create(
    databaseId: '<DATABASE_ID>',
    name: '<NAME>',
    enabled: false, // (optional)
);
```

### Get database

Get a database by its unique ID. This endpoint response returns a JSON object with the database metadata.

**Request**

  * `databaseId` (string, **required**): Database ID.

**Response**

  * **200** (application/json): [Database](https://appwrite.io/docs/references/cloud/models/database)

<!-- end list -->

```text
Endpoint
GET /tablesdb/{databaseId}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

Database result = await tablesDB.get(
    databaseId: '<DATABASE_ID>',
);
```

### List databases

Get a list of all databases from the current Appwrite project. You can use the search parameter to filter your results.

**Request**

  * `queries` (array): Array of query strings generated using the Query class provided by the SDK. [Learn more about queries](https://appwrite.io/docs/queries). Maximum of 100 queries are allowed, each 4096 characters long. You may filter on the following columns: name
  * `search` (string): Search term to filter your list results. Max length: 256 chars.

**Response**

  * **200** (application/json): [Databases List](https://appwrite.io/docs/references/cloud/models/databaseList)

<!-- end list -->

```text
Endpoint
GET /tablesdb
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

DatabaseList result = await tablesDB.list(
    queries: [], // (optional)
    search: '<SEARCH>', // (optional)
);
```

### Update database

Update a database by its unique ID.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `name` (string, **required**): Database name. Max length: 128 chars.
  * `enabled` (boolean): Is database enabled? When set to 'disabled', users cannot access the database but Server SDKs with an API key can still read and write to the database. No data is lost when this is toggled.

**Response**

  * **200** (application/json): [Database](https://appwrite.io/docs/references/cloud/models/database)

<!-- end list -->

```text
Endpoint
PUT /tablesdb/{databaseId}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

Database result = await tablesDB.update(
    databaseId: '<DATABASE_ID>',
    name: '<NAME>',
    enabled: false, // (optional)
);
```

### Delete database

Delete a database by its unique ID. Only API keys with with databases.write scope can delete a database.

**Request**

  * `databaseId` (string, **required**): Database ID.

**Response**

  * **204** (no content)

<!-- end list -->

```text
Endpoint
DELETE /tablesdb/{databaseId}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

await tablesDB.delete(
    databaseId: '<DATABASE_ID>',
);
```

-----

## tables

### Create table

Create a new Table. Before using this route, you should create a new database resource using either a [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable) API or directly from your database console.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Unique Id. Choose a custom ID or generate a random ID with `ID.unique()`. Valid chars are a-z, A-Z, 0-9, period, hyphen, and underscore. Can't start with a special char. Max length is 36 chars.
  * `name` (string, **required**): Table name. Max length: 128 chars.
  * `permissions` (array): An array of permissions strings. By default, no user is granted with any permissions. [Learn more about permissions](https://appwrite.io/docs/permissions).
  * `rowSecurity` (boolean): Enables configuring permissions for individual rows. A user needs one of row or table level permissions to access a row. [Learn more about permissions](https://appwrite.io/docs/permissions).
  * `enabled` (boolean): Is table enabled? When set to 'disabled', users cannot access the table but Server SDKs with and API key can still read and write to the table. No data is lost when this is toggled.

**Response**

  * **201** (application/json): [Table](https://appwrite.io/docs/references/cloud/models/table)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/permission.dart';
import 'package:dart_appwrite/role.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

Table result = await tablesDB.createTable(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    name: '<NAME>',
    permissions: [Permission.read(Role.any())], // (optional)
    rowSecurity: false, // (optional)
    enabled: false, // (optional)
);
```

### Get table

Get a table by its unique ID. This endpoint response returns a JSON object with the table metadata.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.

**Response**

  * **200** (application/json): [Table](https://appwrite.io/docs/references/cloud/models/table)

<!-- end list -->

```text
Endpoint
GET /tablesdb/{databaseId}/tables/{tableId}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

Table result = await tablesDB.getTable(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
);
```

### List tables

Get a list of all tables that belong to the provided databaseId. You can use the search parameter to filter your results.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `queries` (array): Array of query strings generated using the Query class provided by the SDK. [Learn more about queries](https://appwrite.io/docs/queries). Maximum of 100 queries are allowed, each 4096 characters long. You may filter on the following columns: name, enabled, rowSecurity
  * `search` (string): Search term to filter your list results. Max length: 256 chars.

**Response**

  * **200** (application/json): [Tables List](https://appwrite.io/docs/references/cloud/models/tableList)

<!-- end list -->

```text
Endpoint
GET /tablesdb/{databaseId}/tables
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

TableList result = await tablesDB.listTables(
    databaseId: '<DATABASE_ID>',
    queries: [], // (optional)
    search: '<SEARCH>', // (optional)
);
```

### Update table

Update a table by its unique ID.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `name` (string, **required**): Table name. Max length: 128 chars.
  * `permissions` (array): An array of permission strings. By default, the current permissions are inherited. [Learn more about permissions](https://appwrite.io/docs/permissions).
  * `rowSecurity` (boolean): Enables configuring permissions for individual rows. A user needs one of row or table level permissions to access a document. [Learn more about permissions](https://appwrite.io/docs/permissions).
  * `enabled` (boolean): Is table enabled? When set to 'disabled', users cannot access the table but Server SDKs with and API key can still read and write to the table. No data is lost when this is toggled.

**Response**

  * **200** (application/json): [Table](https://appwrite.io/docs/references/cloud/models/table)

<!-- end list -->

```text
Endpoint
PUT /tablesdb/{databaseId}/tables/{tableId}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/permission.dart';
import 'package:dart_appwrite/role.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

Table result = await tablesDB.updateTable(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    name: '<NAME>',
    permissions: [Permission.read(Role.any())], // (optional)
    rowSecurity: false, // (optional)
    enabled: false, // (optional)
);
```

### Delete table

Delete a table by its unique ID. Only users with write permissions have access to delete this resource.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.

**Response**

  * **204** (no content)

<!-- end list -->

```text
Endpoint
DELETE /tablesdb/{databaseId}/tables/{tableId}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

await tablesDB.deleteTable(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
);
```

-----

## columns

### Create boolean column

Create a boolean column.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the Database service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (boolean): Default value for column when not provided. Cannot be set when column is required.
  * `array` (boolean): Is column an array?

**Response**

  * **202** (application/json): [ColumnBoolean](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnBoolean)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/columns/boolean
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnBoolean result = await tablesDB.createBooleanColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: false, // (optional)
    array: false, // (optional)
);
```

### Create datetime column

Create a date time column according to the ISO 8601 standard.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (string): Default value for the column in [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format. Cannot be set when column is required.
  * `array` (boolean): Is column an array?

**Response**

  * **202** (application/json): [ColumnDatetime](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnDatetime)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/columns/datetime
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnDatetime result = await tablesDB.createDatetimeColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: '', // (optional)
    array: false, // (optional)
);
```

### Create email column

Create an email column.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (string): Default value for column when not provided. Cannot be set when column is required.
  * `array` (boolean): Is column an array?

**Response**

  * **202** (application/json): [ColumnEmail](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnEmail)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/columns/email
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnEmail result = await tablesDB.createEmailColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: 'email@example.com', // (optional)
    array: false, // (optional)
);
```

### Create enum column

Create an enumeration column. The `elements` param acts as a white-list of accepted values for this column.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `elements` (array, **required**): Array of enum values.
  * `required` (boolean, **required**): Is column required?
  * `default` (string): Default value for column when not provided. Cannot be set when column is required.
  * `array` (boolean): Is column an array?

**Response**

  * **202** (application/json): [ColumnEnum](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnEnum)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/columns/enum
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnEnum result = await tablesDB.createEnumColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    elements: [],
    xrequired: false,
    xdefault: '<DEFAULT>', // (optional)
    array: false, // (optional)
);
```

### Create float column

Create a float column. Optionally, minimum and maximum values can be provided.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `min` (number): Minimum value
  * `max` (number): Maximum value
  * `default` (number): Default value. Cannot be set when required.
  * `array` (boolean): Is column an array?

**Response**

  * **202** (application/json): [ColumnFloat](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnFloat)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/columns/float
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnFloat result = await tablesDB.createFloatColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    min: 0, // (optional)
    max: 0, // (optional)
    xdefault: 0, // (optional)
    array: false, // (optional)
);
```

### Create integer column

Create an integer column. Optionally, minimum and maximum values can be provided.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `min` (integer): Minimum value
  * `max` (integer): Maximum value
  * `default` (integer): Default value. Cannot be set when column is required.
  * `array` (boolean): Is column an array?

**Response**

  * **202** (application/json): [ColumnInteger](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnInteger)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/columns/integer
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnInteger result = await tablesDB.createIntegerColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    min: 0, // (optional)
    max: 0, // (optional)
    xdefault: 0, // (optional)
    array: false, // (optional)
);
```

### Create IP address column

Create IP address column.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (string): Default value. Cannot be set when column is required.
  * `array` (boolean): Is column an array?

**Response**

  * **202** (application/json): [ColumnIP](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnIp)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/columns/ip
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnIp result = await tablesDB.createIpColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: '', // (optional)
    array: false, // (optional)
);
```

### Create line column

Create a geometric line column.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the TablesDB service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (array): Default value for column when not provided, two-dimensional array of coordinate pairs, [[longitude, latitude], [longitude, latitude], …], listing the vertices of the line in order. Cannot be set when column is required.

**Response**

  * **202** (application/json): [ColumnLine](https://appwrite.io/docs/references/cloud/models/columnLine)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/columns/line
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnLine result = await tablesDB.createLineColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: [[1, 2], [3, 4], [5, 6]], // (optional)
);
```

### Create point column

Create a geometric point column.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the TablesDB service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (array): Default value for column when not provided, array of two numbers [longitude, latitude], representing a single coordinate. Cannot be set when column is required.

**Response**

  * **202** (application/json): [ColumnPoint](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnPoint)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/columns/point
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnPoint result = await tablesDB.createPointColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: [1, 2], // (optional)
);
```

### Create polygon column

Create a geometric polygon column.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the TablesDB service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (array): Default value for column when not provided, three-dimensional array where the outer array holds one or more linear rings, [[[longitude, latitude], …], …], the first ring is the exterior boundary, any additional rings are interior holes, and each ring must start and end with the same coordinate pair. Cannot be set when column is required.

**Response**

  * **202** (application/json): [ColumnPolygon](https://appwrite.io/docs/references/cloud/models/columnPolygon)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/columns/polygon
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnPolygon result = await tablesDB.createPolygonColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: [[[1, 2], [3, 4], [5, 6], [1, 2]]], // (optional)
);
```

### Create relationship column

Create relationship column. [Learn more about relationship columns](https://appwrite.io/docs/databases-relationships#relationship-columns).

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `relatedTableId` (string, **required**): Related Table ID.
  * `type` (string, **required**): Relation type
  * `twoWay` (boolean): Is Two Way?
  * `key` (string): Column Key.
  * `twoWayKey` (string): Two Way Column Key.
  * `onDelete` (string): Constraints option

**Response**

  * **202** (application/json): [ColumnRelationship](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnRelationship)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/columns/relationship
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnRelationship result = await tablesDB.createRelationshipColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    relatedTableId: '<RELATED_TABLE_ID>',
    type: RelationshipType.oneToOne,
    twoWay: false, // (optional)
    key: '', // (optional)
    twoWayKey: '', // (optional)
    onDelete: RelationMutate.cascade, // (optional)
);
```

### Create string column

Create a string column.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the Database service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `key` (string, **required**): Column Key.
  * `size` (integer, **required**): Column size for text columns, in number of characters.
  * `required` (boolean, **required**): Is column required?
  * `default` (string): Default value for column when not provided. Cannot be set when column is required.
  * `array` (boolean): Is column an array?
  * `encrypt` (boolean): Toggle encryption for the column. Encryption enhances security by not storing any plain text values in the database. However, encrypted columns cannot be queried.

**Response**

  * **202** (application/json): [ColumnString](https://appwrite.io/docs/references/cloud/models/columnString)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/columns/string
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnString result = await tablesDB.createStringColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    size: 1,
    xrequired: false,
    xdefault: '<DEFAULT>', // (optional)
    array: false, // (optional)
    encrypt: false, // (optional)
);
```

### Create URL column

Create a URL column.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (string): Default value for column when not provided. Cannot be set when column is required.
  * `array` (boolean): Is column an array?

**Response**

  * **202** (application/json): [ColumnURL](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnUrl)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/columns/url
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnUrl result = await tablesDB.createUrlColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: 'https://example.com', // (optional)
    array: false, // (optional)
);
```

### Get column

Get column by ID.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.

**Response**

  * **200** (application/json): [ColumnBoolean](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnBoolean), [ColumnInteger](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnInteger), [ColumnFloat](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnFloat), [ColumnEmail](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnEmail), [ColumnEnum](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnEnum), [ColumnURL](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnUrl), [ColumnIP](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnIp), [ColumnDatetime](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnDatetime), [ColumnRelationship](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnRelationship), [ColumnString](https://appwrite.io/docs/references/cloud/models/columnString)

<!-- end list -->

```text
Endpoint
GET /tablesdb/{databaseId}/tables/{tableId}/columns/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

 result = await tablesDB.getColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
);
```

### List columns

List columns in the table.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `queries` (array): Array of query strings generated using the Query class provided by the SDK. [Learn more about queries](https://appwrite.io/docs/queries). Maximum of 100 queries are allowed, each 4096 characters long. You may filter on the following columns: key, type, size, required, array, status, error

**Response**

  * **200** (application/json): [Columns List](https://appwrite.io/docs/references/cloud/models/columnList)

<!-- end list -->

```text
Endpoint
GET /tablesdb/{databaseId}/tables/{tableId}/columns
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnList result = await tablesDB.listColumns(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    queries: [], // (optional)
);
```

### Update boolean column

Update a boolean column. Changing the `default` value will not update already existing rows.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the Database service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (boolean, **required**): Default value for column when not provided. Cannot be set when column is required.
  * `newKey` (string): New Column Key.

**Response**

  * **200** (application/json): [ColumnBoolean](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnBoolean)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/columns/boolean/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnBoolean result = await tablesDB.updateBooleanColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: false,
    newKey: '', // (optional)
);
```

### Update dateTime column

Update a date time column. Changing the `default` value will not update already existing rows.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (string, **required**): Default value for column when not provided. Cannot be set when column is required.
  * `newKey` (string): New Column Key.

**Response**

  * **200** (application/json): [ColumnDatetime](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnDatetime)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/columns/datetime/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnDatetime result = await tablesDB.updateDatetimeColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: '',
    newKey: '', // (optional)
);
```

### Update email column

Update an email column. Changing the `default` value will not update already existing rows.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (string, **required**): Default value for column when not provided. Cannot be set when column is required.
  * `newKey` (string): New Column Key.

**Response**

  * **200** (application/json): [ColumnEmail](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnEmail)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/columns/email/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnEmail result = await tablesDB.updateEmailColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: 'email@example.com',
    newKey: '', // (optional)
);
```

### Update enum column

Update an enum column. Changing the `default` value will not update already existing rows.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `elements` (array, **required**): Updated list of enum values.
  * `required` (boolean, **required**): Is column required?
  * `default` (string, **required**): Default value for column when not provided. Cannot be set when column is required.
  * `newKey` (string): New Column Key.

**Response**

  * **200** (application/json): [ColumnEnum](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnEnum)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/columns/enum/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnEnum result = await tablesDB.updateEnumColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    elements: [],
    xrequired: false,
    xdefault: '<DEFAULT>',
    newKey: '', // (optional)
);
```

### Update float column

Update a float column. Changing the `default` value will not update already existing rows.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (number, **required**): Default value. Cannot be set when required.
  * `min` (number): Minimum value
  * `max` (number): Maximum value
  * `newKey` (string): New Column Key.

**Response**

  * **200** (application/json): [ColumnFloat](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnFloat)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/columns/float/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnFloat result = await tablesDB.updateFloatColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: 0,
    min: 0, // (optional)
    max: 0, // (optional)
    newKey: '', // (optional)
);
```

### Update integer column

Update an integer column. Changing the `default` value will not update already existing rows.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (integer, **required**): Default value. Cannot be set when column is required.
  * `min` (integer): Minimum value
  * `max` (integer): Maximum value
  * `newKey` (string): New Column Key.

**Response**

  * **200** (application/json): [ColumnInteger](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnInteger)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/columns/integer/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnInteger result = await tablesDB.updateIntegerColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: 0,
    min: 0, // (optional)
    max: 0, // (optional)
    newKey: '', // (optional)
);
```

### Update IP address column

Update an ip column. Changing the `default` value will not update already existing rows.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (string, **required**): Default value. Cannot be set when column is required.
  * `newKey` (string): New Column Key.

**Response**

  * **200** (application/json): [ColumnIP](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnIp)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/columns/ip/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnIp result = await tablesDB.updateIpColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: '',
    newKey: '', // (optional)
);
```

### Update line column

Update a line column. Changing the `default` value will not update already existing rows.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the TablesDB service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (array): Default value for column when not provided, two-dimensional array of coordinate pairs, [[longitude, latitude], [longitude, latitude], …], listing the vertices of the line in order. Cannot be set when column is required.
  * `newKey` (string): New Column Key.

**Response**

  * **200** (application/json): [ColumnLine](https://appwrite.io/docs/references/cloud/models/columnLine)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/columns/line/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnLine result = await tablesDB.updateLineColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: [[1, 2], [3, 4], [5, 6]], // (optional)
    newKey: '', // (optional)
);
```

### Update point column

Update a point column. Changing the `default` value will not update already existing rows.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the TablesDB service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (array): Default value for column when not provided, array of two numbers [longitude, latitude], representing a single coordinate. Cannot be set when column is required.
  * `newKey` (string): New Column Key.

**Response**

  * **200** (application/json): [ColumnPoint](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnPoint)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/columns/point/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnPoint result = await tablesDB.updatePointColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: [1, 2], // (optional)
    newKey: '', // (optional)
);
```

### Update polygon column

Update a polygon column. Changing the `default` value will not update already existing rows.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the TablesDB service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (array): Default value for column when not provided, three-dimensional array where the outer array holds one or more linear rings, [[[longitude, latitude], …], …], the first ring is the exterior boundary, any additional rings are interior holes, and each ring must start and end with the same coordinate pair. Cannot be set when column is required.
  * `newKey` (string): New Column Key.

**Response**

  * **200** (application/json): [ColumnPolygon](https://appwrite.io/docs/references/cloud/models/columnPolygon)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/columns/polygon/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnPolygon result = await tablesDB.updatePolygonColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: [[[1, 2], [3, 4], [5, 6], [1, 2]]], // (optional)
    newKey: '', // (optional)
);
```

### Update relationship column

Update relationship column. [Learn more about relationship columns](https://appwrite.io/docs/databases-relationships#relationship-columns).

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `onDelete` (string): Constraints option
  * `newKey` (string): New Column Key.

**Response**

  * **200** (application/json): [ColumnRelationship](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnRelationship)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/columns/{key}/relationship
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnRelationship result = await tablesDB.updateRelationshipColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    onDelete: RelationMutate.cascade, // (optional)
    newKey: '', // (optional)
);
```

### Update string column

Update a string column. Changing the `default` value will not update already existing rows.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the Database service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (string, **required**): Default value for column when not provided. Cannot be set when column is required.
  * `size` (integer): Maximum size of the string column.
  * `newKey` (string): New Column Key.

**Response**

  * **200** (application/json): [ColumnString](https://appwrite.io/docs/references/cloud/models/columnString)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/columns/string/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnString result = await tablesDB.updateStringColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: '<DEFAULT>',
    size: 1, // (optional)
    newKey: '', // (optional)
);
```

### Update URL column

Update an url column. Changing the `default` value will not update already existing rows.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.
  * `required` (boolean, **required**): Is column required?
  * `default` (string, **required**): Default value for column when not provided. Cannot be set when column is required.
  * `newKey` (string): New Column Key.

**Response**

  * **200** (application/json): [ColumnURL](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnUrl)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/columns/url/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnUrl result = await tablesDB.updateUrlColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    xrequired: false,
    xdefault: 'https://example.com',
    newKey: '', // (optional)
);
```

### Delete column

Deletes a column.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `key` (string, **required**): Column Key.

**Response**

  * **204** (no content)

<!-- end list -->

```text
Endpoint
DELETE /tablesdb/{databaseId}/tables/{tableId}/columns/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

await tablesDB.deleteColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
);
```

-----

## indexes

### Create index

Creates an index on the columns listed. Your index should include all the columns you will query in a single request.
Type can be `key`, `fulltext`, or `unique`.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the Database service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `key` (string, **required**): Index Key.
  * `type` (string, **required**): Index type.
  * `columns` (array, **required**): Array of columns to index. Maximum of 100 columns are allowed, each 32 characters long.
  * `orders` (array): Array of index orders. Maximum of 100 orders are allowed.
  * `lengths` (array): Length of index. Maximum of 100

**Response**

  * **202** (application/json): [Index](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnIndex)

<!-- end list -->

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/indexes
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnIndex result = await tablesDB.createIndex(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
    type: IndexType.key,
    columns: [],
    orders: [], // (optional)
    lengths: [], // (optional)
);
```

### Get index

Get index by ID.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the Database service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `key` (string, **required**): Index Key.

**Response**

  * **200** (application/json): [Index](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/columnIndex)

<!-- end list -->

```text
Endpoint
GET /tablesdb/{databaseId}/tables/{tableId}/indexes/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnIndex result = await tablesDB.getIndex(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
);
```

### List indexes

List indexes on the table.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the Database service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `queries` (array): Array of query strings generated using the Query class provided by the SDK. [Learn more about queries](https://appwrite.io/docs/queries). Maximum of 100 queries are allowed, each 4096 characters long. You may filter on the following columns: key, type, status, attributes, error

**Response**

  * **200** (application/json): [Column Indexes List](https://appwrite.io/docs/references/cloud/models/columnIndexList)

<!-- end list -->

```text
Endpoint
GET /tablesdb/{databaseId}/tables/{tableId}/indexes
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

ColumnIndexList result = await tablesDB.listIndexes(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    queries: [], // (optional)
);
```

### Delete index

Delete an index.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the TablesDB service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `key` (string, **required**): Index Key.

**Response**

  * **204** (no content)

<!-- end list -->

```text
Endpoint
DELETE /tablesdb/{databaseId}/tables/{tableId}/indexes/{key}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

await tablesDB.deleteIndex(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    key: '',
);
```

-----

## rows

### Create row

Create a new Row. Before using this route, you should create a new table resource using either a [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable) API or directly from your database console.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the Database service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable). Make sure to define columns before creating rows.
  * `rowId` (string): Row ID. Choose a custom ID or generate a random ID with `ID.unique()`. Valid chars are a-z, A-Z, 0-9, period, hyphen, and underscore. Can't start with a special char. Max length is 36 chars.
  * `data` (object): Row data as JSON object.
  * `permissions` (array): An array of permissions strings. By default, only the current user is granted all permissions. [Learn more about permissions](https://appwrite.io/docs/permissions).
  * `transactionId` (string): Transaction ID for staging the operation.

**Response**

  * **201** (application/json): [Row](https://appwrite.io/docs/references/cloud/models/row)

**Rate limits**
This endpoint is not limited when using Server SDKs with API keys. If you are
using SSR with `setSession`, these rate limits will still apply. [Learn more about SSR rate limits.](https://www.google.com/search?q=https://appwrite.io/docs/products/auth/server-side-rendering%23rate-limits)

The limit is applied for each unique limit key.

| Time frame | Attempts | Key |
| :--- | :--- | :--- |
| 1 minutes | 120 requests | IP + METHOD + URL + USER ID |

[Learn more about rate limits](https://appwrite.io/docs/advanced/platform/rate-limits)

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/rows
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/permission.dart';
import 'package:dart_appwrite/role.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setSession(''); // The user session to authenticate with

TablesDB tablesDB = TablesDB(client);

Row result = await tablesDB.createRow(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    rowId: '<ROW_ID>',
    data: {
        "username": "walter.obrien",
        "email": "walter.obrien@example.com",
        "fullName": "Walter O'Brien",
        "age": 30,
        "isAdmin": false
    },
    permissions: [Permission.read(Role.any())], // (optional)
    transactionId: '<TRANSACTION_ID>', // (optional)
);
```

### Create rows

Create new Rows. Before using this route, you should create a new table resource using either a [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable) API or directly from your database console.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the Database service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable). Make sure to define columns before creating rows.
  * `rows` (array): Array of rows data as JSON objects.
  * `transactionId` (string): Transaction ID for staging the operation.

**Response**

  * **201** (application/json): [Rows List](https://appwrite.io/docs/references/cloud/models/rowList)

**Rate limits**
This endpoint is not limited when using Server SDKs with API keys. If you are
using SSR with `setSession`, these rate limits will still apply. [Learn more about SSR rate limits.](https://www.google.com/search?q=https://appwrite.io/docs/products/auth/server-side-rendering%23rate-limits)

The limit is applied for each unique limit key.

| Time frame | Attempts | Key |
| :--- | :--- | :--- |
| 1 minutes | 120 requests | IP + METHOD + URL + USER ID |

[Learn more about rate limits](https://appwrite.io/docs/advanced/platform/rate-limits)

```text
Endpoint
POST /tablesdb/{databaseId}/tables/{tableId}/rows
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

RowList result = await tablesDB.createRows(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    rows: [],
    transactionId: '<TRANSACTION_ID>', // (optional)
);
```

### Get row

Get a row by its unique ID. This endpoint response returns a JSON object with the row data.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the Database service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `rowId` (string, **required**): Row ID.
  * `queries` (array): Array of query strings generated using the Query class provided by the SDK. [Learn more about queries](https://appwrite.io/docs/queries). Maximum of 100 queries are allowed, each 4096 characters long.
  * `transactionId` (string): Transaction ID to read uncommitted changes within the transaction.

**Response**

  * **200** (application/json): [Row](https://appwrite.io/docs/references/cloud/models/row)

<!-- end list -->

```text
Endpoint
GET /tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setSession(''); // The user session to authenticate with

TablesDB tablesDB = TablesDB(client);

Row result = await tablesDB.getRow(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    rowId: '<ROW_ID>',
    queries: [], // (optional)
    transactionId: '<TRANSACTION_ID>', // (optional)
);
```

### List rows

Get a list of all the user's rows in a given table. You can use the query params to filter your results.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the TablesDB service [server integration](https://appwrite.io/docs/products/databases/tables#create-table).
  * `queries` (array): Array of query strings generated using the Query class provided by the SDK. [Learn more about queries](https://appwrite.io/docs/queries). Maximum of 100 queries are allowed, each 4096 characters long.
  * `transactionId` (string): Transaction ID to read uncommitted changes within the transaction.

**Response**

  * **200** (application/json): [Rows List](https://appwrite.io/docs/references/cloud/models/rowList)

<!-- end list -->

```text
Endpoint
GET /tablesdb/{databaseId}/tables/{tableId}/rows
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setSession(''); // The user session to authenticate with

TablesDB tablesDB = TablesDB(client);

RowList result = await tablesDB.listRows(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    queries: [], // (optional)
    transactionId: '<TRANSACTION_ID>', // (optional)
);
```

### Update row

Update a row by its unique ID. Using the patch method you can pass only specific fields that will get updated.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `rowId` (string, **required**): Row ID.
  * `data` (object): Row data as JSON object. Include only columns and value pairs to be updated.
  * `permissions` (array): An array of permissions strings. By default, the current permissions are inherited. [Learn more about permissions](https://appwrite.io/docs/permissions).
  * `transactionId` (string): Transaction ID for staging the operation.

**Response**

  * **200** (application/json): [Row](https://appwrite.io/docs/references/cloud/models/row)

**Rate limits**
This endpoint is not limited when using Server SDKs with API keys. If you are
using SSR with `setSession`, these rate limits will still apply. [Learn more about SSR rate limits.](https://www.google.com/search?q=https://appwrite.io/docs/products/auth/server-side-rendering%23rate-limits)

The limit is applied for each unique limit key.

| Time frame | Attempts | Key |
| :--- | :--- | :--- |
| 1 minutes | 120 requests | IP + METHOD + URL + USER ID |

[Learn more about rate limits](https://appwrite.io/docs/advanced/platform/rate-limits)

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/permission.dart';
import 'package:dart_appwrite/role.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setSession(''); // The user session to authenticate with

TablesDB tablesDB = TablesDB(client);

Row result = await tablesDB.updateRow(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    rowId: '<ROW_ID>',
    data: {}, // (optional)
    permissions: [Permission.read(Role.any())], // (optional)
    transactionId: '<TRANSACTION_ID>', // (optional)
);
```

### Update rows

Update all rows that match your queries, if no queries are submitted then all rows are updated. You can pass only specific fields to be updated.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `data` (object): Row data as JSON object. Include only column and value pairs to be updated.
  * `queries` (array): Array of query strings generated using the Query class provided by the SDK. [Learn more about queries](https://appwrite.io/docs/queries). Maximum of 100 queries are allowed, each 4096 characters long.
  * `transactionId` (string): Transaction ID for staging the operation.

**Response**

  * **200** (application/json): [Rows List](https://appwrite.io/docs/references/cloud/models/rowList)

**Rate limits**
This endpoint is not limited when using Server SDKs with API keys. If you are
using SSR with `setSession`, these rate limits will still apply. [Learn more about SSR rate limits.](https://www.google.com/search?q=https://appwrite.io/docs/products/auth/server-side-rendering%23rate-limits)

The limit is applied for each unique limit key.

| Time frame | Attempts | Key |
| :--- | :--- | :--- |
| 1 minutes | 120 requests | IP + METHOD + URL + USER ID |

[Learn more about rate limits](https://appwrite.io/docs/advanced/platform/rate-limits)

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/rows
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

RowList result = await tablesDB.updateRows(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    data: {}, // (optional)
    queries: [], // (optional)
    transactionId: '<TRANSACTION_ID>', // (optional)
);
```

### Upsert a row

Create or update a Row. Before using this route, you should create a new table resource using either a [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable) API or directly from your database console.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `rowId` (string, **required**): Row ID.
  * `data` (object): Row data as JSON object. Include all required columns of the row to be created or updated.
  * `permissions` (array): An array of permissions strings. By default, the current permissions are inherited. [Learn more about permissions](https://appwrite.io/docs/permissions).
  * `transactionId` (string): Transaction ID for staging the operation.

**Response**

  * **201** (application/json): [Row](https://appwrite.io/docs/references/cloud/models/row)

**Rate limits**
This endpoint is not limited when using Server SDKs with API keys. If you are
using SSR with `setSession`, these rate limits will still apply. [Learn more about SSR rate limits.](https://www.google.com/search?q=https://appwrite.io/docs/products/auth/server-side-rendering%23rate-limits)

The limit is applied for each unique limit key.

| Time frame | Attempts | Key |
| :--- | :--- | :--- |
| 1 minutes | 120 requests | IP + METHOD + URL + USER ID |

[Learn more about rate limits](https://appwrite.io/docs/advanced/platform/rate-limits)

```text
Endpoint
PUT /tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/permission.dart';
import 'package:dart_appwrite/role.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setSession(''); // The user session to authenticate with

TablesDB tablesDB = TablesDB(client);

Row result = await tablesDB.upsertRow(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    rowId: '<ROW_ID>',
    data: {}, // (optional)
    permissions: [Permission.read(Role.any())], // (optional)
    transactionId: '<TRANSACTION_ID>', // (optional)
);
```

### Upsert rows

Create or update Rows. Before using this route, you should create a new table resource using either a [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable) API or directly from your database console.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `rows` (array, **required**): Array of row data as JSON objects. May contain partial rows.
  * `transactionId` (string): Transaction ID for staging the operation.

**Response**

  * **201** (application/json): [Rows List](https://appwrite.io/docs/references/cloud/models/rowList)

**Rate limits**
This endpoint is not limited when using Server SDKs with API keys. If you are
using SSR with `setSession`, these rate limits will still apply. [Learn more about SSR rate limits.](https://www.google.com/search?q=https://appwrite.io/docs/products/auth/server-side-rendering%23rate-limits)

The limit is applied for each unique limit key.

| Time frame | Attempts | Key |
| :--- | :--- | :--- |
| 1 minutes | 120 requests | IP + METHOD + URL + USER ID |

[Learn more about rate limits](https://appwrite.io/docs/advanced/platform/rate-limits)

```text
Endpoint
PUT /tablesdb/{databaseId}/tables/{tableId}/rows
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

RowList result = await tablesDB.upsertRows(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    rows: [],
    transactionId: '<TRANSACTION_ID>', // (optional)
);
```

### Delete row

Delete a row by its unique ID.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the Database service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `rowId` (string, **required**): Row ID.
  * `transactionId` (string): Transaction ID for staging the operation.

**Response**

  * **204** (no content)

**Rate limits**
This endpoint is not limited when using Server SDKs with API keys. If you are
using SSR with `setSession`, these rate limits will still apply. [Learn more about SSR rate limits.](https://www.google.com/search?q=https://appwrite.io/docs/products/auth/server-side-rendering%23rate-limits)

The limit is applied for each unique limit key.

| Time frame | Attempts | Key |
| :--- | :--- | :--- |
| 1 minutes | 60 requests | IP + METHOD + URL + USER ID |

[Learn more about rate limits](https://appwrite.io/docs/advanced/platform/rate-limits)

```text
Endpoint
DELETE /tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setSession(''); // The user session to authenticate with

TablesDB tablesDB = TablesDB(client);

await tablesDB.deleteRow(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    rowId: '<ROW_ID>',
    transactionId: '<TRANSACTION_ID>', // (optional)
);
```

### Delete rows

Bulk delete rows using queries, if no queries are passed then all rows are deleted.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID. You can create a new table using the Database service [server integration](https://appwrite.io/docs/references/cloud/server-dart/tablesDB#createTable).
  * `queries` (array): Array of query strings generated using the Query class provided by the SDK. [Learn more about queries](https://appwrite.io/docs/queries). Maximum of 100 queries are allowed, each 4096 characters long.
  * `transactionId` (string): Transaction ID for staging the operation.

**Response**

  * **200** (application/json): [Rows List](https://appwrite.io/docs/references/cloud/models/rowList)

**Rate limits**
This endpoint is not limited when using Server SDKs with API keys. If you are
using SSR with `setSession`, these rate limits will still apply. [Learn more about SSR rate limits.](https://www.google.com/search?q=https://appwrite.io/docs/products/auth/server-side-rendering%23rate-limits)

The limit is applied for each unique limit key.

| Time frame | Attempts | Key |
| :--- | :--- | :--- |
| 1 minutes | 60 requests | IP + METHOD + URL + USER ID |

[Learn more about rate limits](https://appwrite.io/docs/advanced/platform/rate-limits)

```text
Endpoint
DELETE /tablesdb/{databaseId}/tables/{tableId}/rows
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

await tablesDB.deleteRows(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    queries: [], // (optional)
    transactionId: '<TRANSACTION_ID>', // (optional)
);
```

### Increment row column

Increment a specific column of a row by a given value.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `rowId` (string, **required**): Row ID.
  * `column` (string, **required**): Column key.
  * `value` (number): Value to increment the column by. The value must be a number.
  * `max` (number): Maximum value for the column. If the current value is greater than this value, an error will be thrown.
  * `transactionId` (string): Transaction ID for staging the operation.

**Response**

  * **200** (application/json): [Row](https://appwrite.io/docs/references/cloud/models/row)

**Rate limits**
This endpoint is not limited when using Server SDKs with API keys. If you are
using SSR with `setSession`, these rate limits will still apply. [Learn more about SSR rate limits.](https://www.google.com/search?q=https://appwrite.io/docs/products/auth/server-side-rendering%23rate-limits)

The limit is applied for each unique limit key.

| Time frame | Attempts | Key |
| :--- | :--- | :--- |
| 1 minutes | 120 requests | IP + METHOD + URL + USER ID |

[Learn more about rate limits](https://appwrite.io/docs/advanced/platform/rate-limits)

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}/{column}/increment
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setSession(''); // The user session to authenticate with

TablesDB tablesDB = TablesDB(client);

Row result = await tablesDB.incrementRowColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    rowId: '<ROW_ID>',
    column: '',
    value: 0, // (optional)
    max: 0, // (optional)
    transactionId: '<TRANSACTION_ID>', // (optional)
);
```

### Decrement row column

Decrement a specific column of a row by a given value.

**Request**

  * `databaseId` (string, **required**): Database ID.
  * `tableId` (string, **required**): Table ID.
  * `rowId` (string, **required**): Row ID.
  * `column` (string, **required**): Column key.
  * `value` (number): Value to increment the column by. The value must be a number.
  * `min` (number): Minimum value for the column. If the current value is lesser than this value, an exception will be thrown.
  * `transactionId` (string): Transaction ID for staging the operation.

**Response**

  * **200** (application/json): [Row](https://appwrite.io/docs/references/cloud/models/row)

**Rate limits**
This endpoint is not limited when using Server SDKs with API keys. If you are
using SSR with `setSession`, these rate limits will still apply. [Learn more about SSR rate limits.](https://www.google.com/search?q=https://appwrite.io/docs/products/auth/server-side-rendering%23rate-limits)

The limit is applied for each unique limit key.

| Time frame | Attempts | Key |
| :--- | :--- | :--- |
| 1 minutes | 120 requests | IP + METHOD + URL + USER ID |

[Learn more about rate limits](https://appwrite.io/docs/advanced/platform/rate-limits)

```text
Endpoint
PATCH /tablesdb/{databaseId}/tables/{tableId}/rows/{rowId}/{column}/decrement
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setSession(''); // The user session to authenticate with

TablesDB tablesDB = TablesDB(client);

Row result = await tablesDB.decrementRowColumn(
    databaseId: '<DATABASE_ID>',
    tableId: '<TABLE_ID>',
    rowId: '<ROW_ID>',
    column: '',
    value: 0, // (optional)
    min: 0, // (optional)
    transactionId: '<TRANSACTION_ID>', // (optional)
);
```

-----

## transactions

### Create operations

Create multiple operations in a single transaction.

**Request**

  * `transactionId` (string, **required**): Transaction ID.
  * `operations` (array): Array of staged operations.

**Response**

  * **201** (application/json): [Transaction](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/transaction)

<!-- end list -->

```text
Endpoint
POST /tablesdb/transactions/{transactionId}/operations
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

Transaction result = await tablesDB.createOperations(
    transactionId: '<TRANSACTION_ID>',
    operations: [
	    {
	        "action": "create",
	        "databaseId": "<DATABASE_ID>",
	        "tableId": "<TABLE_ID>",
	        "rowId": "<ROW_ID>",
	        "data": {
	            "name": "Walter O'Brien"
	        }
	    }
	], // (optional)
);
```

### Create transaction

Create a new transaction.

**Request**

  * `ttl` (integer): Seconds before the transaction expires.

**Response**

  * **201** (application/json): [Transaction](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/transaction)

<!-- end list -->

```text
Endpoint
POST /tablesdb/transactions
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

Transaction result = await tablesDB.createTransaction(
    ttl: 60, // (optional)
);
```

### Get transaction

Get a transaction by its unique ID.

**Request**

  * `transactionId` (string, **required**): Transaction ID.

**Response**

  * **200** (application/json): [Transaction](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/transaction)

<!-- end list -->

```text
Endpoint
GET /tablesdb/transactions/{transactionId}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

Transaction result = await tablesDB.getTransaction(
    transactionId: '<TRANSACTION_ID>',
);
```

### List transactions

List transactions across all databases.

**Request**

  * `queries` (array): Array of query strings generated using the Query class provided by the SDK. [Learn more about queries](https://appwrite.io/docs/queries).

**Response**

  * **200** (application/json): [Transaction List](https://appwrite.io/docs/references/cloud/models/transactionList)

<!-- end list -->

```text
Endpoint
GET /tablesdb/transactions
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

TransactionList result = await tablesDB.listTransactions(
    queries: [], // (optional)
);
```

### Update transaction

Update a transaction, to either commit or roll back its operations.

**Request**

  * `transactionId` (string, **required**): Transaction ID.
  * `commit` (boolean): Commit transaction?
  * `rollback` (boolean): Rollback transaction?

**Response**

  * **200** (application/json): [Transaction](https://www.google.com/search?q=https://appwrite.io/docs/references/cloud/models/transaction)

<!-- end list -->

```text
Endpoint
PATCH /tablesdb/transactions/{transactionId}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

Transaction result = await tablesDB.updateTransaction(
    transactionId: '<TRANSACTION_ID>',
    commit: false, // (optional)
    rollback: false, // (optional)
);
```

### Delete transaction

Delete a transaction by its unique ID.

**Request**

  * `transactionId` (string, **required**): Transaction ID.

**Response**

  * **204** (no content)

<!-- end list -->

```text
Endpoint
DELETE /tablesdb/transactions/{transactionId}
```

```dart
import 'package:dart_appwrite/dart_appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1') // Your API Endpoint
    .setProject('<YOUR_PROJECT_ID>') // Your project ID
    .setKey('<YOUR_API_KEY>'); // Your secret API key

TablesDB tablesDB = TablesDB(client);

await tablesDB.deleteTransaction(
    transactionId: '<TRANSACTION_ID>',
);
```