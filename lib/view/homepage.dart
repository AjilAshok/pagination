import 'package:flutter/material.dart';
import 'package:paginationone/controller/auth_controller.dart';
import 'package:paginationone/view/logine_view.dart';
import 'package:provider/provider.dart';
import 'package:number_paginator/number_paginator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentpage = 1;
  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('HomePage'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 650,
            child: Center(
              child: Text('You are loged in'),
            ),
          ),
          NumberPaginator(
            numberPages: 20,
            onPageChange: (index) {
              setState(() {
                currentpage = index;
              });
            },
          )
        ],
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
