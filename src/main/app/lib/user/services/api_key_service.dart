import 'dart:convert';

import 'package:app/base_service.dart';
import 'package:app/user/models/api_key.dart';
import 'package:http/http.dart' as http;

class ApiKeyService extends BaseService {
  @override
  final String url;

  const ApiKeyService(this.url);

  Future<List<ApiKey>> getApiKeys() async {
    var uri = await formatUrl('/api/api-keys');

    var response = await http.get(uri, headers: await headers);
    processResponse(response);

    Iterable i = jsonDecode(response.body);

    return i.map((e) => ApiKey.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<CreatedApiKey> createApiKey({required String name, int? expiresAt}) async {
    var uri = await formatUrl('/api/api-keys');

    var response = await http.put(
      uri,
      headers: await headers,
      body: jsonEncode({'name': name, 'expiresAt': expiresAt}),
    );
    processResponse(response);

    return CreatedApiKey.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteApiKey(String id) async {
    var uri = await formatUrl('/api/api-keys/$id');

    var response = await http.delete(uri, headers: await headers);
    processResponse(response);
  }
}
