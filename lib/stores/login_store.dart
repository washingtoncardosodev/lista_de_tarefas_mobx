
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../screens/list_screen.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  @observable
  String email = "";

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = "";

  @action
  void setPassword(String value) => password = value;

  @observable
  bool passwordVisible = false;

  @action
  void showPassword() => passwordVisible = !passwordVisible;

  @observable
  bool loading = false;  

  @observable
  bool loggedIn = false;

  @computed
  bool get isEmailValid => RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
    .hasMatch(email);

  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  Function get loginPresses => (isEmailValid && isPasswordValid && !loading) ? login : null;
  
  @action
  Future<void> login() async {
    loading = true;
    await Future.delayed(Duration(seconds: 5));
    
    loading = false;
    loggedIn = true;

    email = "";
    password = "";
  }

  @action
  void logout(){
    loggedIn = false;
  }



}