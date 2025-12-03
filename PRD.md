# Quick Appwrite Database Editor Product Requirments Document (PRD)

## Introduction

We want to create a Flutter app to quickly edit an Appwrite database with functions to delete, search, sort, find and replace.

The API to access the Appwrite database is described in APPWRITE-API.md using the dart_appwrite package.

## Authorization Method

We will store configurations locally using the SharedPreferences package.

The appwrite client is initialized like this:
```
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://<REGION>.cloud.appwrite.io/v1')
    .setProject('<YOUR_PROJECT_ID>')
    .setKey('<YOUR_API_KEY>'); // Your API key
```

## STEP 1:

Generate a Flutter app with an appbar with the title "QuADE" and scaffold to host various page views.

Using the go_router package generate pages and routes for ConfigsPage, DatabasesPage, TablesPage, TablePage.

Our app will start in ConfigsPage.

## STEP 2:

On the left side of the appbar will be a key icon that navigates to ConfigsPage.

This page will be a scrollable view of configuration Cards and a FAB to create a new configuration Card.
Each Card contains three configura1tion textfields corresponding to Endpoint, Project ID, Dev Key. Also it will have a button to 'Load' the configuration, and and icon to Delete the configuration, and a button to 'Save' the configuration.
Use SharedPreferences to load and save the array of configurations.

The 'Load' button will use the configuration to setup the appwrite Client() in a singleton Notifier Provider called AppwriteNotifier, and navigate to the DatabasesPage. AppwriteNotifier will provide functions to call the Appwrite API with the Client.

The Delete icon will diplay a confirmation popup which if confirmed will delete the configuration from SharePreferences and update the ConfigsPage list of Cards.

The 'Save' button will save the Card's configuration into SharedPreferences.

If the page loads with an empty list of configurations, create a new configuration card read for the user to fill in.

## STEP 3:

The DatabasesPage will be initialized with String? project_id. On notification from AppwriteNotifier will check if the project_id has changed, if so set the project_id and call the API from AppwriteNotifier to List Databases.

The appbar will display a breadcrumb with the key icon, ">", database icon. Clicking on the key icon will navigate back to the ConfigsPage.

The page will have a scrollable list of the Databases returned.

Selecting a Database from the list will navigate to the TablesPage with the database_id and database.name.

## STEP 4:

The TablesPage will be initialized with String? database_id and String table_name on navigation to the page. On change of database_id, the page will List Tables from the API provided by AppwriteNotifier.

The page will display a scrollable list of Tables (table_id, etc.) returned by the List Tables call.

The appbar will display a breadcrumb with the key icon, ">", database icon, ">", tables icon, Clicking the database icon will navigate to the previous DatabasesPage. Likewise the key icon navigates to the ConfigsPage.

Selecting a Table in the list will navigate to the TablePage with the database_id, table_id, and table.name.

## STEP 5:

The TablePage will be initialized with String? database_id and String? table_id on navigation to the page. On change of database_id or table_id, the page will Get Table then List Rows from the API provided by AppwriteNotifier. The call will use the linit and offset parameters to paginate.

The page will display a paginated list of Rows from List Rows. There will be controls to paginate and display to display the total number of rows.

Each Row will be a editable text field for each field in the Row. If a field has been editied it will display a control with an tick or cross icon to update the field. Likewise, the row will have a control to update all the edited fields in the row.
Use the Update Row function to update the data with the edited fields converted to the appropriate type for each field.

The fields in the Row can be arranged horizontally if there is space (with appropriate horizontal padding), then vertically if there is no more space.
Check the fields contents length in all the loaded rows (as rows are loaded record the max length so far) to determine how much width to give each control.
Consider also the width of the field label when determining the final width. If possible put the "Update All" button on the same Row.

The appbar will display a breadcrumb with the key icon, ">", database icon, ">", tables icon, ">", table icon, Table: <table_name> Clicking the tables icon will navigate to the previous TablesPage. Likewise the key icon navigates to the ConfigsPage, etc.

## STEP 6:

The TablePage will have a special Row of editable fields above the List display corresponding to each field in the row. The special Row will be called the QueryByExampleRow. If the editable field is non-empty, then it will serve as a query filter parameter for the page's List Rows call. Above the QueryByExampleRow will be the title "Query by Example" and a "Apply Sort/Filter" button which triggers the List Rows Call. A "Clear Sort/Filter" button will clear the fields and call List Rows.
The QueryByExample fields will configure Query parameters used in the List Rows call. Design a Query by Example language that encompasses all the Query types in APPRWRITE-QUERY.md.
Add a help icon which pops up a dialog explaining your Query by Example language usage. The help icon should be next to the "Query by Example" title. Use the markdown_widget package if you need to use Markdown styled text in your instructions.

