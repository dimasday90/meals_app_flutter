import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildDrawerListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 26,
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData mainTheme = Theme.of(context);
    final navigator = Navigator.of(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 120,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: mainTheme.accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: mainTheme.primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildDrawerListTile('Meals', Icons.restaurant, () {
            navigator.pushNamed('/');
          }),
          buildDrawerListTile('Settings', Icons.settings, () {
            navigator.pushNamed('/settings');
          }),
        ],
      ),
    );
  }
}
