import 'package:flutter/material.dart';
import 'package:paginationone/view/homepage.dart';
import 'package:paginationone/view/logine_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Check if the user is already logged in.
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          bool isLoggedIn = snapshot.data ?? false;
          // print(isLoggedIn);
          return MaterialApp(
            home: isLoggedIn ? const HomePage() : LoginView(),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("user_id");
    return userId != null;
  }
}
