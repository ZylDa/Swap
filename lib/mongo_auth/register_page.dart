import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' hide Center, State;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swap/color_constants.dart';

import 'package:swap/components/my_button.dart';
import 'package:swap/components/my_textfield.dart';
import 'package:swap/navigation.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  // 显示加载指示器对话框
  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // sign user up method
  Future<bool> register(
      String mail, String password, String cpassword, String name) async {
    showLoadingDialog();
    //error message to user
    void showErrorMessage(String message) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: kButtonColor,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      );
    }

    final db = await Db.create(
        'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/huatest64?retryWrites=true&w=majority');
    await db.open();

    final users = db.collection('users');
    bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(mail);
    if (isValid == true) {
      if (password == cpassword) {
        try {
          await users.insert({
            'email': mail,
            'password': password,
            //'product_id': [],
            'name': name,
          });
          await db.close();
          saveUserEmail(mail);
          Navigator.of(context, rootNavigator: true).pop();

          return true; // 注册成功，返回 true
        } catch (e) {
          await db.close();
          Navigator.of(context, rootNavigator: true).pop();
          showErrorMessage('Failed to register');
          return false; // 注册失败，返回 false
        }
      } else {
        await db.close();
        Navigator.of(context, rootNavigator: true).pop();
        showErrorMessage('Mismatch password');
        return false; // 密码不匹配，返回 false
      }
    } else {
      await db.close();
      Navigator.of(context, rootNavigator: true).pop();
      showErrorMessage('Wrong email format');
      return false; // 邮箱格式不正确，返回 false
    }
  }

  // 保存用户邮箱
  Future<void> saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mail', email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),

                // logo
                Image.asset(
                  'assets/images/new logo-removebg-preview.png',
                  height: 150,
                  width: 150,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),

                const SizedBox(height: 35),

                // Create an account for free!
                Text(
                  'Create an account for free!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // name textfield
                MyTextField(
                  controller: nameController,
                  hintText: 'User Name',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 10,
                ),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'University E-mail',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                // sign up button
                MyButton(
                    text: 'Sign up',
                    onTap: () async {
                      bool registerResult = await register(
                        emailController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                        nameController.text,
                      );
                      if (registerResult) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Navigation()),
                        );
                      } else {
                        //print('Failed to register');
                      }
                    }),

                const SizedBox(height: 30),
                /*
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 50),
          
                google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.png'),
          
                    SizedBox(width: 25),
          
                    // apple button
                    SquareTile(imagePath: 'lib/images/apple.png')
                  ],
                ),
          
                const SizedBox(height: 50),
                */

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Log in!',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
