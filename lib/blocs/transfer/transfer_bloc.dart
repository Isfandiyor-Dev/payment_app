import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/data/repositories/transfer_repository.dart';
import 'transfer_event.dart';
import 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final TransferRepository transferRepository;

  TransferBloc({required this.transferRepository}) : super(TransferInitial()) {
    on<CreateTransferEvent>(_onCreateTransfer);
    on<GetTransfersEvent>(_onGetTransfers);
  }

  Future<void> _onCreateTransfer(
      CreateTransferEvent event, Emitter<TransferState> emit) async {
    emit(TransferLoading());
    try {
      await transferRepository.createTransfer(event.transfer);
      emit(TransferSuccess());
    } catch (e) {
      emit(TransferFailure(e.toString()));
    }
  }

  Future<void> _onGetTransfers(
      GetTransfersEvent event, Emitter<TransferState> emit) async {
    emit(TransferLoading());
    try {
      final transfers = await transferRepository.getTransfers(event.userId);
      emit(TransfersLoaded(transfers));
    } catch (e) {
      emit(TransferFailure(e.toString()));
    }
  }
}
