import 'package:dev_search/src/core/api/github_api.dart';
import 'package:dev_search/src/modules/user/model/user_model.dart';
import 'package:dio/dio.dart';

class UserService {
  final Dio dio;
  UserService(this.dio);

  Future<UserModel> fetchUsers(String userId) async {
    try {
      final response = await dio.get(
        '/users/$userId',
        options: Options(
          headers: {'Authorization': 'token ${GithubToken.token}'},
        ),
      );
      final data = response.data;
      return UserModel(
        username: data['name'],
        userId: data['login'],
        email: data['email'],
        photoUrl: data['avatar_url'],
        bio: data['bio'],
        location: data['location'],
        website: data['blog'],
        followers: data['followers'],
        following: data['following'],
        socialMedia: data['twitter_username'],
        enterprise: data['company'],
      );
    } catch (e) {
      throw Exception('Não há usuários com esse nome');
    }
  }
}
