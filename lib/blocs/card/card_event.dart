import 'package:equatable/equatable.dart';
import 'package:payment_app/data/models/card_model.dart';


abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object?> get props => [];
}

class AddCardEvent extends CardEvent {
  final CardModel card;

  const AddCardEvent(this.card);

  @override
  List<Object?> get props => [card];
}

class GetCardsEvent extends CardEvent {
  @override
  List<Object?> get props => [];
}
