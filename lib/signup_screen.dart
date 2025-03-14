
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_page_quiz/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  String userNameErrorText= "";
  TextEditingController userNameController = TextEditingController();
  bool showUserNameError = false;

  String emailError = "";
  TextEditingController emailNameController = TextEditingController();
  bool showEmailError = false;

  String passwordErrorText = "";
  TextEditingController passwordController = TextEditingController();
  bool showPasswordError = false;
  bool obsecurepassword = true;

  String repeatPasswordErrorText = "";
  TextEditingController repeatPasswordController = TextEditingController();
  bool showRepeatPasswordError = false;

  String phoneErrorText = "";
  TextEditingController phoneController = TextEditingController();
  bool showPhoneError = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextField(
              controller: userNameController,
              decoration: InputDecoration(
                errorText: showUserNameError?userNameErrorText:null,
                label: Text("UserName"),
                prefixIcon: Icon(Icons.person),
                border: UnderlineInputBorder()
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: emailNameController,
              decoration: InputDecoration(
                  errorText: showEmailError?emailError:null,
                  label: Text("Email"),
                  prefixIcon: Icon(Icons.email),
                  border: UnderlineInputBorder()
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: passwordController,
              obscureText: obsecurepassword,
              decoration: InputDecoration(
                  errorText: showPasswordError?passwordErrorText:null,
                  label: Text("Password"),
                  prefixIcon: Icon(Icons.password),
                  border: UnderlineInputBorder(),
                  suffixIcon: IconButton(icon:Icon(Icons.visibility),onPressed: (){
                    obsecurepassword = !obsecurepassword;
                    setState(() {

                    });
                  },)

              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: repeatPasswordController,
              obscureText : true,
              decoration: InputDecoration(
                  errorText: showRepeatPasswordError?repeatPasswordErrorText:null,
                  label: Text("Repeat Password"),
                  prefixIcon: Icon(Icons.password),
                  border: UnderlineInputBorder()
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                  errorText: showPhoneError?phoneErrorText:null,
                  label: Text("UserName"),
                  prefixIcon: Icon(Icons.phone),
                  border: UnderlineInputBorder()
              ),
            ),
            SizedBox(height: 20,),
            TextButton(onPressed: (){
              // username error
              showUserNameError = !checkUserName(username: userNameController.text);

            //   email validation
              showEmailError = !isEmail(email: emailNameController.text);
              if (showEmailError){
                emailError = "Please enter a valid email address";
              }

            //   passwords error
              showPasswordError = !_validatePassword(passwordController.text);

            //   Repeat Password Error
              showRepeatPasswordError = !repeatPasswordCorrect();

            //   phone validation
              showPhoneError = !isMobileNumberValid(phoneController.text);

              setState(() {});

              if (!showUserNameError && !showEmailError &&
                  !showPasswordError && !showRepeatPasswordError &&
                  !showPhoneError
              ){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>Loginscreen())
                );
              }

            }, child: Text("Sign Up"))
          ],
        ),
      ),
    );
  }
  bool checkUserName({required String username}){
    // assume that we have this list of username by fetching external apis
    List<String> usersNames = ["user1","user2","user3"];
    if (usersNames.contains(userNameController.text)){
      userNameErrorText = "This username already exsist";

      return false;
    }
    if (username.isEmpty){
      userNameErrorText = "Please enter a username";
      return false;
    }
    return true;
  }
  bool isEmail({required String email}) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(email);
  }
  // Function to validate the password from geeksforgeeks :D
  bool _validatePassword(String password) {
    // Reset error message
    passwordErrorText = '';

    // Password length greater than 6
    if (password.length <6) {
      passwordErrorText += 'Password must be longer than 6 characters.\n';
    }

    // Contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      passwordErrorText += '• Uppercase letter is missing.\n';
    }

    // Contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      passwordErrorText += '• Lowercase letter is missing.\n';
    }

    // Contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      passwordErrorText += '• Digit is missing.\n';
    }

    // Contains at least one special character
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      passwordErrorText += '• Special character is missing.\n';
    }

    // If there are no error messages, the password is valid
    return passwordErrorText.isEmpty;
  }

  bool repeatPasswordCorrect(){
    if (repeatPasswordController.text != passwordController.text) {
      repeatPasswordErrorText = "passwords does not match";
      return false;
    }
    return true;
  }

  // from https://www.cloudhadoop.com/dart-phone-number-valid-or-net
  bool isMobileNumberValid(String phoneNumber) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    var regExp = new RegExp(regexPattern);

    if (phoneNumber.length == 0) {
      phoneErrorText = "please enter your phone number";
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    phoneErrorText = "invalid phone number";
    return false;
  }
}
