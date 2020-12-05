import 'package:cloud_functions/cloud_functions.dart';

class TestingFirebaseFunctions {
  final functions = FirebaseFunctions.instance;

  Future<String> callable() async {
    HttpsCallable callable = await functions.httpsCallable('sayHello');
    final result = await callable();
    print(result.data);
  }
}
