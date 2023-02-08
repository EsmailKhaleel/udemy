import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/network/remote/dioHelper.dart';
import 'package:tutorial_app/network/remote/endPoints.dart';
import 'package:tutorial_app/shop_app/models/login_model.dart';
import 'package:tutorial_app/shop_app/regiser/cubit/states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? RegisterModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    ).then((value) {
      RegisterModel = ShopLoginModel.fromjson(value.data);
      // token=RegisterModel!.data!.token;
      // CacheHelper.saveData(key: 'token',value:token);
      emit(ShopRegisterSuccessState(RegisterModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_sharp;
  bool isPassword = true;

  void changePasswordVissibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_sharp : Icons.visibility_off_sharp;
    emit(ShopRegisterChangePasswordState());
  }
}
