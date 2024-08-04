import 'package:equatable/equatable.dart';
import 'package:payment_app/data/models/transfer_model.dart';

abstract class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object> get props => [];
}

class TransferInitial extends TransferState {}

class TransferLoading extends TransferState {}

class TransferSuccess extends TransferState {}

class TransferFailure extends TransferState {
  final String error;

  const TransferFailure(this.error);

  @override
  List<Object> get props => [error];
}

class TransfersLoaded extends TransferState {
  final List<TransferModel> transfers;

  const TransfersLoaded(this.transfers);

  @override
  List<Object> get props => [transfers];
}
