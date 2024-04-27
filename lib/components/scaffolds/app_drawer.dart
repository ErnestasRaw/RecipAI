import 'package:flutter/material.dart';
import 'package:receptai/components/theme/palette.dart';
import 'package:receptai/controllers/user_controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: Palette.greenGradient,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_circle_outlined,
                        size: 80,
                        color: Colors.white,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          UserController().loggedInUser?.username ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     pushMaterial(context, (context) => DevView());
          //   },
          //   child: Text('devmode'),
          // ),
          const Expanded(child: SizedBox()),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Atsijungti'),
            onTap: () {
              UserController().logout();
            },
          ),
          // if (kDebugMode)
          //   ElevatedButton(
          //     onPressed: () {
          //       pushMaterial(context, (context) => DevView());
          //     },
          //     child: Text('DevView'),
          //   ),
        ],
      ),
    );
  }
}
