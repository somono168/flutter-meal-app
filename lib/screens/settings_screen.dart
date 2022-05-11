import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  final Function saveSettings;
  final Map<String, bool> currentSettings;
  const SettingsScreen({
    Key? key,
    required this.currentSettings,
    required this.saveSettings,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactosFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentSettings['gluten']!;
    _lactosFree = widget.currentSettings['lactos']!;
    _vegan = widget.currentSettings['vegen']!;
    _vegetarian = widget.currentSettings['vegetarian']!;
    super.initState();
  }

  Widget _buildSwitchListTitle(
    String title,
    String subtitle,
    bool currentValue,
    Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final selectedSettings = {
                'gluten': _glutenFree,
                'lactos': _lactosFree,
                'vegen': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveSettings(selectedSettings);
            },
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTitle(
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTitle(
                  'Lactos-free',
                  'Only include lactos-free meals.',
                  _lactosFree,
                  (newValue) {
                    setState(() {
                      _lactosFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTitle(
                  'Vegetarian',
                  'Only include Vegetarian meals.',
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
                _buildSwitchListTitle(
                  'Vegan',
                  'Only include vegan meals.',
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
