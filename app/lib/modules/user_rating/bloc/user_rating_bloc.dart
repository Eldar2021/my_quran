import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_rating_event.dart';
part 'user_rating_state.dart';

class UserRatingBloc extends Bloc<UserRatingEvent, UserRatingState> {
  UserRatingBloc() : super(UserRatingInitial()) {
    on<UserRatingEvent>((event, emit) {});
  }
}
