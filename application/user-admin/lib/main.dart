import 'package:medicare/admin_boobud/uttils/PreferencesHelper.dart';
import 'package:medicare/helpers/localizations/app_localization_delegate.dart';
import 'package:medicare/helpers/localizations/language.dart';
import 'package:medicare/helpers/services/navigation_service.dart';
import 'package:medicare/helpers/storage/local_storage.dart';
import 'package:medicare/helpers/theme/app_notifire.dart';
import 'package:medicare/helpers/theme/app_style.dart';
import 'package:medicare/helpers/theme/theme_customizer.dart';
import 'package:medicare/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:medicare/views/ui/error_pages/error_404_screen.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await LocalStorage.init();
  await PreferencesHelper.initialize();
  AppStyle.init();
  await ThemeCustomizer.init();

  runApp(ChangeNotifierProvider<AppNotifier>(
    create: (context) => AppNotifier(),
    child: ToastificationWrapper(child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (_, notifier, ___) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeCustomizer.instance.theme,
          navigatorKey: NavigationService.navigatorKey,
          initialRoute: "/dashboard",
          unknownRoute: GetPage(name: '/error/404', page: () => Error404Screen()), // Handle unknown routes
          getPages: getPageRoute(),
          builder: (context, child) {
            NavigationService.registerContext(context);
            return Directionality(
                textDirection: AppTheme.textDirection,
                child: child ?? Container());
          },
          localizationsDelegates: [
            AppLocalizationsDelegate(context),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: Language.getLocales(),
        );
      },
    );
  }
}
