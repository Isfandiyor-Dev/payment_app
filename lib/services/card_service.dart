import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:payment_app/data/models/card_model.dart';

class CardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCard(CardModel card) async {
    await _firestore.collection('cards').doc(card.id).set(card.toMap());
  }

  Future<List<CardModel>> getCards(String userId) async {
    final querySnapshot = await _firestore
        .collection('cards')
        .where('userId', isEqualTo: userId)
        .get();

    return querySnapshot.docs
        .map((doc) => CardModel.fromMap(doc.data()))
        .toList();
  }

  Future<CardModel> getCardById(String cardId) async {
    final docSnapshot = await _firestore.collection('cards').doc(cardId).get();
    return CardModel.fromMap(docSnapshot.data()!);
  }

  Future<void> updateCardBalance(String cardId, num newBalance) async {
    await _firestore
        .collection('cards')
        .doc(cardId)
        .update({'balance': newBalance});
  }
}
