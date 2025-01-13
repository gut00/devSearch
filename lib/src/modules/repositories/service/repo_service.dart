import 'package:dev_search/src/core/api/github_token.dart';
import 'package:dev_search/src/modules/repositories/model/repositorie_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class RepoService extends ChangeNotifier {
  final Dio dio;
  RepoService(this.dio);

  Future<List<RepoModel>> fetchRepos(
    String userId, {
    int page = 1,
    int perPage = 10,
    String sort = 'updated',
    String direction = 'desc',
  }) async {
    try {
      var response = await dio.get(
        '/users/$userId/repos',
        queryParameters: {
          'per_page': perPage,
          'page': page,
          'sort': sort,
          'direction': direction,
        },
        options: Options(
          headers: {'Authorization': 'token ${GithubToken.token}'},
        ),
      );

      List<RepoModel> repoList = response.data.map<RepoModel>((repo) {
        return RepoModel(
          name: repo['name'] ?? 'Sem nome',
          description: repo['description'] ?? 'Sem descrição',
          language: repo['language'] ?? 'Desconhecido',
          stars: repo['stargazers_count'] ?? 0,
          updatedAt: DateTime.tryParse(repo['updated_at']) ?? DateTime(2000),
          link: repo['html_url'] ?? '',
        );
      }).toList();

      notifyListeners();
      return repoList;
    } catch (e) {
      throw Exception('Erro ao buscar repositórios: $e');
    }
  }
}
