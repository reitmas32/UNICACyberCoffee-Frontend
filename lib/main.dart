import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unica_cybercoffee/services/DB/database_static.dart';
import 'package:unica_cybercoffee/ui/providers/editable_ui_provider.dart';
import 'package:unica_cybercoffee/ui/providers/theme_provider.dart';
import 'package:unica_cybercoffee/ui/unica_cybercoffee.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:unica_cybercoffee/services/API/states.dart' as states;

void main() async {
  setPathUrlStrategy();
  await databaseStatic.loadData();
  await onGetStates();
  runApp(const MyApp());
}

onGetStates() async {
  await states.getStates();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();
  EditableUIProvider editableUIProvider = EditableUIProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.setTheme =
        await themeChangeProvider.themePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: editableUIProvider,
      child: ChangeNotifierProvider.value(
        value: themeChangeProvider,
        child: const UnicaCyberCoffe(),
      ),
    );
  }
}
