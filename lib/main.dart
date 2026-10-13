import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'config/app_config.dart';

import 'providers/auth_provider.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/notes_screen.dart';


void main() {
  AppConfig.validate();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const NotesApp(),
    ),
  );
}



final GoRouter router = GoRouter(

  initialLocation: '/',

  routes: [

    GoRoute(
      path: '/',

      builder: (context, state) {

        final auth = context.watch<AuthProvider>();


        if (auth.loading) {

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );

        }


        if (auth.user == null) {

          return const LoginScreen();

        }


        return const HomeScreen();

      },

    ),



    GoRoute(
      path: '/register',

      builder: (context, state) =>
          const RegisterScreen(),

    ),



    GoRoute(
      path: '/notes',

      builder: (context, state) =>
          const NotesScreen(),

    ),


  ],

);



class NotesApp extends StatelessWidget {

  const NotesApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(

      title: 'Notes App',

      debugShowCheckedModeBanner: false,


      theme: ThemeData(

        brightness: Brightness.light,

        colorSchemeSeed:
            const Color(0xFF208AEF),

        scaffoldBackgroundColor:
            Colors.white,

      ),


      routerConfig: router,

    );

  }

}