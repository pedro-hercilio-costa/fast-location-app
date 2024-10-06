import 'package:fast_location/src/modules/history/page/history_page.dart';
import 'package:fast_location/src/modules/home/page/home_page.dart';
import 'package:fast_location/src/modules/initial/page/initial_page.dart';
import 'package:fast_location/src/routes/app_router.dart';
import 'package:fast_location/src/shared/storage/hive_config.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveConfig.initHiveDatabase();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Location',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const InitialPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRouter.home: (context) => const HomePage(),
        AppRouter.history: (context) => const HistoryPage()
      },
    );
  }
}
