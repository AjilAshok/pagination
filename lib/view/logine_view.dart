// import 'package:flutter/material.dart';
// import 'package:paginationone/controller/auth_controller.dart';

// class YourHomePage extends StatefulWidget {
//   @override
//   _YourHomePageState createState() => _YourHomePageState();
// }

// class _YourHomePageState extends State<YourHomePage> {
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _otpController = TextEditingController();
//   final AuthController _authController = AuthController();

//   void _verifyPhoneNumber() async {
//     String phoneNumber = '+91${_phoneNumberController.text.trim()}';
//     await _authController.verifyPhoneNumber(phoneNumber);
//   }

//   void _signInWithOTP() async {
//     String otp = _otpController.text.trim();
//     await _authController.signInWithOTP(otp);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Firebase OTP Verification')),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextField(
//                 controller: _phoneNumberController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(labelText: 'Phone Number'),
//               ),
//               ElevatedButton(
//                 onPressed: _verifyPhoneNumber,
//                 child: Text('Send OTP'),
//               ),
//               TextField(
//                 controller: _otpController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: 'Enter OTP'),
//               ),
//               ElevatedButton(
//                 onPressed: _signInWithOTP,
//                 child: Text('Verify OTP'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
                  if (authController.user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  } else {
                    // Handle login failure or show an error message.
                    print('Sign in with OTP failed');
                  }
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
