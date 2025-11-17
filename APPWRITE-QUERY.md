Here is the Markdown version of the Appwrite Queries documentation you provided.

-----

[Skip to content](https://www.google.com/search?q=%23main)

  * [Docs](https://appwrite.io/docs)
  * [Star on GitHub 53K](https://github.com/appwrite/appwrite)
  * [Go to Console](https://cloud.appwrite.io/)

[Go back](https://appwrite.io/docs)

Databases

-----

## Getting started

  * [Overview](https://appwrite.io/docs/products/databases)
  * [Quick start](https://appwrite.io/docs/products/databases/quick-start)

-----

## Concepts

  * [Databases](https://appwrite.io/docs/products/databases/databases)
  * [Tables](https://appwrite.io/docs/products/databases/tables)
  * [Rows](https://appwrite.io/docs/products/databases/rows)
  * [Permissions](https://appwrite.io/docs/products/databases/permissions)
  * [Relationships](https://appwrite.io/docs/products/databases/relationships)
  * [Geo queries](https://appwrite.io/docs/products/databases/geo-queries)
  * [Backups](https://appwrite.io/docs/products/databases/backups)

-----

## Journeys

  * [Queries](https://appwrite.io/docs/products/databases/queries)
  * [Order](https://appwrite.io/docs/products/databases/order)
  * [Pagination](https://appwrite.io/docs/products/databases/pagination)
  * [Transactions](https://appwrite.io/docs/products/databases/transactions)
  * [Type generation](https://appwrite.io/docs/products/databases/type-generation)
  * [Offline sync](https://appwrite.io/docs/products/databases/offline)
  * [Bulk operations](https://appwrite.io/docs/products/databases/bulk-operations)
  * [Atomic numeric operations](https://appwrite.io/docs/products/databases/atomic-numeric-operations)
  * [CSV imports](https://appwrite.io/docs/products/databases/csv-imports)
  * [Database operators New](https://appwrite.io/docs/products/databases/db-operators)

-----

## References

  * [TablesDB API](https://appwrite.io/docs/references/cloud/client-web/tablesDB)
  * [Legacy API](https://appwrite.io/docs/references/cloud/client-web/databases)

-----

# Queries

[cite\_start]Many list endpoints in Appwrite allow you to filter, sort, and paginate results using queries[cite: 1990]. [cite\_start]Appwrite provides a common set of syntax to build queries[cite: 1990].

## [Query class](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23query-class)

[cite\_start]Appwrite SDKs provide a `Query` class to help you build queries[cite: 1991]. [cite\_start]The `Query` class has methods for each type of supported query operation[cite: 1991].

## [Building queries](https://appwrite.io/docs/products/databases/queries#building-queries)

[cite\_start]Queries are passed to an endpoint through the `queries` parameter as an array of query strings, which can be generated using the `Query` class[cite: 1992].

[cite\_start]Each query method is logically separated via `AND` operations[cite: 1992]. [cite\_start]For `OR` operation, pass multiple values into the query method separated by commas[cite: 1992]. [cite\_start]For example `Query.equal('title', ['Avatar', 'Lord of the Rings'])` will fetch the movies `Avatar` or `Lord of the Rings`[cite: 1992, 1993].

> **Default pagination behavior**
> [cite\_start]By default, results are limited to the **first 25 items**[cite: 1994]. [cite\_start]You can change this through [pagination](https://appwrite.io/docs/products/databases/pagination)[cite: 1994].

```dart
import 'package:appwrite/appwrite.dart';

[cite_start]void main() async { [cite: 1997]
    final client = Client()
        .setEndpoint('https://<REGION>.cloud.appwrite.io/v1')
        .setProject('<PROJECT_ID>');

    [cite_start]final tablesDB = TablesDB(client); [cite: 1998]

    try {
        final rows = await tablesDB.listRows(
            [cite_start]'<DATABASE_ID>', [cite: 1999]
            [cite_start]'<TABLE_ID>', [cite: 1999]
            [ [cite_start][cite: 2000]
                [cite_start]Query.equal('title', ['Avatar', 'Lord of the Rings']), [cite: 2000]
                [cite_start]Query.greaterThan('year', 1999) [cite: 2001]
            ]
        [cite_start]); [cite: 2002]
    } on AppwriteException catch(e) {
        print(e);
    [cite_start]} [cite: 2003]
}
```

## [Query operators](https://appwrite.io/docs/products/databases/queries#query-operators)

### [Select](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23select)

[cite\_start]The `select` operator allows you to specify which columns should be returned from a row[cite: 2004]. [cite\_start]This is essential for optimizing response size, controlling which relationship data loads, and only retrieving the data you need[cite: 2004].

```dart
Query.select(["name", "title"])
```

#### [Select relationship data](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23relationship-select)

[cite\_start]With [opt-in relationship loading](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/relationships%23performance-loading), you must explicitly select relationship data[cite: 2007]. [cite\_start]This gives you fine-grained control over performance and payload size[cite: 2007].

##### [Get rows without relationships](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23get-rows-without-relationships)

By default, rows return only their own fields:

```dart
final doc = await tablesDB.getRow(
    databaseId: '<DATABASE_ID>',
    [cite_start]tableId: '<TABLE_ID>', [cite: 2011]
    rowId: '<ROW_ID>',
    queries: [Query.select(["name", "age"])]
);
```

##### [Load all relationship data](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23load-all-relationship-data)

[cite\_start]Use the `*` wildcard to load all fields from related rows[cite: 2012]:

```dart
final doc = await tablesDB.getRow(
    databaseId: '<DATABASE_ID>',
    [cite_start]tableId: '<TABLE_ID>', [cite: 2015]
    rowId: '<ROW_ID>',
    queries: [Query.select(["*", "reviews.*"])]
);
```

##### [Select specific relationship fields](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23select-specific-relationship-fields)

[cite\_start]For precise control, select only specific fields from related rows[cite: 2016]:

```dart
final doc = await tablesDB.getRow(
    databaseId: '<DATABASE_ID>',
    [cite_start]tableId: '<TABLE_ID>', [cite: 2019]
    rowId: '<ROW_ID>',
    queries: [Query.select(["name", "age", "reviews.author", "reviews.rating"])]
);
```

##### [Load nested relationships](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23load-nested-relationships)

[cite\_start]You can also load relationships of relationships[cite: 2020]:

```dart
Query.select(["*", "reviews.*", "reviews.author.*"])
```

#### [Use selection patterns](https://appwrite.io/docs/products/databases/queries#select-patterns)

| Pattern | Description | Use case |
| :--- | :--- | :--- |
| [cite\_start]`["field1", "field2"]` [cite: 2024] | [cite\_start]Specific columns only [cite: 2024] | [cite\_start]Minimize response size [cite: 2024] |
| `["*"]` | [cite\_start]All row columns [cite: 2025] | [cite\_start]Get complete row data [cite: 2025] |
| `["*", "relationName.*"]` | [cite\_start]Row + all relationship fields [cite: 2026] | [cite\_start]Load row with complete related data [cite: 2026] |
| `["field1", "relationName.field2"]` | [cite\_start]Specific fields from row and relationships [cite: 2027] | [cite\_start]Precise data loading [cite: 2027] |
| `["*", "relationName.field1", "relationName.field2"]` | [cite\_start]All row fields + specific relationship fields [cite: 2028] | [cite\_start]Partial relationship loading [cite: 2028] |
| `["relationName.*", "relationName.nestedRelation.*"]` | [cite\_start]Nested relationship loading [cite: 2029] | [cite\_start]Load relationships of relationships [cite: 2029] |

#### [Optimize performance](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23select-performance)

**Optimize response size** - Only select the fields you actually need. Smaller responses are faster to transfer and parse.

[cite\_start]**Control relationship loading** - Related rows are not loaded by default[cite: 2030]. [cite\_start]Use explicit selection to load only the relationships you need[cite: 2030].

**Reduce database load** - Selecting fewer fields reduces database processing time, especially for large rows.

> **Related rows**
> [cite\_start]By default, relationship columns contain only row IDs[cite: 2031]. [cite\_start]To load the actual related row data, you must explicitly include relationship fields in your select query[cite: 2031]. [cite\_start]Learn more about [relationship performance optimization](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/relationships%23performance-loading)[cite: 2032].

### [Comparison operators](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23comparison)

#### [Equal](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23equal)

Returns row if column is equal to any value in the provided array. Also supported for spatial types.

```dart
Query.equal("title", ["Iron Man"])
```

#### [Not equal](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-equal)

Returns row if column is not equal to any value in the provided array. [cite\_start]Also supported for spatial types[cite: 2036].

```dart
Query.notEqual("title", "Iron Man")
```

#### [Less than](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23less-than)

[cite\_start]Returns row if column is less than the provided value[cite: 2039].

```dart
Query.lessThan("score", 10)
```

#### [Less than or equal](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23less-than-equal)

[cite\_start]Returns row if column is less than or equal to the provided value[cite: 2042].

```dart
Query.lessThanEqual("score", 10)
```

#### [Greater than](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23greater-than)

[cite\_start]Returns row if column is greater than the provided value[cite: 2045].

```dart
Query.greaterThan("score", 10)
```

#### [Greater than or equal](https://appwrite.io/docs/products/databases/queries#greater-than-equal)

[cite\_start]Returns row if column is greater than or equal to the provided value[cite: 2048].

```dart
Query.greaterThanEqual("score", 10)
```

#### [Between](https://appwrite.io/docs/products/databases/queries#between)

[cite\_start]Returns row if column value falls between the two values[cite: 2051]. [cite\_start]The boundary values are inclusive and can be strings or numbers[cite: 2051].

```dart
[cite_start]Query.between("price", 5, 10) [cite: 2054]
```

#### [Not between](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-between)

[cite\_start]Returns rows if the column value is outside the range defined by the two values (strictly less than start OR strictly greater than end)[cite: 2055]. [cite\_start]Works with strings or numbers[cite: 2055]. [cite\_start]Boundary values are excluded[cite: 2055].

```dart
[cite_start]Query.notBetween("price", 5, 10) [cite: 2058]
```

### [Null checks](https://appwrite.io/docs/products/databases/queries#null-checks)

#### [Is null](https://appwrite.io/docs/products/databases/queries#is-null)

Returns rows where column value is null.

```dart
[cite_start]Query.isNull("name") [cite: 2061]
```

#### [Is not null](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23is-not-null)

Returns rows where column value is **not** null.

```dart
Query.isNotNull("name")
```

### [cite\_start][String operations](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23string-operations) [cite: 2064]

#### [Starts with](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23starts-with)

Returns rows if a string column starts with a substring.

```dart
[cite_start]Query.startsWith("name", "Once upon a time") [cite: 2067]
```

#### [Not starts with](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-starts-with)

Returns rows if a string column does not start with a substring.

```dart
Query.notStartsWith("name", "Once upon a time")
```

#### [Ends with](https://appwrite.io/docs/products/databases/queries#ends-with)

Returns rows if a string column ends with a substring.

```dart
Query.endsWith("name", "happily ever after.")
```

#### [Not ends with](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-ends-with)

Returns rows if a string column does not end with a substring.

```dart
Query.notEndsWith("name", "happily ever after.")
```

#### [Contains](https://appwrite.io/docs/products/databases/queries#contains)

[cite\_start]Returns rows if the array column contains the specified elements or if a string column contains the specified substring[cite: 2077]. [cite\_start]Also supported for spatial types[cite: 2077].

```dart
[cite_start]// For arrays [cite: 2080]
Query.contains("ingredients", ['apple', 'banana'])
// For strings
Query.contains("name", "Tom")
```

#### [Not contains](https://appwrite.io/docs/products/databases/queries#not-contains)

[cite\_start]Returns rows if the array column does not contain the specified elements, or if a string column does not contain the specified substring[cite: 2081]. [cite\_start]Also supported for spatial types[cite: 2081].

```dart
// For arrays
Query.notContains("ingredients", ['apple', 'banana'])
// For strings
Query.notContains("name", "Tom")
```

#### [Search](https://appwrite.io/docs/products/databases/queries#search)

[cite\_start]Searches string columns for provided keywords[cite: 2085].
[cite\_start]Requires a [full-text index](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/tables%23indexes) on queried columns[cite: 2085].

```dart
Query.search("text", "key words")
```

#### [Not search](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-search)

[cite\_start]Returns rows if a string column does not match the full-text search query[cite: 2088]. [cite\_start]Requires a [full-text index](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/tables%23indexes) on queried columns[cite: 2088].

```dart
Query.notSearch("text", "key words")
```

### [Logical operators](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23logical-operators)

#### [AND](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23and)

Returns row if it matches all of the nested sub-queries in the array passed in.

```dart
Query.and([
    Query.lessThan("size", 10),
    Query.greaterThan("size", 5)
])
```

#### [cite\_start][OR](https://appwrite.io/docs/products/databases/queries#or) [cite: 2095]

Returns row if it matches any of the nested sub-queries in the array passed in.

```dart
Query.or([
    [cite_start]Query.lessThan("size", 5), [cite: 2098]
    Query.greaterThan("size", 10)
])
```

### [Ordering](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23ordering)

#### [Order descending](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23order-desc)

Orders results in descending order by column. Column must be indexed.

```dart
Query.orderDesc("column")
```

#### [Order ascending](https://appwrite.io/docs/products/databases/queries#order-asc)

Orders results in ascending order by column. Column must be indexed.

```dart
Query.orderAsc("column")
```

#### [Order random](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23order-random)

Orders results in random order.

```dart
[cite_start]Query.orderRandom() [cite: 2107]
```

### [Pagination](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23pagination)

#### [Limit](https://appwrite.io/docs/products/databases/queries#limit)

Limits the number of results returned by the query. [cite\_start]Used for [pagination](https://appwrite.io/docs/products/databases/pagination)[cite: 2107].

```dart
[cite_start]Query.limit(25) [cite: 2110]
```

#### [Offset](https://appwrite.io/docs/products/databases/queries#offset)

Offset the results returned by skipping some of the results. Used for [pagination](https://appwrite.io/docs/products/databases/pagination).

```dart
[cite_start]Query.offset(0) [cite: 2113]
```

#### [Cursor after](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23cursor-after)

Places the cursor after the specified resource ID. Used for [pagination](https://appwrite.io/docs/products/databases/pagination).

```dart
[cite_start]Query.cursorAfter("62a7...f620") [cite: 2116]
```

#### [Cursor before](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23cursor-before)

Places the cursor before the specified resource ID. Used for [pagination](https://appwrite.io/docs/products/databases/pagination).

```dart
[cite_start]Query.cursorBefore("62a7...a600") [cite: 2119]
```

## [Time helpers](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23time-helpers)

Built-in helpers for filtering by creation and update timestamps using ISO 8601 date-time strings (for example, "2025-01-01T00:00:00Z").

#### [Created before](https://appwrite.io/docs/products/databases/queries#created-before)

[cite\_start]Returns rows created before the given date[cite: 2120].

```dart
Query.createdBefore("2025-01-01T00:00:00Z")
```

#### [Created after](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23created-after)

[cite\_start]Returns rows created after the given date[cite: 2123].

```dart
Query.createdAfter("2025-01-01T00:00:00Z")
```

#### [Updated before](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23updated-before)

[cite\_start]Returns rows updated before the given date[cite: 2126].

```dart
Query.updatedBefore("2025-01-01T00:00:00Z")
```

#### [Updated after](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23updated-after)

Returns rows updated after the given date.

```dart
Query.updatedAfter("2025-01-01T00:00:00Z")
```

## [Geo queries and spatial operations](https://appwrite.io/docs/products/databases/queries#geo-queries)

[cite\_start]Geo queries enable geographic operations on [spatial columns](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/spatial)[cite: 2132]. Coordinates are specified as `[longitude, latitude]` arrays. [cite\_start]Distance measurements can be specified in meters or degrees[cite: 2132].

[cite\_start]For conceptual information about spatial data types, spatial columns and indexing, see [Geo queries](https://appwrite.io/docs/products/databases/geo-queries)[cite: 2133].

> **Additional supported queries**
> [cite\_start]In addition to the spatial-specific operations below, the query helpers `equal`, `notEqual`, `contains`, and `notContains` are also supported on spatial columns[cite: 2134]. [cite\_start]This lets you match or exclude exact spatial values, check whether a geometry collection contains a geometry or not[cite: 2134].

### [Distance equal](https://appwrite.io/docs/products/databases/queries#distance-equal)

[cite\_start]Returns rows where the spatial column is exactly the specified distance from a point[cite: 2135].

```dart
[cite_start]Query.distanceEqual("location", [-73.9851, 40.7589], 200) [cite: 2138]
```

### [Distance not equal](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23distance-not-equal)

Returns rows where the spatial column is not exactly the specified distance from a point.

```dart
Query.distanceNotEqual("location", [-73.9851, 40.7589], 200)
```

### [Distance greater than](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23distance-greater-than)

[cite\_start]Returns rows where the spatial column is more than the specified distance from a point[cite: 2142].

```dart
[cite_start]Query.distanceGreaterThan("location", [-73.9851, 40.7589], 200) [cite: 2145]
```

### [Distance less than](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23distance-less-than)

Returns rows where the spatial column is less than the specified distance from a point.

```dart
Query.distanceLessThan("location", [-73.9851, 40.7589], 200)
```

### [cite\_start][Intersects](https://appwrite.io/docs/products/databases/queries#intersects) [cite: 2149]

Returns rows where the spatial column intersects with the provided geometry.

```dart
[cite_start]Query.intersects("area", [[-73.9851, 40.7589], [-73.9776, 40.7614], [-73.9733, 40.7505], [-73.9851, 40.7589]]) [cite: 2152]
```

### [Not intersects](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-intersects)

[cite\_start]Returns rows where the spatial column does not intersect with the provided geometry[cite: 2153].

```dart
[cite_start]Query.notIntersects("area", [[-73.9851, 40.7589], [-73.9776, 40.7614], [-73.9733, 40.7505], [-73.9851, 40.7589]]) [cite: 2156]
```

### [Overlaps](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23overlaps)

Returns rows where the spatial column overlaps with the provided geometry.

```dart
[cite_start]Query.overlaps("zone", [[-73.9851, 40.7589], [-73.9776, 40.7614], [-73.9733, 40.7505], [-73.9851, 40.7589]]) [cite: 2160]
```

### [Not overlaps](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-overlaps)

Returns rows where the spatial column does not overlap with the provided geometry.

```dart
[cite_start]Query.notOverlaps("zone", [[-73.9851, 40.7589], [-73.9776, 40.7614], [-73.9733, 40.7505], [-73.9851, 40.7589]]) [cite: 2164]
```

### [Touches](https://appwrite.io/docs/products/databases/queries#touches)

Returns rows where the spatial column touches the provided geometry.

```dart
Query.touches("boundary", [[-73.9851, 40.7589], [-73.9776, 40.7614], [-73.9733, 40.7505], [-73.9851, 40.7589]])
```

### [Not touches](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-touches)

[cite\_start]Returns rows where the spatial column does not touch the provided geometry[cite: 2168].

```dart
[cite_start]Query.notTouches("boundary", [[-73.9851, 40.7589], [-73.9776, 40.7614], [-73.9733, 40.7505], [-73.9851, 40.7589]]) [cite: 2171]
```

### [Crosses](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23crosses)

Returns rows where the spatial column crosses the provided geometry.

```dart
[cite_start]Query.crosses("route", [[-73.9851, 40.7589], [-73.9776, 40.7614]]) [cite: 2175]
```

### [Not crosses](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-crosses)

Returns rows where the spatial column does not cross the provided geometry.

```dart
Query.notCrosses("route", [[-73.9851, 40.7589], [-73.9776, 40.7614]])
```

## [Complex queries](https://appwrite.io/docs/products/databases/queries#complex-queries)

[cite\_start]You can create complex queries by combining AND and OR operations[cite: 2179]. [cite\_start]For example, to find items that are either books under $20 or magazines under $10[cite: 2179]:

```dart
final results = await tablesDB.listRows(
    [cite_start]'<DATABASE_ID>', [cite: 2182]
    '<TABLE_ID>',
    [
        Query.or([
            [cite_start]Query.and([ [cite: 2183]
                Query.equal('category', ['books']),
                [cite_start]Query.lessThan('price', 20) [cite: 2184]
            ]),
            [cite_start]Query.and([ [cite: 2185]
                Query.equal('category', ['magazines']),
                [cite_start]Query.lessThan('price', 10) [cite: 2186]
            ])
        [cite_start]]) [cite: 2187]
    ]
);
```

This example demonstrates how to combine `OR` and `AND` operations. [cite\_start]The query uses `Query.or()` to match either condition: books under $20 OR magazines under $10[cite: 2188]. [cite\_start]Each condition within the OR is composed of two AND conditions - one for the category and one for the price threshold[cite: 2188]. [cite\_start]The database will return rows that match either of these combined conditions[cite: 2188].

-----

Was this page helpful?

[cite\_start][Update on GitHub](https://www.google.com/search?q=https://github.com/appwrite/website/tree/main/src/routes/docs/products/databases/queries) [cite: 2190]

-----

## On This Page

  * [Query class](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23query-class)
  * [Building queries](https://appwrite.io/docs/products/databases/queries#building-queries)
  * [Query operators](https://appwrite.io/docs/products/databases/queries#query-operators)
      * [Select](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23select)
          * [Select relationship data](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23relationship-select)
          * [Get rows without relationships](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23get-rows-without-relationships)
          * [Load all relationship data](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23load-all-relationship-data)
          * [Select specific relationship fields](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23select-specific-relationship-fields)
          * [Load nested relationships](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23load-nested-relationships)
          * [Use selection patterns](https://appwrite.io/docs/products/databases/queries#select-patterns)
          * [Optimize performance](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23select-performance)
      * [Comparison operators](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23comparison)
          * [Equal](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23equal)
          * [Not equal](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-equal)
          * [Less than](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23less-than)
          * [Less than or equal](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23less-than-equal)
          * [Greater than](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23greater-than)
          * [Greater than or equal](https://appwrite.io/docs/products/databases/queries#greater-than-equal)
          * [Between](https://appwrite.io/docs/products/databases/queries#between)
          * [Not between](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-between)
      * [Null checks](https://appwrite.io/docs/products/databases/queries#null-checks)
          * [Is null](https://appwrite.io/docs/products/databases/queries#is-null)
          * [Is not null](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23is-not-null)
      * [String operations](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23string-operations)
          * [Starts with](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23starts-with)
          * [Not starts with](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-starts-with)
          * [Ends with](https://appwrite.io/docs/products/databases/queries#ends-with)
          * [Not ends with](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-ends-with)
          * [Contains](https://appwrite.io/docs/products/databases/queries#contains)
          * [Not contains](https://appwrite.io/docs/products/databases/queries#not-contains)
          * [Search](https://appwrite.io/docs/products/databases/queries#search)
          * [Not search](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-search)
      * [Logical operators](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23logical-operators)
          * [AND](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23and)
          * [OR](https://appwrite.io/docs/products/databases/queries#or)
      * [Ordering](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23ordering)
          * [Order descending](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23order-desc)
          * [Order ascending](https://appwrite.io/docs/products/databases/queries#order-asc)
          * [Order random](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23order-random)
      * [Pagination](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23pagination)
          * [Limit](https://appwrite.io/docs/products/databases/queries#limit)
          * [Offset](https://appwrite.io/docs/products/databases/queries#offset)
          * [Cursor after](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23cursor-after)
          * [Cursor before](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23cursor-before)
  * [Time helpers](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23time-helpers)
      * [Created before](https://appwrite.io/docs/products/databases/queries#created-before)
      * [Created after](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23created-after)
      * [Updated before](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23updated-before)
      * [Updated after](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23updated-after)
  * [Geo queries and spatial operations](https://appwrite.io/docs/products/databases/queries#geo-queries)
      * [Distance equal](https://appwrite.io/docs/products/databases/queries#distance-equal)
      * [Distance not equal](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23distance-not-equal)
      * [Distance greater than](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23distance-greater-than)
      * [Distance less than](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23distance-less-than)
      * [Intersects](https://appwrite.io/docs/products/databases/queries#intersects)
      * [Not intersects](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-intersects)
      * [Overlaps](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23overlaps)
      * [Not overlaps](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-overlaps)
      * [Touches](https://appwrite.io/docs/products/databases/queries#touches)
      * [Not touches](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-touches)
      * [Crosses](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23crosses)
      * [Not crosses](https://www.google.com/search?q=https://appwrite.io/docs/products/databases/queries%23not-crosses)
  * [Complex queries](https://appwrite.io/docs/products/databases/queries#complex-queries)

-----

  * [Discord](https://appwrite.io/discord)
  * [Github](https://github.com/appwrite)
  * [Twitter](https://twitter.com/intent/follow?screen_name=appwrite)
  * [LinkedIn](https://linkedin.com/company/appwrite)
  * [YouTube](https://youtube.com/c/appwrite?sub_confirmation=1)
  * [Daily.dev](https://app.daily.dev/squads/appwrite)
  * [Bluesky](https://www.google.com/search?q=https://bsky.app/profile/appwrite.io)
  * [Tiktok](https://tiktok.com/@appwrite)
  * [Instagram](https://instagram.com/appwrite.io)
  * [Support](https://appwrite.io/discord)
  * [Status](https://appwrite.online/)

[cite\_start]Copyright © 2025 Appwrite [cite: 2214]