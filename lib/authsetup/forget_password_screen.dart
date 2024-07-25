
import 'package:flutter/material.dart';
import 'package:hr_policies/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reset Password'),
        backgroundColor: const Color(0xffffa726), // Bright orange color
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your email to reset your password',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFE0E0E0).withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: Colors.black54),
                ),
              ),
              const SizedBox(height: 20),
              Consumer<ResetProvider>(
                builder:
                    (BuildContext context, ResetProvider value, Widget? child) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xffffa726), // Bright orange color
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: value.isLoading ? null : (){
                        if (_formKey.currentState!.validate()) {
                          value.resetPassword(emailController: _emailController, context: context);
                        }
                      },
                      child: value.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Reset Password',
                              style: TextStyle(
                                color: Color(0xffffffff), // White color
                                fontSize: 18,
                              ),
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Back to Login',
                  style: TextStyle(color: Color(0xffffa726)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
