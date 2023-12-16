// -----------------------------------------------------------------------------
//
// Example 2: A basic example on how to use PodList, PodListHelper and
// PodListBuilder.
//
// Copyright (c) 2023 Robert Mollentze
// See LICENSE for details.
//
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:xyz_pod/xyz_pod.dart';

// -----------------------------------------------------------------------------

mixin PodServiceMixin {
  Future<void> startService();
  Future<void> stopService();
}

// -----------------------------------------------------------------------------

class AuthenticationService with PodServiceMixin {
  final pIsAuthenticated = Pod<bool>(false);
  final pIdToken = Pod<String?>(null);

  @override
  Future<void> startService() async {
    // Simulating service start delay.
    await Future.delayed(Duration(seconds: 1));
    pIsAuthenticated.set(true);
    pIdToken.set("id_12345");
  }

  @override
  Future<void> stopService() async {
    pIsAuthenticated.set(false);
    pIdToken.set(null);
  }
}

// -----------------------------------------------------------------------------

class UserDataService with PodServiceMixin {
  final pUserModel = Pod<UserModel?>(null);

  @override
  Future<void> startService() async {
    // Simulating service start delay.
    await Future.delayed(Duration(seconds: 2));
    final userModelFromDatabase = UserModel(
      name: "Foo Bar",
      email: "foo.bar@hello.world",
    );
    pUserModel.set(userModelFromDatabase);
    print("SET!!!");
  }

  @override
  Future<void> stopService() async {
    pUserModel.set(null);
  }
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

class AppService with PodServiceMixin {
  final pAuthenticationService = Pod<AuthenticationService?>(null);
  final pUserDataService = Pod<UserDataService?>(null);

  @override
  Future<void> startService() async {
    final authService = AuthenticationService();
    await authService.startService();
    pAuthenticationService.set(authService);
    final userDataService = UserDataService();
    await userDataService.startService();
    pUserDataService.set(userDataService);
  }

  @override
  Future<void> stopService() async {
    await pAuthenticationService.value?.stopService();
    pAuthenticationService.set(null);
    await pUserDataService.value?.stopService();
    pUserDataService.set(null);
  }
}

// -----------------------------------------------------------------------------

final appService = AppService();

// -----------------------------------------------------------------------------

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
                onPressed: () => appService.startService(),
                child: Text("Start Services"),
              ),
              ElevatedButton(
                onPressed: () => appService.stopService(),
                child: Text("Stop Services"),
              ),
              SizedBox(height: 20),
              PodRebuilder<String>(
                pods: [
                  //appService.pUserDataService,
                  appService.pAuthenticationService,
                ],
                remappers: [
                  // (e) {
                  //   final userDataService = (e.firstOrNull as UserDataService?);
                  //   print(userDataService);
                  //   return [
                  //     userDataService?.pUserModel, // first value returned
                  //   ];
                  // },
                  (e) {
                    final authService = (e.firstOrNull as AuthenticationService?);
                    print(authService?.pIsAuthenticated.value);
                    print(authService?.pIdToken.value);
                    return [
                      authService?.pIsAuthenticated, // second value returned
                      authService?.pIdToken, // third value returned
                    ];
                  },
                ],
                builder: (context, child, values) {
                  return Text("${values.toString()}");
                  // final tuple = getAs3<UserModel?, bool, String?>(values);
                  // final userName = tuple.$1?.name;
                  // final isAuthenticated = tuple.$2;
                  // final idToken = tuple.$3;
                  // return Text(
                  //   "User: $userName\n"
                  //   "Is Authenticated: $isAuthenticated\n"
                  //   "Id Token: $idToken",
                  // );
                },
                // emptyBuilder: (context, child) {
                //   return Text("Waiting for user data...");
                // },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
