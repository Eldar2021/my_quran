part of 'create_hatim_cubit.dart';

@immutable
final class CreateHatimState extends Equatable {
  const CreateHatimState({
    this.status = FetchStatus.initial,
    this.exception,
    this.hatimModel,
    this.searchModel,
    this.selectedUsers = const [],
  });

  final FetchStatus status;
  final Object? exception;
  final MqHatimModel? hatimModel;
  final MqSearchModel? searchModel;
  final List<MqUserIdModel> selectedUsers;

  @override
  List<Object?> get props => [
    status,
    exception,
    hatimModel,
    searchModel,
    selectedUsers,
  ];

  CreateHatimState copyWith({
    FetchStatus? status,
    Object? exception,
    MqHatimModel? hatimModel,
    MqSearchModel? searchModel,
    List<MqUserIdModel>? selectedUsers,
  }) {
    return CreateHatimState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
      hatimModel: hatimModel ?? this.hatimModel,
      searchModel: searchModel ?? this.searchModel,
      selectedUsers: selectedUsers ?? this.selectedUsers,
    );
  }
}
