import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_rating_main_state.dart';

class UserRatingMainCubit extends Cubit<UserRatingMainState> {
  UserRatingMainCubit() : super(UserRatingMainInitial());
}
