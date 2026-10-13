import 'package:flutter/material.dart';
import 'package:appwrite/models.dart';

import '../services/auth_service.dart';



class AuthProvider extends ChangeNotifier {


  User? _user;

  bool _loading = true;



  User? get user => _user;

  bool get loading => _loading;



  AuthProvider() {

    checkUser();

  }





  Future<void> checkUser() async {


    _user = await authService.currentUser();


    _loading = false;


    notifyListeners();

  }





  Future<void> login(
    String email,
    String password,
  ) async {


    _user = await authService.signIn(
      email,
      password,
    );


    notifyListeners();


  }





  Future<void> register(
    String name,
    String email,
    String password,
  ) async {


    _user = await authService.signUp(
      name,
      email,
      password,
    );


    notifyListeners();


  }





  Future<void> logout() async {


    await authService.signOut();


    _user = null;


    notifyListeners();


  }


}