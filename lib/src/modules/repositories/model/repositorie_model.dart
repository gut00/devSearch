class RepoModel {
  final String name;
  final String description;
  final String language;
  final int stars;
  final DateTime updatedAt;
  final String link;

  RepoModel({
    required this.name,
    required this.description,
    required this.language,
    required this.stars,
    required this.updatedAt,
    this.link = '',
  });

  factory RepoModel.empty() {
    return RepoModel(
      name: '',
      description: '',
      language: '',
      stars: 0,
      updatedAt: DateTime.now(),
    );
  }
}
