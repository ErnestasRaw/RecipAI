import 'package:flutter/material.dart';
import 'package:receptai/components/theme/palette.dart';
import 'package:receptai/components/theme/sizes.dart';
import 'package:receptai/components/theme/styles.dart';
import 'package:receptai/controllers/user_controller.dart';
import 'package:receptai/helpers/xlist.dart';
import 'package:receptai/models/user.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isLoginPage = true;
  bool rememberMe = true;

  void changePage() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Palette.seedColor,
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
                  decoration: const InputDecoration(
                    labelText: 'El. paštas',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
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
                        onPressed: () {
                          UserController().login(User(
                            userId: 1,
                            name: 'Vardenis',
                            surname: 'Pavardenis',
                            email: 'vardenis.pavardenis@vgtu.lt',
                            username: 'VardenisUser',
                          ));
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
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Vardas Pavardė',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'El. paštas',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Slaptažodis',
                  ),
                  obscureText: true,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Pakartokite slaptažodį',
                  ),
                  obscureText: true,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          UserController().login(User(
                            userId: 1,
                            name: 'Vardenis',
                            surname: 'Pavardenis',
                            email: 'vardenis.pavardenis@vgtu.lt',
                            username: 'VardenisUser',
                          ));
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
