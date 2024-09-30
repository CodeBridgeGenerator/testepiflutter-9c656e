import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here, e.g., API call or Firebase Auth.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logging in...')),
      );
    }
  }

  void _setupAccount() {
    // Navigate to the setup account page or perform any action here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigate to account setup page.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header icon
              const Icon(
                Icons.account_circle,
                size: 100.0,
                color: Colors.blue,
              ),
              const SizedBox(height: 16), // Spacing below the icon

              // Login form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Email label and input field
                    const Text(
                      'Email',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    const SizedBox(height: 8), // Spacing between label and input
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter your registered email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16), // Spacing between input fields

                    // Password label and input field
                    const Text(
                      'Password',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    const SizedBox(height: 8), // Spacing between label and input
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    ElevatedButton(
                      onPressed: _login,
                      style: ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 199, 6, 6)), // Set the correct color
     foregroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 251, 250, 250)),
  ),
                      child: const Text('Sign In'),
                    ),
                     const Text(
                      '',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    // Text with hyperlink
                    RichText(
                      text: TextSpan(
                        text: "Haven't activated your account yet? ",
                        style: const TextStyle(color: Colors.black, fontSize: 12),
                        children: [
                          TextSpan(
                            text: 'Set up now',
                            style: const TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _setupAccount, // Handle hyperlink tap
                          ),
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LoginPage(),
  ));
}
