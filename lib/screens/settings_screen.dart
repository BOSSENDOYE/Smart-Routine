import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkTheme = false;
  String _language = 'FR';

  void _resetAll() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmer la réinitialisation'),
        content: const Text('Voulez-vous vraiment tout réinitialiser ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).resetAll();
              Navigator.pop(ctx);
            },
            child: const Text('Réinitialiser'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Notifications'),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Thème sombre'),
              value: _darkTheme,
              onChanged: (value) {
                setState(() {
                  _darkTheme = value;
                });
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Langue'),
              trailing: DropdownButton<String>(
                value: _language,
                items: const [
                  DropdownMenuItem(value: 'FR', child: Text('Français')),
                  DropdownMenuItem(value: 'EN', child: Text('English')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _language = value;
                    });
                  }
                },
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: _resetAll,
              child: const Text('Tout réinitialiser'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
