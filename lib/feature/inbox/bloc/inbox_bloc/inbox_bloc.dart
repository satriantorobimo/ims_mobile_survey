import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/inbox/domain/repo/inbox_repo.dart';

import 'bloc.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  InboxState get initialState => InboxInitial();
  InboxRepo inboxRepo = InboxRepo();
  InboxBloc({required this.inboxRepo}) : super(InboxInitial()) {
    on<InboxEvent>((event, emit) async {
      if (event is InboxAttempt) {
        try {
          emit(InboxLoading());
          final inboxResponseModel = await inboxRepo.attemptGetInbox();
          if (inboxResponseModel!.result == 1) {
            emit(InboxLoaded(inboxResponseModel: inboxResponseModel));
          } else if (inboxResponseModel.result == 0) {
            emit(InboxError(inboxResponseModel.message));
          } else {
            emit(const InboxException('error'));
          }
        } catch (e) {
          emit(InboxException(e.toString()));
        }
      }
    });
  }
}
