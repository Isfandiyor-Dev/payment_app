import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:payment_app/data/models/transfer_model.dart';
import 'package:payment_app/data/repositories/card_repository.dart';
import 'package:payment_app/data/models/card_model.dart';

class TransferRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CardRepository cardRepository;

  TransferRepository({required this.cardRepository});

  Future<void> createTransfer(TransferModel transfer) async {
    await _firestore.collection('transfers').add(transfer.toMap());

    // Update sender's card balance
    CardModel senderCard =
        await cardRepository.getCardById(transfer.senderCardId);
    num newSenderBalance = senderCard.balance - transfer.amount;
    await cardRepository.updateCardBalance(senderCard.id, newSenderBalance);

    // Update receiver's card balance
    CardModel receiverCard =
        await cardRepository.getCardById(transfer.receiverCardId);
    num newReceiverBalance = receiverCard.balance + transfer.amount;
    await cardRepository.updateCardBalance(receiverCard.id, newReceiverBalance);
  }

  Future<List<TransferModel>> getTransfers(String userId) async {
    final querySnapshot = await _firestore
        .collection('transfers')
        .where('senderId', isEqualTo: userId)
        .get();

    return querySnapshot.docs
        .map((doc) => TransferModel.fromMap(doc.data()))
        .toList();
  }
}
