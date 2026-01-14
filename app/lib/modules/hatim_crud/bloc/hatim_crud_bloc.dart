import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mq_hatim_repository/mq_hatim_repository.dart';

part 'hatim_crud_event.dart';
part 'hatim_crud_state.dart';

class HatimCrudBloc extends Bloc<HatimCrudEvent, HatimCrudState> {
  HatimCrudBloc({
    required this.repository,
    this.hatimId,
  }) : super(const HatimCrudInitial()) {
    on<HatimCrudEvent>((event, emit) {});
  }

  final MqHatimRepository repository;
  final String? hatimId;

  bool get isUpdate => hatimId != null;
}
