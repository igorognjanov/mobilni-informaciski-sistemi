import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  Widget _createTextField(
      String title, TextEditingController controller, bool obscure) {
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

  void _navigateToLogin() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: null,
                            icon: Icon(Icons.poll,
                                color: Colors.black, size: 32.0)),
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    _createTextField(
                        'Enter your email address', _emailController, false),
                    const SizedBox(height: 16.0),
                    _createTextField('Password', _passwordController, true),
                    const SizedBox(height: 16.0),
                    _createTextField(
                        'Confirm Password', _confirmPassword, true),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Handle login logic
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          backgroundColor: Colors.black87),
                      child: const Text('Register'),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                            onPressed: () => _navigateToLogin(), child: Text('Login instead'))
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
