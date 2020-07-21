import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class SettingsCart extends StatefulWidget {
  static const routeName = '/settings';
  final Map<String, bool> filters;
  final Function filtersHandler;

  SettingsCart({this.filters, this.filtersHandler});

  @override
  _SettingsCartState createState() => _SettingsCartState();
}

class _SettingsCartState extends State<SettingsCart> {
  Map<String, bool> _filters = {
    'glutten-free': false,
    'lactose-free': false,
    'vegan': false,
    'vegetarian': false,
  };

  @override
  void initState() {
    _filters = widget.filters;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      drawer: MainDrawer(
        filters: _filters,
        filterHandler: widget.filtersHandler,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  'Filter',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    _buildSwitchListTile(
                      'Gluten-Free',
                      'Only includes glutten-free meals',
                      _filters['glutten-free'],
                      (bool newValue) {
                        setState(() {
                          _filters['glutten-free'] = newValue;
                        });
                      },
                    ),
                    _buildSwitchListTile(
                      'Lactose-Free',
                      'Only includes lactose-free meals',
                      _filters['lactose-free'],
                      (bool newValue) {
                        setState(() {
                          _filters['lactose-free'] = newValue;
                        });
                      },
                    ),
                    _buildSwitchListTile(
                      'Vegan',
                      'Only includes vegan meals',
                      _filters['vegan'],
                      (bool newValue) {
                        setState(() {
                          _filters['vegan'] = newValue;
                        });
                      },
                    ),
                    _buildSwitchListTile(
                      'Vegetarian',
                      'Only includes vegetarian meals',
                      _filters['vegetarian'],
                      (bool newValue) {
                        setState(() {
                          _filters['vegetarian'] = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
