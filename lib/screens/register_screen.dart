import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';


class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();

}



class _RegisterScreenState extends State<RegisterScreen> {


  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();


  bool loading = false;



  Future<void> submit() async {


    setState(() {

      loading = true;

    });



    try {


      await context.read<AuthProvider>().register(

        nameController.text.trim(),

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

            mainAxisAlignment:
                MainAxisAlignment.center,


            children: [



              const Text(

                'Create account',

                style: TextStyle(

                  fontSize: 28,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 40),




              TextField(

                controller: nameController,

                decoration: InputDecoration(

                  hintText: 'Name',

                  border: OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(6),

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

                controller: emailController,

                decoration: InputDecoration(

                  hintText: 'Email',

                  border: OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(6),

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

                    borderRadius:
                        BorderRadius.circular(6),

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

                  onPressed:
                      loading ? null : submit,


                  child: loading

                      ? const SizedBox(

                          height: 20,

                          width: 20,

                          child:
                              CircularProgressIndicator(),

                        )

                      : const Text(

                          'Create account',

                        ),

                ),

              ),





              TextButton(

                onPressed: () {

                  context.go('/');

                },


                child: const Text(

                  'I already have an account',

                ),

              ),



            ],

          ),

        ),

      ),

    );

  }

}