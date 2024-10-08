import 'dart:async';
import 'dart:io'; // Use dart:io for checking internet

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:souls_master/bindings/bindings.dart';
import 'package:souls_master/constants/my_color.dart';
import 'package:souls_master/view/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isConnected = true; // Track internet connection status
  bool isCheckingConnection = false; // Track loading status for retry
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _checkInternet(); // Check internet immediately
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  // Method to check internet connectivity via HTTP request
  void _checkInternet() async {
    setState(() {
      isCheckingConnection = true; // Show loader on retry
    });
    try {
      // Ping Google DNS to check internet connectivity
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Internet is available, proceed to the main screen
        _navigateToMainScreen();
      } else {
        setState(() {
          isConnected = false; // No internet connection
        });
      }
    } on SocketException catch (_) {
      // No internet connection
      setState(() {
        isConnected = false;
      });
    } finally {
      setState(() {
        isCheckingConnection = false; // Hide loader after check
      });
    }
  }

  // Method to navigate to the MainScreen after a delay
  void _navigateToMainScreen() {
    _timer = Timer(const Duration(milliseconds: 1800), () {
      Get.off(
        () => const MainScreen(),
        transition: Transition.fadeIn,
        binding: MainScreenBinding(),
        duration: const Duration(seconds: 1),
      );
    });
  }

  // Method to manually refresh the internet connection status
  void _refresh() {
    setState(() {
      isConnected = true; // Assume connection and recheck
    });
    _checkInternet(); // Recheck connection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.splashScreenBg,
      body: Center(
        child: isConnected
            ? const SizedBox(
                height: 70,
                width: 70,
                child: SpinKitWave(
                  color: Color.fromRGBO(173, 160, 84, 1),
                  duration: Duration(seconds: 3),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'ارتباط با سرور برقرار نشد!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: _refresh,
                    child: const Text(
                      'تلاش مجدد',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (isCheckingConnection)
                    const SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ), // Show this while checking connection
                ],
              ),
      ),
    );
  }
}
