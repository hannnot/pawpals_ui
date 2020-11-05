import 'package:flutter/material.dart';
import 'package:pawpals_ui/src/sceens/addAboutScreen.dart';
import 'package:pawpals_ui/src/sceens/addAddressScreen.dart';
import 'package:pawpals_ui/src/sceens/addAnimalsScreen.dart';
import 'package:pawpals_ui/src/sceens/admin/adminAccountScreen.dart';
import 'package:pawpals_ui/src/sceens/admin/adminDashboardScreen.dart';
import 'package:pawpals_ui/src/sceens/admin/adminManageUserScreen.dart';
import 'package:pawpals_ui/src/sceens/browseSitScreen.dart';
import 'package:pawpals_ui/src/sceens/changePasswordScreen.dart';
import 'package:pawpals_ui/src/sceens/homeScreen.dart';
import 'package:pawpals_ui/src/sceens/registrationScreen.dart';
import 'package:pawpals_ui/src/sceens/requestSitScreen.dart';
import 'package:pawpals_ui/src/sceens/selectAnimalScreen.dart';
import 'package:pawpals_ui/src/sceens/user/settingsScreen.dart';
import 'package:pawpals_ui/src/sceens/user/userAccountScreen.dart';
import 'package:pawpals_ui/src/sceens/user/userDashboardScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        '/change-pwd': (context) => ChangePassworScreen(),
        '/admin-account': (context) => AdminAccountScreen(),
        '/request-sit': (context) => RequestSitScreen(),
        '/settings': (context) => SettingsScreen(),
        '/user-account': (context) => UserAccountScreen(),
        '/browse-sit': (context) => BrowseSitScreen(),
        '/add-address': (context) => AddAddressScreen(),
        '/about': (context) => AddAboutScreen(),
        '/add-animals': (context) => AddAnimalsScreen(),
        '/select-animal': (context) => SelectAnimalScreen(),
      },
    );
  }
}
