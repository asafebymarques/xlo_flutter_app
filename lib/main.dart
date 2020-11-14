import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlo_app_flutter/screens/base/base_screen.dart';
import 'package:xlo_app_flutter/stores/page_store.dart';
import 'package:xlo_app_flutter/stores/user_manager_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setupLocators();
  runApp(MyApp());
}

void setupLocators(){
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(UserManagerStore());
}

Future<void> initializeParse() async{
  await Parse().initialize(
    'tqJZTdXakzDJeni9auarfeDvQlMOU6MKOy8Mty5v',
    'https://parseapi.back4app.com/',
    clientKey: 'haykocsLzjxj0D4wuDg3NZOn0Zlyfb2LH2yXwLFh',
    autoSendSessionId: true,
    debug: true,
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.purple,
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
        cursorColor: Colors.orange,
      ),
      home: BaseScreen(),
    );
  }
}
