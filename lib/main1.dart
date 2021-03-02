

//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_redux/flutter_redux.dart';
//import 'package:ishapp/datas/vacancy.dart';
//import 'package:ishapp/datas/vacancy_screen.dart';
//import 'package:ishapp/shopping_cart_app.dart';
//import 'package:redux_dev_tools/redux_dev_tools.dart';
//import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
//import 'package:redux_thunk/redux_thunk.dart';
//import 'package:redux_api_middleware/redux_api_middleware.dart';
//import 'package:redux/redux.dart';
//
//import 'package:ishapp/reducer.dart';
//
//import 'datas/app_state.dart';
//import 'datas/logger.dart';
//import 'datas/routes.dart';
//import 'datas/vacancy_details_screen.dart';
//
//
///*void main() {
//  var list =Vacancy.getListOfVacancies();
//  final store = new DevToolsStore<List<Vacancy>>(cartItemsReducer,
//      initialState: list!=null?list:new List());
//
////  final store = new Store<List<String>>(addItemReducer,
////      initialState: new List());
//
//  runApp(new FlutterReduxApp(store));
//}
//
//class FlutterReduxApp extends StatelessWidget {
//  final DevToolsStore<List<Vacancy>> store;
//
//  FlutterReduxApp(this.store);
//
//  @override
//  Widget build(BuildContext context) {
//    return new StoreProvider<List<Vacancy>>(
//      store: store,
//      child: new ShoppingCartApp(store),
//    );
//  }
//}*/
//
//void main() => runApp(App());
//
//class App extends StatelessWidget {
//  final store = Store<AppState>(
//    appReducer,
//    initialState: AppState.initial(),
//    middleware: [thunkMiddleware, apiMiddleware, loggingMiddleware],
//  );
//
//  @override
//  Widget build(BuildContext context) {
//    return StoreProvider(
//      store: this.store,
//      child: MaterialApp(
//        title: "Flutter with redux",
//        theme: ThemeData(
//          primarySwatch: Colors.blue,
//        ),
//        routes: {
//          AppRoutes.users: (context) => VacanciesScreen(),
//          AppRoutes.userDetails: (context) => VacancyDetailsScreen(),
//        },
//      ),
//    );
//  }
//}
