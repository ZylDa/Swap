import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' hide Center, State;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:swap/components/my_button.dart';
import 'package:swap/components/my_textfield.dart';
import 'package:swap/navigation.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
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

  // 保存用户登录状态
  Future<void> saveUserLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  // sign user in method
  Future<bool> login(String mail, String password) async {
    showLoadingDialog();
    final db = await Db.create(
        'mongodb+srv://swap:swap@swap.2nka9hz.mongodb.net/test?retryWrites=true&w=majority');
    await db.open();

    final users = db.collection('users');
    final user =
        await users.findOne(where.eq('email', mail).eq('password', password));

    await db.close();

    return user != null;
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
                const SizedBox(height: 10),

                // logo
                Image.asset(
                  'assets/images/logopng.png',
                  height: 300,
                  width: 300,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),

                const SizedBox(height: 25),

                // welcome back, you've been missed!
                Text(
                  '歡迎加入Swap><',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'NCCU E-mail',
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

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '忘記密碼?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                    text: '登入',
                    onTap: () async {
                      final loggedIn = await login(
                          emailController.text, passwordController.text);
                      if (loggedIn) {
                        await saveUserLoginStatus(); // 保存用户登录状态
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Navigation()));
                      } else {
                        Navigator.pop(context);
                        showErrorMessage('帳號或密碼錯誤!');
                      }
                    }),

                const SizedBox(height: 50),
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
                      '還沒有帳號嗎?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        '馬上註冊!',
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