## STEP 7:

Sorting the table. On the QBE fields will be a a control that can display an icon that is Up, Down, or Neutral to represents a sorting specification. This will add Query.orderAsc(<field>) or Query.orderDesc(<field>) to the List Rows call.
Next to the icon will be a number indicating the priority of the sort. The first non-neutral sort adjusted will be assigned 1, then 2 etc.
If a sort is cancelled by setting it to neutral, the numbers will be recalculated (essentially its order in the array + 1). "Clear Sort/Filter" will clear all the Sorting.

## STEP 8:

We want a find and replace dialog. After the QBE button "Clear Sort/Filter" will be a "Find & Replace..." button that triggers the dialog.

It will let the user select from a dropdown list one of the fields of the current table. Then there will be a Find field for what text to find. Next, there will be a Replace field to specify what to replace the found text with.
Then there is a sliding selector for All Instances on ("This Page" / "All Pages"). There will be a Cancel and "Review..." button.

The Review... button will copy the current page's query to find the page of rows (according to the current pagination) or all rows in the current ListRows query, for a match for the Find value, it will navigate to a Find and Replace page (similar to TablePage) with all the rows matching and the Replaced text highlighted in green in the replacement field of all the rows. All the rows will be read-only - remove field editing, update row, and delete row.

At the top of the Page, instead of Query by Example title & controls, it will have the appbar title "Find and Replace" and two buttons, "Write All to Database", and "Cancel".
"Cancel" will go back to the previous TablePage. "Write All to Database" will then write all the changes to all the affected rows in a Transaction. The Transactions API is described in APPWRITE-TRANSACTIONS.md . It will display a circular progress indicator and the text "Transaction Running". It will end with text displaying "Transaction Complete" or "Transaction Cancelled". Do this in a modal dialog. Have a button to Cancel (or Close if the process is finished/failed). Disable the button if it is in a state that you can't stop.

The appbar will display a breadcrumb with the key icon, ">", database icon, ">", tables icon, ">", table icon, ">", find and replace icon. Clicking the tableq icon will navigate to the previous TablePage. Likewise the key icon navigates to the ConfigsPage, etc.

## STEP 9:

Add meta fields $id $createdAt $updatedAt to the Query by Example and the row_widget display but after the the non-meta fields.

## STEP 10:

On the top right of row_widget add a delete icon which when pressed with show a confirmation dialog. If confirmed it will call Delete Row.

## STEP 11:

On the right end of the QueryByExampleRow will be a red background button labelled "Mass Delete". The button will trigger a popup with the warning "Do you really want to DELETE multiple rows?", and "ALL the rows in the current query will be DELETED.". Then there will be a text entry box with the label "Type the total count of the rows". If the user types the number of total rows, as displayed on the pagination controls on TablePage, then a red "Delete" button will appear along with a "Cancel" button. If the entry box is empty or does not equal the total rows, then only a "Cancel" button will appear. The text entry box will start off empty.

If the "Delete" button is pressed, then a Transaction will be created using with Delete Row calls for the row $id's in the current query. The Delete button will be disabled. A  circular progress indicator will be displayed and the text "Transaction Running". It will end with text displaying "Transaction Complete" or "Transaction Cancelled". Do this in a modal dialog. Have a button to Cancel (or Close if the process is finished/failed). Disable the button if it is in a state that you can't stop.

Disable this Mass Delete feature in a feature flag in the code.

## STEP 12:

For @lib/models/config.dart and @lib/pages/configs_page.dart add a 'Plan' property with the following possible settings and descriptions "Free Plan: 100 operations per transaction, Pro Plan: 1000 operations per transaction, Scale Plan: 2500 operations per transaction". Adjust the transaction in @lib/pages/find_and_replace_page.dart to batch the transaction by the limit set by the plan (100, 1000, 2500). Apply the same batching technique to the mass delete transaction @lib/pages/table_page.dart

## STEP 13:

At the end of the config cards, add a note "Due to geographic, legal, and security settings, API keys might not across regions. In that case build your own QuADE from source. This server is in Frankfurt, Germany.". Make sure the text wraps on small screens.             

Also add, "The sample API key is read-only and will not allow you to make any changes to the sample Appwrite instance."