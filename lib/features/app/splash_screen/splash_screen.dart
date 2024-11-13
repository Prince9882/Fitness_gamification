import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _State();
}

class _State extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5),() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => widget.child!));
    });

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Welcome to Fitness app",
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
            )),
      ),
    );
  }
}
