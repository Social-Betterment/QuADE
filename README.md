# QuADE - Quick Appwrite Database Editor

A Flutter app to quickly edit an Appwrite database with functions to delete, search, sort, find and replace.

WARNING: This code has NOT been thoroughly tested. Use at your own risk. Make sure you have turned on daily backups of your database in Appwrite.

This app is hosted at https://quade.vercel.app

Configurations are stored in the browser's Local Storage using the shared_preferences package. BE CAREFUL not to leave configurations on unsecured computers.
You will need to create an API key from the project Overview > Integrations > API Keys . The shorter to expiration date the more safe it is.

See PRD.md for detailed specifications.

To run from source:

```
flutter pub get
fiutter run -d chrome --web-port=9500
```

We specify a port so the browser's Local Storage will still be there each time we re-run the app.
