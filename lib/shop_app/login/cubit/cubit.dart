import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/network/remote/dioHelper.dart';
import 'package:tutorial_app/network/remote/endPoints.dart';
import 'package:tutorial_app/shop_app/login/cubit/states.dart';
import 'package:tutorial_app/shop_app/models/login_model.dart';
import 'package:tutorial_app/shop_app/shared_preferences/cache_helper.dart';

import '../../../components/constants/constants.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromjson(value.data);
      token=loginModel!.data!.token;
      CacheHelper.saveData(key: 'token',value:token);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_sharp;
  bool isPassword = true;

  void changePasswordVissibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_sharp : Icons.visibility_off_sharp;
    emit(ShopChangePasswordState());
  }
}
