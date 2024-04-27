import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:receptai/api/user_api.dart';
import 'package:receptai/components/theme/palette.dart';
import 'package:receptai/components/theme/sizes.dart';
import 'package:receptai/components/theme/styles.dart';
import 'package:receptai/controllers/user_controller.dart';
import 'package:receptai/helpers/logger_helper.dart';
import 'package:receptai/helpers/xlist.dart';
import 'package:receptai/models/user.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  TextEditingController usernameControllerLogin = TextEditingController();
  TextEditingController passwordControllerLogin = TextEditingController();

  TextEditingController usernameControllerRegister = TextEditingController();
  TextEditingController emailControllerRegister = TextEditingController();
  TextEditingController passwordControllerRegister = TextEditingController();
  TextEditingController passwordRepeatControllerRegister = TextEditingController();

  bool isLoginPage = true;
  bool rememberMe = true;

  bool isFirstAttempt = true;

  void changePage() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Palette.seedColor.withOpacity(0.7),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'ReceptAI',
                        style: Styles.titleAg40Semi(color: Palette.white),
                      ),
                    ),
                  ),
                ),
                _buildLoginField(context),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(Sizes.spacingSmall),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: isLoginPage == true
          ? Column(
              children: [
                Text(
                  'Prisijungimas',
                  style: Styles.titleAg25Semi(color: Palette.black),
                ),
                TextFormField(
                  controller: usernameControllerLogin,
                  decoration: const InputDecoration(
                    labelText: 'Vartotojo vardas',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  controller: passwordControllerLogin,
                  decoration: const InputDecoration(
                    labelText: 'Slaptažodis',
                  ),
                  obscureText: true,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                    ),
                    const Text('Prisiminti mane'),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () async {
                          Response response =
                              await UserApi.login(usernameControllerLogin.text, passwordControllerLogin.text);
                          if (response.statusCode == 200 && response.data['success'] == true) {
                            xlog('Login response: ${response.data}');
                            UserController().login(User.fromJson(response.data['data']));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Prisijungimas sėkmingas'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Prisijungimas nesėkmingas'),
                              ),
                            );
                          }
                        },
                        child: const Text('Prisijungti'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: changePage,
                        child: const Text('Registruotis'),
                      ),
                    ),
                  ],
                )
              ].addSpacing(Sizes.spacingSmall),
            )
          : Column(
              children: [
                Text(
                  'Registracija',
                  style: Styles.titleAg25Semi(color: Palette.black),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Vartotojo vardas',
                  ),
                  controller: usernameControllerRegister,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'El. paštas',
                  ),
                  controller: emailControllerRegister,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Slaptažodis',
                  ),
                  controller: passwordControllerRegister,
                  obscureText: true,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Pakartokite slaptažodį',
                  ),
                  controller: passwordRepeatControllerRegister,
                  obscureText: true,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () async {
                          if (passwordControllerRegister.text == passwordRepeatControllerRegister.text) {
                            Response response = await UserApi.register(
                              usernameControllerRegister.text,
                              emailControllerRegister.text,
                              passwordControllerRegister.text,
                            );
                            if (response.statusCode == 200) {
                              if (response.data['success'] == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Registracija sėkminga'),
                                  ),
                                );
                                changePage();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Registracija nesėkminga'),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Registracija nesėkminga'),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Registruotis'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: changePage,
                        child: const Text('Prisijungti'),
                      ),
                    ),
                  ],
                ),
              ].addSpacing(Sizes.spacingSmall),
            ),
    );
  }
}
