import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/data/repositories/card_repository.dart';
import 'card_event.dart';
import 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository cardRepository;

  CardBloc({required this.cardRepository}) : super(CardInitial()) {
    on<AddCardEvent>(_onAddCard);
    on<GetCardsEvent>(_onGetCards);
  }

  Future<void> _onAddCard(AddCardEvent event, Emitter<CardState> emit) async {
    emit(CardLoading());
    try {
      await cardRepository.addCard(event.card);
      add(GetCardsEvent());
    } catch (e) {
      emit(CardError(error: e.toString()));
    }
  }

  Future<void> _onGetCards(GetCardsEvent event, Emitter<CardState> emit) async {
    emit(CardLoading());
    try {
      final cards = await cardRepository.getCards();
      emit(CardLoaded(cards: cards));
    } catch (e) {
      emit(CardError(error: e.toString()));
    }
  }
}
