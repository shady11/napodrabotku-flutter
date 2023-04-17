import 'package:flutter/services.dart';
import 'package:ishtapp/reducer.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:ishtapp/routes/route_generator.dart';
import 'package:ishtapp/routes/routes.dart';
import 'package:ishtapp/utils/themebloc/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'datas/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';
import 'datas/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initializing the AppMetrica SDK.
  // await AppmetricaSdk().activate(apiKey: '082bf9ad-5946-46d0-9e51-d6588c68bc1f');

  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [
        Locale('ky', 'KG'),
        Locale('ru', 'RU'),
      ],
      path: 'assets/languages',
    ),
  );
}

class MyApp extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware, apiMiddleware, loggingMiddleware],
  );

  @override
  Widget build(BuildContext context) {
//    TO DO make only vertical for IOS
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StoreProvider(
      store: this.store,
      child: BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: _buildWithTheme,
        ),
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      title: 'ISHTAPP',
      initialRoute: Routes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        EasyLocalization.of(context).delegate,
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      debugShowCheckedModeBanner: false,
      theme: state.themeData,
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
