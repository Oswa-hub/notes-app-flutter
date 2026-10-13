import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;


  Future<void> submit() async {

    setState(() {
      loading = true;
    });

    try {

      await context.read<AuthProvider>().login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );


      if (mounted) {
        context.go('/');
      }


    } catch (e) {

      if (mounted) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );

      }

    }


    if (mounted) {

      setState(() {
        loading = false;
      });

    }

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.symmetric(horizontal: 32),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [


              const Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),


              const SizedBox(height: 40),



              TextField(
                controller: emailController,

                decoration: InputDecoration(
                  hintText: 'Email',

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),

                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
              ),



              const SizedBox(height: 16),



              TextField(
                controller: passwordController,

                obscureText: true,

                decoration: InputDecoration(
                  hintText: 'Password',

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),

                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                ),
              ),



              const SizedBox(height: 22),



              SizedBox(

                width: double.infinity,

                child: ElevatedButton(

                  onPressed: loading ? null : submit,

                  child: loading

                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )

                      : const Text(
                          'Sign in',
                        ),
                ),
              ),



              TextButton(

                onPressed: () {

                  context.go('/register');

                },

                child: const Text(
                  "I don't have an account",
                ),
              ),


            ],

          ),

        ),

      ),

    );

  }
}