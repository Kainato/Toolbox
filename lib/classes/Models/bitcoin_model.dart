class BitcoinModel {
  Map<String, dynamic> brl;
  Map<String, dynamic> json;

  BitcoinModel({
    required this.brl,
    required this.json,
  });

  factory BitcoinModel.fromJson(Map<String, dynamic> json) {
    return BitcoinModel(
      brl: json['BRL'],
      json: json,
    );
  }
}
