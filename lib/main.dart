import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flower_recognizer/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app/pages/landing_page.dart';
import 'package:logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(
      EasyLocalization(
          supportedLocales: [Locale('it'), Locale('en')],
          path: 'assets/translations', // <-- change the path of the translation files
          fallbackLocale: Locale('en'),
          child: AppProd()
      )
  );
}

class AppProd extends StatefulWidget {

  @override
  _AppProdState createState() => _AppProdState();
}

class _AppProdState extends State<AppProd> {

  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async{
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      if (record.error != null) {
        print('${record.time} | ${record.level.name} | ${record.loggerName}: ${record.message} - ${record.error} ');
      } else {
        print('${record.time} | ${record.level.name} | ${record.loggerName}: ${record.message}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Center(
            child:
            Text('Could not connect to Firebase. Try again later.'),
          ),
        ),
      );
    }

    if (!_initialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Provider <AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flower recognizer',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LandingPage(),
      ),
    );

  }
}
