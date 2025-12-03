# QuADE - Quick Appwrite Database Editor

A Flutter app to quickly edit an Appwrite database with functions to delete, search, sort, find and replace.

WARNING: This code has NOT been thoroughly tested. Use at your own risk. Make sure you have turned on daily backups of your database in Appwrite.

This app is hosted at https://quade-demo.appwrite.network

Configurations are stored in the browser's Local Storage using the shared_preferences package. BE CAREFUL not to leave configurations on unsecured computers.
You will need to create an API key from the project Overview > Integrations > API Keys . The shorter to expiration date the more safe it is.
You only need to give row.write permissions and read permission for the other Database permissions.

Due to geographic, legal, and security settings, API keys might not work across regions. In that case, build your own QuADE from source. The public server is in Frankfurt, Germany.

The sample API key is READ-ONLY and will not allow you to make any changes to the sample Appwrite instance.

See PRD.md for detailed specifications.

To run from source:

```
flutter pub get
fiutter run -d chrome --web-port=9500
```

We specify a port so the browser's Local Storage will still be there each time we re-run the app.
