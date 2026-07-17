import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class SettingsScreen
    extends StatelessWidget {
  const SettingsScreen(
      {super.key});

  @override
  Widget build(
      BuildContext context) {

    final theme =
    context.watch<
        ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title:
        const Text(
          "Settings",
        ),
      ),
      body: ListView(
        children: [

          SwitchListTile(
            title:
            const Text(
              "Dark Mode",
            ),
            subtitle:
            const Text(
              "Enable dark theme",
            ),
            value:
            theme.darkMode,
            onChanged:
                (value) {
              theme
                  .toggleTheme(
                  value);
            },
          ),

          const Divider(),

          const ListTile(
            leading:
            Icon(Icons.info),
            title:
            Text(
              "Version",
            ),
            subtitle:
            Text(
              "1.0.0",
            ),
          ),
        ],
      ),
    );
  }
}