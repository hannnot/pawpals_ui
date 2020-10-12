import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/sceens/admin/adminAccountScreen.dart';
import 'package:pawpals_ui/src/sceens/admin/adminDashboardScreen.dart';
import 'package:pawpals_ui/src/sceens/admin/adminManageUserScreen.dart';
import 'package:pawpals_ui/src/sceens/changePasswordScreen.dart';
import 'package:pawpals_ui/src/sceens/homeScreen.dart';
import 'package:pawpals_ui/src/sceens/registrationScreen.dart';
import 'package:pawpals_ui/src/sceens/user/userDashboardScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PawPals',
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.teal[800]),
        ),
        home: HomeScreen(),
        routes: {
          '/register': (context) => RegistrationScreen(),
          '/admin-dashboard': (context) => AdminDashboardScreen(),
          '/user-dashboard': (context) => UserDashboardScreen(),
          '/manage-users': (context) => AdminManageUserScreen(),
          '/change-pwd' : (context) => ChangePassworScreen(),
          '/admin-account' : (context) => AdminAccountScreen(),
        });
  }
}
