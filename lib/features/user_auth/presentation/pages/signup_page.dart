import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbeast_finalversion/features/user_auth/firebase_implementation/firebase_services.dart';
import 'package:fitbeast_finalversion/features/user_auth/presentation/pages/login_screen.dart';
import 'package:fitbeast_finalversion/features/user_auth/presentation/widgets/form_containerwidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'path_to_firebase_auth_service.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseServices _auth = FirebaseServices();


  TextEditingController _nameController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();

  bool signingUpInProgress = false;

  @override
  void dispose(){
    _nameController.dispose();
    _userEmailController.dispose();
    _userPasswordController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          title: Text("Register"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Create Account",style:TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent,),),
               SizedBox(height: 25),
               CustomInputFieldContainer(
                textcontroller: _nameController,
                placeholderText: "Full Name",
                isSecureField : false,
              ),
                SizedBox(height: 12),
                CustomInputFieldContainer(
                  textcontroller: _userEmailController,
                  placeholderText: "Email Address",
                  isSecureField : false,
                ),
              SizedBox(height: 12),
              CustomInputFieldContainer(
                textcontroller: _userPasswordController,
                placeholderText: "Password",
                isSecureField: true,
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: _registerUser,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient:LinearGradient(colors: [Colors.purple,Colors.deepPurpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: signingUpInProgress
                    ? CircularProgressIndicator(color: Colors.white)
                        :Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16,
                    ),
                    ),
                  ),

                ),
              ),
              SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Alredy have an account?"),
            SizedBox(width: 5),
            GestureDetector(
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false
                );
              },
              child: Text("Login",
                style: TextStyle
                  (color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerUser()  async{
    setState(() {
      signingUpInProgress =true;
    });

    String name =_nameController.text;
    String email = _userEmailController.text;
    String password =_userPasswordController.text;

    User? user =await _auth.registerWithEmailPassword(email,password); //calling signup method from firebase auth services

    setState(() {
      signingUpInProgress = false;
    });

    if (user !=null){
      print("Account created successfully!");
      Navigator.pushNamed(context as BuildContext, "/home");
    }else{
      print("Registeration failed. Please try again");
    }
  }

}


