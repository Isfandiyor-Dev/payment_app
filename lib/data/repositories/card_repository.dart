import 'package:payment_app/data/models/card_model.dart';
import 'package:payment_app/services/card_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardRepository {
  final CardService cardService;

  CardRepository({required this.cardService});

  Future<void> addCard(CardModel card) async {
    await cardService.addCard(card);
  }

  Future<List<CardModel>> getCards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userID');
    return await cardService.getCards(userId!);
  }

  Future<CardModel> getCardById(String cardId) async {
    return await cardService.getCardById(cardId);
  }

  Future<void> updateCardBalance(String cardId, num newBalance) async {
    return await cardService.updateCardBalance(cardId, newBalance);
  }
}
