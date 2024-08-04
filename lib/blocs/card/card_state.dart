import 'package:equatable/equatable.dart';
import 'package:payment_app/data/models/card_model.dart';

abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object?> get props => [];
}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  final List<CardModel> cards;

  const CardLoaded({required this.cards});

  @override
  List<Object?> get props => [cards];
}

class CardError extends CardState {
  final String error;

  const CardError({required this.error});

  @override
  List<Object?> get props => [error];
}
