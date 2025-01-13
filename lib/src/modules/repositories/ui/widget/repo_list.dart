import 'package:dev_search/src/core/colors/colors.dart';
import 'package:dev_search/src/modules/user/ui/user_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoList extends StatelessWidget {
  const RepoList({
    super.key,
    required String selectedSort,
    required this.widget,
    required String selectedDirection,
    required ScrollController scrollController,
    required bool isLoading,
  })  : _selectedSort = selectedSort,
        _selectedDirection = selectedDirection,
        _scrollController = scrollController,
        _isLoading = isLoading;

  final String _selectedSort;
  final UserPage widget;
  final String _selectedDirection;
  final ScrollController _scrollController;
  final bool _isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Ordenar por:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _selectedSort,
                items: const [
                  DropdownMenuItem(value: "updated", child: Text("Atualizado")),
                  DropdownMenuItem(value: "stars", child: Text("Estrelas")),
                  DropdownMenuItem(value: "full_name", child: Text("Nome")),
                ],
                onChanged: (value) {
                  if (value != null) {
                    widget.repoController.setSorting(_selectedSort, _selectedDirection, widget.userController.user.userId!);
                  }
                },
              ),
              DropdownButton<String>(
                value: _selectedDirection,
                items: const [
                  DropdownMenuItem(value: "desc", child: Text("Descendente")),
                  DropdownMenuItem(value: "asc", child: Text("Crescente")),
                ],
                onChanged: (value) {
                  if (value != null) {
                    widget.repoController.setSorting(_selectedSort, _selectedDirection, widget.userController.user.userId!);
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
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
