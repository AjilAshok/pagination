import 'package:flutter/material.dart';
import 'package:paginationone/controller/auth_controller.dart';
import 'package:paginationone/view/homepage.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              ElevatedButton(
                onPressed: () {
                  String phoneNumber =
                      '+91${_phoneNumberController.text.trim()}';
                  authController.verifyPhoneNumber(phoneNumber);
                },
                child: Text('Verify Phone Number'),
              ),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'OTP'),
              ),
              ElevatedButton(
                onPressed: () {
                  authController.signInWithOTP(_otpController.text);
                  print(authController.user);
                  authController.addListener(() {
                    if (authController.user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    }
                  });

                  // if (authController.user != null) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => const HomePage()),
                  //   );
                  // } else {
                  //   // Handle login failure or show an error message.
                  //   print('Sign in with OTP failed');
                  // }
                },
                child: Text('Sign In with OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
