import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quade/main.dart';
import 'package:quade/models/config.dart';
import 'package:quade/widgets/config_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class ConfigsPage extends StatefulWidget {
  const ConfigsPage({super.key});

  @override
  State<ConfigsPage> createState() => _ConfigsPageState();
}

class _ConfigsPageState extends State<ConfigsPage> {
  List<Config> _configs = [];
  static const _configsKey = 'configs';
  final Uri _url = Uri.parse('https://github.com/Social-Betterment/QuADE');

  @override
  void initState() {
    super.initState();
    _loadConfigs();
  }

  Future<void> _loadConfigs() async {
    final prefs = await SharedPreferences.getInstance();
    final configsString = prefs.getStringList(_configsKey) ?? [];
    if (configsString.isEmpty) {
      final newConfig = Config(endpoint: '', projectId: '', devKey: '');
      setState(() {
        _configs = [newConfig];
      });
      await _saveConfigs();
    } else {
      setState(() {
        _configs = configsString.map((c) => Config.fromJson(c)).toList();
      });
    }
  }

  Future<void> _saveConfigs() async {
    final prefs = await SharedPreferences.getInstance();
    final configsString = _configs.map((c) => c.toJson()).toList();
    await prefs.setStringList(_configsKey, configsString);
  }

  void _addConfig() {
    setState(() {
      _configs.add(Config(endpoint: '', projectId: '', devKey: ''));
    });
    _saveConfigs();
  }

  void _updateConfig(int index, Config config) {
    setState(() {
      _configs[index] = config;
    });
    _saveConfigs();
  }

  void _deleteConfig(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Configuration'),
        content:
            const Text('Are you sure you want to delete this configuration?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _configs.removeAt(index);
              });
              _saveConfigs();
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _loadClient(Config config) {
    Provider.of<AppwriteNotifier>(context, listen: false).setClient(config);
    context.go('/databases');
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return const Text('QuADE');
            } else {
              return const Text('Quick Appwrite Database Explorer');
            }
          },
        ),
        leading: IconButton(
          icon: const Icon(Icons.key),
          onPressed: () {
            // Already on configs page
          },
        ),
      ),
      body: ListView.builder(
        itemCount: _configs.length,
        itemBuilder: (context, index) {
          return ConfigCard(
            config: _configs[index],
            onSave: (config) => _updateConfig(index, config),
            onLoad: _loadClient,
            onDelete: () => _deleteConfig(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addConfig,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Quick Appwrite Database Editor\n',
                  style: TextStyle(fontSize: 14),
                ),
                TextSpan(
                  text: 'github.com/Social-Betterment/QuADE',
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.none,
                    fontSize: 14,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = _launchUrl,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
