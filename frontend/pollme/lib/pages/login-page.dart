import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pollme/pages/poll-dashboard-page.dart';
import 'package:pollme/pages/register-page.dart';
import 'package:pollme/service/auth-service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _createTextField(String title, TextEditingController controller,
      bool obscure) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50), //// Rounded borders
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0, // Adjust vertical padding
          horizontal: 12.0, // Adjust horizontal padding
        ),
        isDense: true, // Reduce the height of the input field
      ),
      obscureText: obscure,
    );
  }

  void _navigateToRegister() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  void _login() async {
    var result = await login(_emailController.text, _passwordController.text);
    if(result) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PollDashBoardPage()));
    }

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double cardWidth =
        screenWidth - 80; // Subtracting 20 pixels from each side for margin
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
                width: cardWidth,
                height: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text('Email'),
                    ),
                    const SizedBox(height: 16.0),
                    _createTextField(
                        'Enter your email address', _emailController, false),
                    const SizedBox(height: 16.0),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text('Password'),
                    ),
                    const SizedBox(height: 16.0),
                    _createTextField(
                        'Enter your password', _passwordController, true),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () => _login(),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          backgroundColor: Colors.black),
                      child: const Text('Login'),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () => _navigateToRegister(),
                            child: const Text('Register here')),
                        const Text('Forgot your password?')
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
