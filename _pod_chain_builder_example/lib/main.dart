import 'package:flutter/material.dart';
import 'package:xyz_pod/xyz_pod.dart';

mixin ServiceMixin {
  Future<void> startService();
  Future<void> stopService();
}

// -----------------------------------------------------------------------------
//
// 1. Create a service for each feature of your app.
//
// -----------------------------------------------------------------------------

class AuthenticationService with ServiceMixin {
  final pIsAuthenticated = Pod<bool>(false);
  final pIdToken = Pod<String?>(null);

  AuthenticationService() {
    print("AuthenticationService created");
  }

  Future<void> startService() async {
    await stopService();
    // ...
  }

  Future<void> stopService() async {
    // ...
  }
}

// -----------------------------------------------------------------------------

class DatabaseService with ServiceMixin {
  final pUserDataService = Pod<UserDataService?>(null);
  final pConnectionService = Pod<ContactsService?>(null);

  DatabaseService() {
    print("DatabaseService created");
  }

  Future<void> startService() async {
    stopService();
    await pUserDataService.set(UserDataService());
    await pConnectionService.set(ContactsService());
  }

  Future<void> stopService() async {
    await pUserDataService.set(null);
    await pConnectionService.set(null);
  }

  // ...
}

// -----------------------------------------------------------------------------

class UserDataService with ServiceMixin {
  final pUserModel = Pod<UserModel?>(null);

  UserDataService() {
    print("UserDataService created");
  }

  @override
  Future<void> startService() async {
    await stopService();
    pUserModel.set(
      UserModel(
        name: "Holden Ford",
        email: "holden.ford@gmail.com",
      ),
    );
    // ...
  }

  @override
  Future<void> stopService() async {
    pUserModel.set(null);
  }

  // ...
}

class UserModel {
  final String name;
  final String email;

  UserModel({
    required this.name,
    required this.email,
  });
}

// -----------------------------------------------------------------------------

class ContactsService with ServiceMixin {
  ContactsService() {
    print("ContactsService created");
  }

  @override
  Future<void> startService() async {
    await stopService();
    // ...
  }

  @override
  Future<void> stopService() async {
    // ...
  }

  // ...
}

// -----------------------------------------------------------------------------

/// A service that handes push notifications.
class PushNotificationService with ServiceMixin {
  PushNotificationService() {
    print("PushNotificationService created");
  }

  @override
  Future<void> startService() async {
    await stopService();
    // ...
  }

  @override
  Future<void> stopService() async {
    // ...
  }

  // ...
}

// -----------------------------------------------------------------------------
//
// 2. Create an app service to hold the global state of your application.
//
// -----------------------------------------------------------------------------

final appService = AppService();

class AppService with ServiceMixin {
  final pAuthenticationService = Pod<AuthenticationService?>(null);
  final pDatabaseService = Pod<DatabaseService?>(null);
  final pPushNotificationService = Pod<PushNotificationService?>(null);

  AppService() {
    print("AppService created");
  }

  @override
  Future<void> startService() async {
    await stopService();
    await pAuthenticationService.set(AuthenticationService());
    await pAuthenticationService.value?.startService();
    await pDatabaseService.set(DatabaseService());
    await pDatabaseService.value?.startService();
    await pPushNotificationService.set(PushNotificationService());
    await pPushNotificationService.value?.startService();
    // ...
  }

  @override
  Future<void> stopService() async {
    // ...
    await pAuthenticationService.value?.stopService();
    await pAuthenticationService.set(null);
    await pDatabaseService.value?.stopService();
    await pDatabaseService.set(null);
    await pPushNotificationService.value?.stopService();
    await pPushNotificationService.set(null);
  }

  // ...
}

// -----------------------------------------------------------------------------
//
// 3. Consume this information in your UI.
//
// -----------------------------------------------------------------------------

void main() {
  runApp(
    MaterialApp(
      home: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                appService.startService();
              },
              child: Text("Start AppService"),
            ),
            TextButton(
              onPressed: () {
                appService.stopService();
              },
              child: Text("Stop AppService"),
            ),
            FilledButton(
              onPressed: () {
                appService.pDatabaseService.value?.pUserDataService.value
                    ?.startService();
              },
              child: Text("Start UserService (if it exists)"),
            ),
            TextButton(
              onPressed: () {
                appService.pDatabaseService.value?.pUserDataService.value
                    ?.stopService();
              },
              child: Text("Stop UserService (if it exists)"),
            ),
            FilledButton(
              onPressed: () {
                appService
                    .pDatabaseService.value?.pUserDataService.value?.pUserModel
                    .update(
                  (e) => e != null
                      ? UserModel(name: "${e.name}!", email: e.email)
                      : UserModel(
                          name: "Bob Marley",
                          email: "bob.marley@yahoo.wtf",
                        ),
                );
              },
              child: Text("Add '!' to name"),
            ),
            const SizedBox(height: 80.0),
            // Create a PodRemapper to listen to multiple Pods and remap them
            // to one or more values of type UserModel.
            PodRemapper<UserModel>(
              // Provide some pods to listen to. They can be null or non-null.
              pods: [
                appService.pDatabaseService.value?.pUserDataService,
                appService.pDatabaseService,
              ],
              // Remap the pods to other pods.
              remappers: [
                remap<DatabaseService, UserDataService?>(
                    (e) => [e.pUserDataService]),
                remap<UserDataService, UserModel?>((e) => [e.pUserModel]),
              ],
              builder: (context, child, Iterable<UserModel> values) {
                final userModel = values.first; // values will never be empty.
                return Text("${userModel.name}");
              },
              // If values are empty, show a placeholder.
              emptyBuilder: (context, child) {
                return child;
              },
              child: Text("Loading..."),
            ),
          ],
        ),
      ),
    ),
  );
}
