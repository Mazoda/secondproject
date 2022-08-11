import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:secproject/data/DbHelper.dart';
import 'package:secproject/providers/Dbprovider.dart';
import 'package:secproject/views/screens/MainScreen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await DbHelper.dbHelper.initDataBase();
  await EasyLocalization.ensureInitialized();
  // await SpHelper.initS();
  ScreenUtil.ensureScreenSize();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('en'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DBProvider>(
      create: (context) {
        return DBProvider();
      },
      child: ScreenUtilInit(
          designSize: const Size(411.4, 891.42),
          minTextAdapt: true,
          builder: (context, child) {
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: MainScreen(),
            );
          }),
    );
  }
}
