import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paginationone/view/widget/root_page.dart';
import 'package:provider/provider.dart';

import 'controller/auth_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthController(), // Provide the AuthController
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My App',
        home: RootPage(), // Replace with your home page widget
      ),
    );
  }
}
