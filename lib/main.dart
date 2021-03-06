import "package:flutter/material.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import "package:gitme_reborn/routes.dart";
import "package:gitme_reborn/pages/home.dart";
import "package:gitme_reborn/pages/login.dart";
import 'package:gitme_reborn/pages/about/about.dart';
import 'package:gitme_reborn/pages/profile/profile.dart';
import 'package:gitme_reborn/pages/setting/setting.dart';
import 'package:gitme_reborn/pages/setting/setting_language.dart';
import 'package:gitme_reborn/pages/trending/trending.dart';
import 'package:gitme_reborn/stores/account.dart';
import 'package:gitme_reborn/stores/setting.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(builder: (BuildContext context) => AccountModel()),
      ChangeNotifierProvider(builder: (BuildContext context) => SettingModel())
    ],
    child: GitmeRebornApp(),
  ));
}

class GitmeRebornApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var setting = Provider.of<SettingModel>(context);

    return MaterialApp(
      title: "Gitme Reborn",
      theme: setting.theme,
      routes: {
        GitmeRebornRoutes.login: (context) => LoginPage(),
        GitmeRebornRoutes.home: (context) => MainPage(),
        GitmeRebornRoutes.profile: (context) => ProfilePage(),
        GitmeRebornRoutes.trending: (context) => TrendingPage(),
        GitmeRebornRoutes.setting: (context) => SettingPage(),
        GitmeRebornRoutes.settingLanguage: (context) => SettingLanguagePage(),
        GitmeRebornRoutes.about: (context) => AboutPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case GitmeRebornRoutes.root:
            return MaterialPageRoute(builder: (context) => LoginPage());
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
      localizationsDelegates: [
        FlutterI18nDelegate(
          useCountryCode: true,
          fallbackFile: "en_US",
          path: "assets/i18n",
          forcedLocale: Locale("en", "US"),
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
