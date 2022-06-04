import 'package:flutter/material.dart';
import 'package:frazex_task/ui/pages/home.dart';
import 'package:frazex_task/ui/pages/search.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentWidgetIndex = 0;
  List<Widget> pageWidgets = [const HomePage(), const SearchPage()];
  Locale _locale = const Locale('en');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) {
          var appLocale = AppLocalizations.of(context)!;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(title: Text(appLocale.appTitle)),
              drawer: Drawer(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(appLocale.english),
                      onTap: () {
                        setState(() {
                          _locale = const Locale('en');
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(appLocale.azerbaijanian),
                      onTap: () {
                        setState(() {
                          _locale = const Locale('az');
                        });
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(appLocale.russian),
                      onTap: () {
                        setState(() {
                          _locale = const Locale('ru');
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.home), label: appLocale.home),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.search), label: appLocale.search)
                ],
                currentIndex: currentWidgetIndex,
                onTap: (index) {
                  setState(() {
                    currentWidgetIndex = index;
                  });
                },
              ),
              body: IndexedStack(
                index: currentWidgetIndex,
                children: pageWidgets,
              ),
            ),
          );
        }
      },
    );
  }
}
