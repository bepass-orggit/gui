import 'dart:io';

import 'package:defacto/enums/app_pages.dart';
import 'package:defacto/states/global/global_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_nav_bar.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  Widget DesktopFooter() {
    return Container();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Platform.isWindows || Platform.isLinux
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context)
                      .primaryColor, // Customize the header color
            ),
            child: Platform.isWindows || Platform.isLinux
                ? BottomNavBar()
                : Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Bepass",
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    )),
          ),
          buildDrawerItem(context, ref, AppPage.configuration,
              Icons.sticky_note_2, 'Configuration'),
          buildDrawerItem(context, ref, AppPage.routingAndRules,
              Icons.turn_right_outlined, 'Routing and rules'),
          buildDrawerItem(
              context, ref, AppPage.settings, Icons.settings, 'Settings'),
          buildDrawerItem(context, ref, AppPage.logs, Icons.bug_report, 'Logs'),
          buildDrawerItem(
              context, ref, AppPage.about, Icons.info_rounded, 'About'),
          if (Platform.isWindows) DesktopFooter()
        ],
      ),
    );
  }

  ListTile buildDrawerItem(BuildContext context, WidgetRef ref, AppPage page,
      IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        ref.read(globalStateProvider.notifier).setActivePage(page);
        // Check if the page is already in the navigation stack
        // final isAlreadyInStack =
        //     ModalRoute.of(context)?.settings is RouteSettings &&
        //         (ModalRoute.of(context)!.settings).name == page.name;
        //
        // // Only push a new route if it's not already in the stack
        // if (!isAlreadyInStack) {
        //   Navigator.pushReplacementNamed(context, page.name);
        // } else {
        //   Navigator.pop(context); // Close the drawer
        // }
      },
    );
  }
}
