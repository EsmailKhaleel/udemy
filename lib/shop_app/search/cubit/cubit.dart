import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/components/constants/constants.dart';
import 'package:tutorial_app/network/remote/dioHelper.dart';
import 'package:tutorial_app/network/remote/endPoints.dart';
import 'package:tutorial_app/shop_app/models/search_model.dart';
import 'package:tutorial_app/shop_app/search/cubit/states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
        token!: token,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError(
      (error) {
        print(error.toString());
        emit(SearchErrorState());
      },
    );
  }
}
