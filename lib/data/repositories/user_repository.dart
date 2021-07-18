import 'package:test_suplo/data/model/model.dart';
import 'package:test_suplo/data/network/network.dart';

class UserRepository {
 Future<List<User>> getUsers() async {
  try {
    var response = await Network.instance.get(
      url: ApiConstant.BASE_URL + ApiConstant.USERS,
   );
    var data = response.data;
    if (data == null) {
      return null;
    } else {
      List<User> users = (data as List).map((json) => User.fromJson(json)).toList();
      return users;
    }
  } catch (e) {
   print(e.toString());
  }
 }
}