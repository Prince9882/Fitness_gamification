import 'package:fitbeast_finalversion/features/user_auth/presentation/widgets/form_containerwidgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white54.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow:[
                    BoxShadow(
                        color:Colors.black.withOpacity(0.2),
                        blurRadius:10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("FitBeast",style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    ),
                    SizedBox(height: 10),
                    Text("Log in to You r account",style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[610],
                    ),
                    ),
                    SizedBox(height: 30),
                    CustomInputFieldContainer(
                      placeholderText : "Email",
                      isSecureField: false,
                    ),
                    SizedBox(height: 10),
                    CustomInputFieldContainer(
                      placeholderText : "Password",
                      isSecureField: true,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
