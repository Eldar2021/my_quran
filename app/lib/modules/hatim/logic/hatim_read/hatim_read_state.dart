part of 'hatim_read_cubit.dart';

class HatimReadState extends Equatable {
  const HatimReadState(this.status, {this.hatim, this.exception});

  final HatimReadModel? hatim;
  final FetchStatus status;
  final Exception? exception;

  @override
  List<Object?> get props => [hatim, status, exception];

  HatimReadState copyWith({FetchStatus? status, HatimReadModel? hatim, Exception? exception}) {
    return HatimReadState(
      status ?? this.status,
      hatim: hatim ?? this.hatim,
      exception: exception ?? this.exception,
    );
  }
}
