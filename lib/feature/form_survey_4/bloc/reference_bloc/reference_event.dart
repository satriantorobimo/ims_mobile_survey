import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_4/data/hubungan_model.dart';

abstract class ReferenceEvent extends Equatable {
  const ReferenceEvent();
}

class InsertReferenceAttempt extends ReferenceEvent {
  const InsertReferenceAttempt(this.hubunganModel);
  final HubunganModel hubunganModel;

  @override
  List<Object> get props => [hubunganModel];
}
