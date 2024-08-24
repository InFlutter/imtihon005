
import '../../data/model/forms_status.dart';
import '../../data/model/recep_model/recep_model.dart';

class RecepState {
  final String errorMessage;
  final FormsStatus status;
  final RecepModel recepModel;
  final List<RecepModel> listRecep;

  RecepState({
    required this.errorMessage,
    required this.status,
    required this.recepModel,
    required this.listRecep,
  });

  RecepState copyWith({
    String? errorMessage,
    FormsStatus? status,
    RecepModel? recepModel,
    List<RecepModel>? listRecep,
  }) {
    return RecepState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      recepModel: recepModel?? this.recepModel,
      listRecep: listRecep?? this.listRecep,
    );
  }

  static RecepState initial() {
    return RecepState(
      errorMessage: '',
      status: FormsStatus.pure,
      recepModel: RecepModel.initialValue(),
      listRecep: [],
    );
  }
}
