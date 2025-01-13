import 'package:dev_search/src/core/colors/colors.dart';
import 'package:dev_search/src/modules/repositories/controller/repo_controller.dart';
import 'package:dev_search/src/modules/user/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPage extends StatefulWidget {
  final UserController userController;
  final RepoController repoController;

  const UserPage({
    super.key,
    required this.userController,
    required this.repoController,
  });

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;

  String _selectedSort = 'updated';
  String _selectedDirection = 'desc';

  @override
  void initState() {
    _loadRepos();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (!_isLoading) {
          _loadMoreRepos();
        }
      }
    });
  }

  void _loadRepos() {
    setState(() {
      _isLoading = true;
      _currentPage = 1;
      widget.repoController.repoList.clear();
      widget.repoController.newRepoList.clear();
    });
    widget.repoController
        .fetchRepos(
      widget.userController.user.userId!,
      perPage: 10,
      page: _currentPage,
    )
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _loadMoreRepos() {
    setState(() {
      _isLoading = true;
    });
    widget.repoController
        .fetchRepos(
      widget.userController.user.userId!,
      perPage: 10,
      page: _currentPage + 1,
    )
        .then((_) {
      setState(() {
        _isLoading = false;
        _currentPage++;
      });
    });
  }

  void _updateSorting(String sort, String direction) {
    setState(() {
      _selectedSort = sort;
      _selectedDirection = direction;
      _currentPage = 1;
      _isLoading = true;
      widget.repoController.newRepoList.clear();
    });
    widget.repoController.setSorting(sort, direction, widget.userController.user.userId!).then((_) {
      _loadRepos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: DefaultColors.purpleBackground,
        title: const Text(
          'Search d_evs',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: DefaultColors.title,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: DefaultColors.purpleBackground,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Image.network(
                            widget.userController.user.photoUrl ?? '',
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.userController.user.username ?? 'Nome do usuário',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: DefaultColors.title,
                              ),
                            ),
                            Text(
                              widget.userController.user.userId ?? 'ID do usuário',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: DefaultColors.text,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Image.asset(
                          'asset/images/follow.png',
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          '  ${widget.userController.user.followers.toString()} Seguidores',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: DefaultColors.text,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Image.asset(
                          'asset/images/heart.png',
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          '  ${widget.userController.user.following.toString()} seguindo',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: DefaultColors.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      constraints: const BoxConstraints(minHeight: 50),
                      child: Text(
                        widget.userController.user.bio ?? 'Não há biografia',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: DefaultColors.text,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        if (widget.userController.user.enterprise != null)
                          _buildInfoRow(
                            'asset/images/enterprise.png',
                            widget.userController.user.enterprise!,
                          ),
                        if (widget.userController.user.location != null)
                          _buildInfoRow(
                            'asset/images/loc.png',
                            widget.userController.user.location!,
                          ),
                        if (widget.userController.user.email != null)
                          _buildInfoRow(
                            'asset/images/email.png',
                            widget.userController.user.email!,
                          ),
                        if (widget.userController.user.website != null && widget.userController.user.website!.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              final url = widget.userController.user.website ?? '';
                              final Uri parsedUrl = Uri.parse(url);
                              launchUrl(parsedUrl);
                            },
                            child: _buildInfoRow(
                              'asset/images/link.png',
                              widget.userController.user.website!,
                            ),
                          ),
                        if (widget.userController.user.socialMedia != null)
                          _buildInfoRow(
                            'asset/images/social.png',
                            widget.userController.user.socialMedia!,
                          ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Ordenar por:",
                      style: styleText(),
                    ),
                  ),
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    underline: const SizedBox.shrink(),
                    value: _selectedSort,
                    items: [
                      DropdownMenuItem(
                          value: "updated",
                          child: Text(
                            "Atualizado",
                            style: styleText(),
                          )),
                      DropdownMenuItem(
                          value: "stars",
                          child: Text(
                            "Estrelas",
                            style: styleText(),
                          )),
                      DropdownMenuItem(
                          value: "full_name",
                          child: Text(
                            "Nome",
                            style: styleText(),
                          )),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        _updateSorting(value, _selectedDirection);
                      }
                    },
                  ),
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    underline: const SizedBox.shrink(),
                    value: _selectedDirection,
                    items: [
                      DropdownMenuItem(
                          value: "asc",
                          child: Text(
                            "Descendente",
                            style: styleText(),
                          )),
                      DropdownMenuItem(
                          value: "desc",
                          child: Text(
                            "Crescente",
                            style: styleText(),
                          )),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        _updateSorting(_selectedSort, value);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.repoController.newRepoList.length + 1,
                itemBuilder: (context, index) {
                  if (index == widget.repoController.newRepoList.length) {
                    if (_isLoading) {
                      return const Center(
                          child: Column(
                        children: [
                          SizedBox(height: 20),
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                        ],
                      ));
                    } else {
                      return const SizedBox.shrink();
                    }
                  }
                  final repo = widget.repoController.newRepoList[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final url = repo.link;
                            if (url.isNotEmpty) {
                              final Uri parsedUrl = Uri.parse(url);
                              launchUrl(parsedUrl);
                            }
                          },
                          child: Text(
                            repo.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: DefaultColors.title,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            repo.description,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: DefaultColors.text,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_border_rounded,
                              color: DefaultColors.text,
                              size: 25,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              repo.stars.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: DefaultColors.text,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              ' • ',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                color: DefaultColors.text,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Atualizado ${widget.repoController.timeAgo(repo.updatedAt)}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        if (index != widget.repoController.newRepoList.length - 1)
                          Divider(
                            color: DefaultColors.text.withOpacity(0.3),
                            thickness: 1,
                            height: 30,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle styleText() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: DefaultColors.text,
    );
  }

  Widget _buildInfoRow(String iconPath, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          iconPath,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: DefaultColors.text,
          ),
        ),
      ],
    );
  }
}
