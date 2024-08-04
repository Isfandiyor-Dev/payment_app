class TransferModel {
  final String senderId;
  final String receiverId;
  final String senderCardId;
  final String receiverCardId;
  final num amount;

  TransferModel({
    required this.senderId,
    required this.receiverId,
    required this.senderCardId,
    required this.receiverCardId,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'senderCardId': senderCardId,
      'receiverCardId': receiverCardId,
      'amount': amount,
    };
  }

  factory TransferModel.fromMap(Map<String, dynamic> map) {
    return TransferModel(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      senderCardId: map['senderCardId'],
      receiverCardId: map['receiverCardId'],
      amount: map['amount'],
    );
  }
}
