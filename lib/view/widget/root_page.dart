import 'package:flutter/material.dart';
import 'package:paginationone/controller/auth_controller.dart';
import 'package:paginationone/view/homepage.dart';
import 'package:paginationone/view/logine_view.dart';
import 'package:provider/provider.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    // Check if the user is logged in
    if (authController.user != null) {
      return const HomePage(); // If logged in, show the home page
    } else {
      return LoginView(); // If not logged in, show the login view
    }
  }
}