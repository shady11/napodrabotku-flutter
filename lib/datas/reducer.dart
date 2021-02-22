//import 'package:ishapp/datas/app_state.dart';
//import 'package:ishapp/datas/vacancy.dart';
//
//AppState appStateReducers(AppState state, dynamic action) {
//  if (action is AddLikedItemAction) {
//    return addCartItem(state.likedVacancyList, state.vacancyList, action);
//  } else if (action is RemoveLikedItemAction) {
//    return removeLikedItem(state.likedVacancyList, state.vacancyList, action);
//  }
//  return state;
//}
//
//AppState addLikedItem(
//    List<Vacancy> items, List<Vacancy> mainItems, AddCartItemAction action) {
//  return AppState(
//      cartItemList: List.from(items)..add(action.cartItem),
//      mainItemList: List.from(mainItems)
//        ..removeWhere((item) => item.itemName == action.cartItem.itemName));
//}
//
//AppState removeLikedItem(List<CartItem> items, List<CartItem> mainItems,
//    RemoveCartItemAction action) {
//  return AppState(
//      cartItemList: List.from(items)
//        ..removeWhere((item) => item.itemName == action.cartItem.itemName),
//      mainItemList: List.from(mainItems)..add(action.cartItem));
//}
