part of 'hatim_crud_bloc.dart';

sealed class HatimCrudEvent extends Equatable {
  const HatimCrudEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class GetHatimDataByIdEvent extends HatimCrudEvent {
  const GetHatimDataByIdEvent(this.id);

  final String id;
}

@immutable
final class CreateHatimEvent extends HatimCrudEvent {
  const CreateHatimEvent(this.param);

  final MqHatimCreateModel param;
}

@immutable
final class UpdateHatimByIdEvent extends HatimCrudEvent {
  const UpdateHatimByIdEvent(this.param);

  final MqHatimUpdateModel param;
}

@immutable
final class DeleteHatimByIdEvent extends HatimCrudEvent {
  const DeleteHatimByIdEvent(this.id);

  final String id;
}
