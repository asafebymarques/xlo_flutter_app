import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlo_app_flutter/models/user.dart';
import 'package:xlo_app_flutter/repositories/parse_errors.dart';
import 'package:xlo_app_flutter/repositories/table_keys.dart';

class UserRepository{

  Future<User> signUp(User user) async{

    final parseUser = ParseUser(
      user.email,
      user.password,
      user.email
    );

    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserPhone, user.phone);
    parseUser.set(keyUserType, user.type.index);

    final response = await parseUser.signUp();
    
    if(response.success){
      return mapParseToUser(response.result);
    }else{
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> loginWithEmail(String email, String password) async{

    final parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();

    if(response.success){
      return mapParseToUser(response.result);
    } else{
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> currentUser() async{

    ParseUser parseUser = await ParseUser.currentUser();

    if(parseUser != null){

      final response = await ParseUser
          .getCurrentUserFromServer(parseUser.sessionToken);

      if(response.success){
        return mapParseToUser(response.result);
      } else {
        await parseUser.logout();
      }
    }
    return null;
  }

  User mapParseToUser(ParseUser parkUser){
    return User(
      id: parkUser.objectId,
      name: parkUser.get(keyUserName),
      email: parkUser.get(keyUserEmail),
      phone: parkUser.get(keyUserPhone),
      type: UserType.values[parkUser.get(keyUserType)],
      createdAt: parkUser.get(keyUserCreatedAt),
    );
  }
}