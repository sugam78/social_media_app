import 'package:flutter/material.dart';
import 'package:social_media_app/Features/Auth/Services/auth_service.dart';

import '../../../Core/Constants/global_variables.dart';
import '../../../Core/Widgets/custom_text_field.dart';
import '../../../Core/Widgets/reusuable_button.dart';



enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> signUpUser() async {
    await authService.signUpUser(_nameController.text, _emailController.text, _passwordController.text, context);
  }
  Future<void> signInUser() async {
    await authService.signInUser(_emailController.text, _passwordController.text, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              ListTile(
                tileColor: _auth == Auth.signUp
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signUp,
                  groupValue: _auth,
                  onChanged: (auth) {
                    setState(() {
                      _auth = auth!;
                    });
                  },
                ),
                title: const Text(
                  'Create account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              if (_auth == Auth.signUp)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _nameController,
                              hintText: 'Enter Name'),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              controller: _emailController,
                              hintText: 'Enter Email'),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              controller: _passwordController,
                              hintText: 'Enter Password'),
                          const SizedBox(
                            height: 10,
                          ),
                          ReusuableButton(
                            title: 'Sign Up',
                            onTap: () async{
                              if (_signUpFormKey.currentState?.validate() ??
                                  false) {
                                await signUpUser();
                              }
                            },
                            color: GlobalVariables.secondaryColor,
                          )
                        ],
                      )),
                ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                tileColor: _auth == Auth.signIn
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signIn,
                  groupValue: _auth,
                  onChanged: (auth) {
                    setState(() {
                      _auth = auth!;
                    });
                  },
                ),
                title: const Text(
                  'Sign In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              if (_auth == Auth.signIn)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: _emailController,
                              hintText: 'Enter Email'),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              controller: _passwordController,
                              hintText: 'Enter Password'),
                          const SizedBox(
                            height: 10,
                          ),
                          ReusuableButton(
                            title: 'Sign In',
                            onTap: () async {
                              if (_signInFormKey.currentState?.validate() ??
                                  false){
                                await signInUser();
                              }
                            },
                            color: GlobalVariables.secondaryColor,
                          )
                        ],
                      )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}