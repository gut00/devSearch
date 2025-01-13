import 'package:dev_search/src/modules/repositories/model/repositorie_model.dart';
import 'package:dev_search/src/modules/repositories/service/repo_service.dart';
import 'package:flutter/material.dart';

class RepoController extends ChangeNotifier {
  final RepoService service;

  List<RepoModel> newRepoList = [];
  List<RepoModel> get repoList => newRepoList;

  bool isLoading = false;
  String error = '';
  int currentPage = 1;
  bool _hasMoreData = true;

  String _sort = 'updated';
  String _direction = 'desc';

  RepoController(this.service);

  Future<void> fetchRepos(
    String userId, {
    int perPage = 10,
    int page = 1,
    bool reset = false,
  }) async {
    if (isLoading || (!_hasMoreData && !reset)) return;
    isLoading = true;
    notifyListeners();
    try {
      if (reset) {
        newRepoList.clear();
        currentPage = 1;
        _hasMoreData = true;
      }
      final newRepos = await service.fetchRepos(
        userId,
        page: page,
        perPage: perPage,
        sort: _sort,
        direction: _direction,
      );
      newRepoList = reset ? newRepos : [...newRepoList, ...newRepos];
      _hasMoreData = newRepos.length >= perPage;
      if (_hasMoreData) currentPage++;
      notifyListeners();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setSorting(String sort, String direction, String userId) async {
    _sort = sort;
    _direction = direction;
    notifyListeners();
    await fetchRepos(userId, perPage: 10, page: 1);
  }

  String timeAgo(DateTime date) {
    final Duration difference = DateTime.now().difference(date);
    if (difference.inSeconds < 60) {
      return 'há poucos segundos';
    } else if (difference.inMinutes < 60) {
      return 'há ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'há ${difference.inHours} h';
    } else if (difference.inDays < 7) {
      return 'há ${difference.inDays} d';
    } else if (difference.inDays < 30) {
      return 'há ${difference.inDays ~/ 7} semanas';
    } else if (difference.inDays < 365) {
      return 'há ${difference.inDays ~/ 30} meses';
    } else {
      return 'há ${difference.inDays ~/ 365} ano${(difference.inDays ~/ 365) > 1 ? 's' : ''}';
    }
  }
}
