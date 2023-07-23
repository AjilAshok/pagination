import 'package:flutter/material.dart';
import 'package:paginationone/controller/auth_controller.dart';
import 'package:paginationone/view/logine_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('HomePage'),
      ),
      body: const Center(
        child: Text('You are loged in'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          handleSignOut(context, authController);
        },
        child: const Text('Logout'),
      ),
    );
  }

  void handleSignOut(
      BuildContext context, AuthController authController) async {
    await authController.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }
}
