import 'dart:convert';

import 'package:app/base_service.dart';
import 'package:app/identity/states/identity.dart';
import 'package:app/main.dart';
import 'package:http/http.dart' as http;

import 'package:app/user/models/user.dart';

class UserService extends BaseService {
  @override
  final String url;

  UserService(this.url);

  Future<User> getUser() async {
    var uri = await formatUrl('/api/users');

    var response = await http.get(uri, headers: await headers);
    processResponse(response);

    Map<String, dynamic> json = jsonDecode(response.body);

    return User.fromJson(json);
  }

  Future<void> updateUser(User user) async {
    var uri = await formatUrl('/api/users');

    var response = await http.post(uri, body: jsonEncode(user), headers: await headers);
    processResponse(response);

    // changing the password logs out every session, the server gives us a new token to stay logged in
    final newToken = response.headers['x-new-token'];
    if (newToken != null && newToken.isNotEmpty) {
      await getIt.get<IdentityCubit>().setToken(newToken);
    }
  }

  /// Links the SSO account of the given OIDC access token to the current user
  Future<User> linkOidc(String accessToken) async {
    var uri = await formatUrl('/api/users/oidc');

    var response = await http.put(uri, body: accessToken, headers: await headers);
    processResponse(response);

    return User.fromJson(jsonDecode(response.body));
  }

  Future<User> unlinkOidc() async {
    var uri = await formatUrl('/api/users/oidc');

    var response = await http.delete(uri, headers: await headers);
    processResponse(response);

    return User.fromJson(jsonDecode(response.body));
  }
}
