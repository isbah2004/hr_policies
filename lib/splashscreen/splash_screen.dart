import 'package:flutter/material.dart';
import 'package:hr_policies/authsetup/custom_clipper.dart';
import 'package:hr_policies/splashscreen/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with custom clipper
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/login_image.jpg'), // Use your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                ),
                // Logo or App Name
                Text(
                  'HR Policies',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffffa726), // Bright orange color
                  ),
                ),
                SizedBox(height: 16),
                // Loading Indicator
                CircularProgressIndicator(
                  color: Color(0xffffa726), // Bright orange color
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
