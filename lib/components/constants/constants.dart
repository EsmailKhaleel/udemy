import 'package:tutorial_app/components/components.dart';
import 'package:tutorial_app/shop_app/login/shopLoginScreen.dart';
import 'package:tutorial_app/shop_app/shared_preferences/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateNoBack(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';
