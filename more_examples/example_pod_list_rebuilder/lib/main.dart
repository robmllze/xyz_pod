// -----------------------------------------------------------------------------
//
// Example 3: Modular Service-Based State Management with PodListRebuilder.
//
// Copyright (c) 2023 Robert Mollentze
// See LICENSE for details.
//
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';

// Import the package.
import 'package:xyz_pod/xyz_pod.dart';

void main() {
  runApp(UserProfileApp());
}

class UserProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('User Profile')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await appService.startService();
                  debugPrint("Services started!");
                },
                child: Text("Start Services"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await appService.stopService();
                  debugPrint("Services stopped!");
                },
                child: Text("Stop Services"),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await appService.pAuthenticationService.value?.logIn();
                    debugPrint("Logged in!");
                  },
                  child: Text("Log In")),
              ElevatedButton(
                  onPressed: () async {
                    await appService.pAuthenticationService.value?.logOut();
                    debugPrint("Logged out!");
                  },
                  child: Text("Log Out")),
              SizedBox(height: 20),
              // PodListRebuilder listens to changes in appService and updates
              // UI.
              PodListRebuilder(
                podList: appService.appServiceWatchListBuilder,
                builder: (context, child, data) {
                  final idToken = appService.idTokenSnapshot();
                  return Text("$idToken");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
//
// Mock Services: Authentication and User Data
//
// In Modular Service-Based State Management (MSM), each part of the app is
// managed by its own service. This setup aims for each service to work
// independently. But sometimes, certain services depend on each other. For
// instance, a database service should start only after a user logs in, and
// shouldn't be stopped before the user logs out. One way to handle this is to
// nest services within each other, creating a hierarchy. However, for this
// example, services are kept separate and straightforward, focusing on clear
// and easy-to-follow interactions between them.
//
// -----------------------------------------------------------------------------

class AuthenticationService with PodServiceMixin {
  final pIsAuthenticated = Pod<bool>(false);
  final pIdToken = Pod<String?>(null);

  @override
  Future<void> startService() async {
    await this.stopService();
    await this.logIn();
  }

  Future<void> logIn() async {
    await Future.delayed(Duration(seconds: 1));
    pIsAuthenticated.set(true);
    pIdToken.set("sample-id-token");
  }

  Future<void> logOut() async {
    await Future.delayed(Duration(seconds: 1));
    pIsAuthenticated.set(false);
    pIdToken.set(null);
  }

  @override
  Future<void> stopService() async {
    pIsAuthenticated.set(false);
    pIdToken.set(null);
  }
}

class UserDataService with PodServiceMixin {
  final pUserModel = Pod<UserModel?>(null);

  @override
  Future<void> startService() async {
    await this.stopService();
    await Future.delayed(Duration(seconds: 2));
    pUserModel.set(UserModel(name: "Foo Bar", email: "foo.bar@hello.world"));
  }

  @override
  Future<void> stopService() async {
    pUserModel.set(null);
  }
}

class UserModel {
  final String name;
  final String email;

  UserModel({required this.name, required this.email});
}

// -----------------------------------------------------------------------------
//
// App Service: Managing Global State.
//
// -----------------------------------------------------------------------------

class AppService with PodServiceMixin {
  final pAuthenticationService = Pod<AuthenticationService?>(null);
  final pUserDataService = Pod<UserDataService?>(null);

  @override
  Future<void> startService() async {
    await this.stopService();
    final authService = AuthenticationService();
    final userDataService = UserDataService();
    await authService.startService();
    await userDataService.startService();
    pAuthenticationService.set(authService);
    pUserDataService.set(userDataService);
  }

  @override
  Future<void> stopService() async {
    await pAuthenticationService.value?.stopService();
    await pUserDataService.value?.stopService();
    pAuthenticationService.set(null);
    pUserDataService.set(null);
  }

  // Watch list builder to track and respond to changes in Pods.
  PodList appServiceWatchListBuilder() {
    return [
      pUserDataService,
      pUserDataService.value?.pUserModel,
      pAuthenticationService,
      pAuthenticationService.value?.pIdToken,
      pAuthenticationService.value?.pIsAuthenticated,
    ];
  }

  // Targeted watch list for user model updates.
  PodList userModelWatchListBuilder() {
    return [
      pUserDataService,
      pUserDataService.value?.pUserModel,
    ];
  }

  // Snapshot methods for instant access to Pod values.
  UserModel? userModelSnapshot() => pUserDataService.value?.pUserModel.value;
  String? idTokenSnapshot() => pAuthenticationService.value?.pIdToken.value;
}

final appService = AppService();

// -----------------------------------------------------------------------------

/*
  Summary:

  - This example demonstrates an advanced use of PodListRebuilder in the
    context of app service management.
  - The AppService class is used to manage and coordinate various services such
    as authentication and user data.
  - PodListRebuilder is used to listen to changes in multiple Pods and
    update the UI accordingly.
  - Snapshots provide instant access to the current values of specific Pods.

  Additional Notes:

  - The PodListRebuilder is flexible and efficient, allowing for focused
    updates based on the specific Pods it is watching.
  - The use of mixins (PodServiceMixin) promotes code reuse and clear structure
    in service implementation.
  - This approach to state management keeps the UI in sync with the underlying
    data, ensuring a responsive and dynamic user experience.
  - The modular structure of services and the centralized management via
    AppService facilitate scalability and maintainability of the app.
*/
