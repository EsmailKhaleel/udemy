import 'package:tutorial_app/shop_app/models/change_favourites_model.dart';
import 'package:tutorial_app/shop_app/models/home_model.dart';
import 'package:tutorial_app/shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessgHomeDataState extends ShopStates {
  final HomeModel homeModel;

  ShopSuccessgHomeDataState(this.homeModel);
}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavState extends ShopStates {}

class ShopSuccessChangeFavState extends ShopStates {
  final ChangeFavouritesModel model;

  ShopSuccessChangeFavState(this.model);
}

class ShopErrorChangeFavState extends ShopStates {}

class ShopLoadingGetFavouritesState extends ShopStates {}

class ShopSuccessGetFavouritesState extends ShopStates {}

class ShopErrorGetFavouritesState extends ShopStates {}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {}

class ShopErrorGetUserDataState extends ShopStates {}

class ShopLoadingUpdateUserDataState extends ShopStates {}

class ShopSuccessUpdateUserDataState extends ShopStates {}

class ShopErrorUpdateUserDataState extends ShopStates {}
