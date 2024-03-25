// ignore_for_file: file_names
class PhrasesModel {
  String description;
  Map json;

  PhrasesModel({
    required this.description,
    required this.json,
  });

  factory PhrasesModel.fromJson(Map<String, dynamic> json) {
    return PhrasesModel(
      description: json['description'],
      json: json,
    );
  }
}
