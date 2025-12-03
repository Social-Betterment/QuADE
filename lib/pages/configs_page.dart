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
      final newConfig = Config(
        endpoint: 'https://fra.cloud.appwrite.io/v1',
        projectId: '691b86fb000e917fcd95',
        devKey:
            'standard_444cccd584807e000c345a33d87e518a268f255e00bfb2f2173ef2ea694cb762ccab33d4012d68bf51e2236440a57ad65e8e9cafa1989cb0e11695d29594b214e01b1a1ef0d85bd72569b55e4a1fdbb777c7f8f069f7f49dd9f2efc4f84482a73237f2365a9fd5cabe07555fa0e8bae3e3790d480f0698b2d2c072ae77f07178',
        plan: Plan.free,
      );
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
        itemCount: _configs.length + 1,
        itemBuilder: (context, index) {
          if (index < _configs.length) {
            return ConfigCard(
              key: ObjectKey(_configs[index]),
              config: _configs[index],
              onSave: (config) => _updateConfig(index, config),
              onLoad: _loadClient,
              onDelete: () => _deleteConfig(index),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 80.0),
              child: Text(
                "Due to geographic, legal, and security settings, API keys might not work across regions. In that case, build your own QuADE from source. The public server is in Frankfurt, Germany.\n\nThe sample API key is READ-ONLY and will not allow you to make any changes to the sample Appwrite instance.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
