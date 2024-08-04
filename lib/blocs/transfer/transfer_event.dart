import 'package:equatable/equatable.dart';
import 'package:payment_app/data/models/transfer_model.dart';

abstract class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object> get props => [];
}

class CreateTransferEvent extends TransferEvent {
  final TransferModel transfer;

  const CreateTransferEvent(this.transfer);

  @override
  List<Object> get props => [transfer];
}

class GetTransfersEvent extends TransferEvent {
  final String userId;

  const GetTransfersEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
