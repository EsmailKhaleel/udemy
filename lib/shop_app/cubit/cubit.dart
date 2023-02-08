// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/components/constants/constants.dart';
import 'package:tutorial_app/network/remote/dioHelper.dart';
import 'package:tutorial_app/network/remote/endPoints.dart';
import 'package:tutorial_app/shop_app/categories/categoriesScreen.dart';
import 'package:tutorial_app/shop_app/cubit/states.dart';
import 'package:tutorial_app/shop_app/favourites/favouritsScreen.dart';
import 'package:tutorial_app/shop_app/models/categories_model.dart';
import 'package:tutorial_app/shop_app/models/change_favourites_model.dart';
import 'package:tutorial_app/shop_app/models/favourites_model.dart';
import 'package:tutorial_app/shop_app/models/home_model.dart';
import 'package:tutorial_app/shop_app/models/login_model.dart';
import 'package:tutorial_app/shop_app/products/productsScreen.dart';
import 'package:tutorial_app/shop_app/settingsScreen/settingsScreen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];
  Map<int?, bool?> favourites = {};

//______________________________________________________________________________
  int currentIndex = 0;
  void changeIndex(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

//______________________________________________________________________________
  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      // printFullText('${homeModel!.status}');
      // printFullText('${homeModel!.data?.banners?[2].id}');
      // printFullText('${homeModel!.data?.products?[0].image}');

      homeModel!.data!.products!.forEach((element) {
        favourites.addAll({element.id: element.inFavorites!});
      });
      // OR for (var element in homeModel!.data!.products!) {
      //   favourites.addAll({element.id!: element.inFavorites!});
      // }

      // print(favourites.toString());

      emit(ShopSuccessgHomeDataState(homeModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

//______________________________________________________________________________
  CategoroiesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoroiesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

//______________________________________________________________________________
  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavState());

    DioHelper.postData(
      url: FAVOURITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      print(value.data);
      emit(ShopSuccessChangeFavState(changeFavouritesModel!));
      if (changeFavouritesModel!.status == false) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavourites();
      }
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      emit(ShopErrorChangeFavState());
      print(error.toString());
    });
  }

//______________________________________________________________________________
  FavouritesModel? favouritesModel;
  Future<void> getFavourites() async {
    emit(ShopLoadingGetFavouritesState());
    DioHelper.getData(
      url: FAVOURITES,
      token: token,
    ).then((value) {
      emit(ShopSuccessGetFavouritesState());
      favouritesModel = FavouritesModel.fromJson(value.data);
      // printFullText(value.data.toString());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavouritesState());
    });
  }

//______________________________________________________________________________
  ShopLoginModel? userModel;

  Future<void> getUserData() async {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      emit(ShopSuccessGetUserDataState());
      userModel = ShopLoginModel.fromjson(value.data);
      printFullText(userModel!.data!.name.toString());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }
  
  Future<void> updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'email':email,
        'name':name,
        'phone':phone,
      },
    ).then((value) {
      emit(ShopSuccessUpdateUserDataState());
      userModel = ShopLoginModel.fromjson(value.data);
      printFullText(userModel!.data!.name.toString());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
