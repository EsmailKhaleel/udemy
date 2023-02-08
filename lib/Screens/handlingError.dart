// ignore_for_file: dead_code, avoid_print

// try {
//   var name = await getName();
//   print(name);
//   throw ('some error!!!!!');
// } catch (error) {
//   print('error is $error ');
// }

Future<String> getName() async {
  return 'Esmail Khaleel';

  getName().then((value) {
    print(value);
    print('Som3a');
  }).catchError((error) {
    print('error is ${error.toString()}');
  });
}
