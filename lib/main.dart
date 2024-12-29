import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/routes/routes_names.dart';
import '/widgets/my_theme.dart';
import 'dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await DependencyInjector.initDB();
  runApp(const SellerApp());
}

class SellerApp extends StatelessWidget {
  const SellerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375.0, 812.0),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (BuildContext context, child) {
        return MultiRepositoryProvider(
          providers: DependencyInjector.repositoryProvider,
          child: MultiBlocProvider(
            providers: DependencyInjector.blocProviders,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteNames.generateRoute,
              initialRoute: RouteNames.animatedSplashScreen,
              theme: MyCustomTheme.theme,
              onUnknownRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  builder: (_) => Scaffold(
                    body: Center(child: Text('No route defined for $settings')),
                  ),
                );
              },
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
