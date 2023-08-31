import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/inbox/data/inbox_response_model.dart';

abstract class InboxState extends Equatable {
  const InboxState();

  @override
  List<Object> get props => [];
}

class InboxInitial extends InboxState {}

class InboxLoading extends InboxState {}

class InboxLoaded extends InboxState {
  const InboxLoaded({required this.inboxResponseModel});
  final InboxResponseModel inboxResponseModel;

  @override
  List<Object> get props => [inboxResponseModel];
}

class InboxError extends InboxState {
  const InboxError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class InboxException extends InboxState {
  const InboxException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
