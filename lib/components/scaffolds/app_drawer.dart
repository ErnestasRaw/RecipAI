import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:receptai/components/theme/palette.dart';
import 'package:receptai/components/theme/sizes.dart';
import 'package:receptai/controllers/routing/navigator_utils.dart';
import 'package:receptai/controllers/user_controller.dart';
import 'package:receptai/dev_view.dart';
import 'package:receptai/helpers/xlist.dart';

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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              UserController().loggedInUser?.name ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                            Text(
                              UserController().loggedInUser?.surname ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ].addSpacing(Sizes.spacingSmall),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
