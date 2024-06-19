import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:harcama_takip/servis/base/authServis/auth_servis.dart';
import 'package:harcama_takip/tools/locator.dart';

class AuthViewModel with ChangeNotifier{

  final AuthServis _authServis=AuthServis();

  final TextEditingController _emailControllerlogin = TextEditingController();
  final TextEditingController _passwordControllerlogin = TextEditingController();
  TextEditingController get emailControllerlogin => _emailControllerlogin;
  TextEditingController get passwordControllerlogin => _passwordControllerlogin;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpaswordcontroller = TextEditingController();
  final TextEditingController _fullNamecontroller=TextEditingController();

  TextEditingController get fullNamecontroller => _fullNamecontroller;

  TextEditingController get emailController => _emailController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmpaswordcontroller =>
      _confirmpaswordcontroller;


  void register(BuildContext context)async{
    if(passwordController.text==confirmpaswordcontroller.text){
      await _authServis.signUpWithEmailAndPassword(
          emailController.text, passwordController.text,
          usernameController.text, fullNamecontroller.text);
    }
  }

  void login(BuildContext context)async{
    await _authServis.signInWithEmailAndPassword(emailControllerlogin.text, passwordControllerlogin.text);
  }

  void signOut(BuildContext context)async{
    await _authServis.signOut();
  }

}