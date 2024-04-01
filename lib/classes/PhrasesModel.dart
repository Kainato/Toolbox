// ignore_for_file: file_names
class PhrasesModel {
  String author;
  String description;
  String id;
  Map json;

  PhrasesModel({
    required this.author,
    required this.description,
    required this.id,
    required this.json,
  });

  factory PhrasesModel.fromJson(Map<String, dynamic> json) {
    return PhrasesModel(
      author: json['author'],
      description: json['description'],
      id: json['id'],
      json: json,
    );
  }
}
