class CardModel {
  final String id;
  final String userId;
  final String number;
  final num balance;

  CardModel({
    required this.id,
    required this.userId,
    required this.number,
    required this.balance,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'number': number,
      'balance': balance,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      number: map['number'] as String,
      balance: map['balance'] as num,
    );
  }
}
