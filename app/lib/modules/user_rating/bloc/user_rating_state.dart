part of 'user_rating_bloc.dart';

@immutable
final class UserRatingState extends PagingStateBase<int, RatingParticipantModel> {
  UserRatingState({
    this.cancelToken,
    this.index,
    this.ownerData,
    super.pages,
    super.keys,
    super.error,
    super.hasNextPage,
    super.isLoading,
  });

  final BlocCancelToken? cancelToken;
  final int? index;
  final RatingOwnerModel? ownerData;

  @override
  UserRatingState copyWith({
    Defaulted<RatingOwnerModel?>? ownerData = const Omit(),
    Defaulted<List<List<RatingParticipantModel>>?>? pages = const Omit(),
    Defaulted<List<int>?>? keys = const Omit(),
    Defaulted<Object?>? error = const Omit(),
    Defaulted<bool>? hasNextPage = const Omit(),
    Defaulted<bool>? isLoading = const Omit(),
    Defaulted<BlocCancelToken?> cancelToken = const Omit(),
    Defaulted<int?> index = const Omit(),
  }) {
    return UserRatingState(
      ownerData: ownerData is Omit ? this.ownerData : ownerData as RatingOwnerModel?,
      pages: pages is Omit ? this.pages : pages as List<List<RatingParticipantModel>>?,
      keys: keys is Omit ? this.keys : keys as List<int>?,
      error: error is Omit ? this.error : error,
      hasNextPage: hasNextPage is Omit ? this.hasNextPage : hasNextPage! as bool,
      isLoading: isLoading is Omit ? this.isLoading : isLoading! as bool,
      cancelToken: cancelToken is Omit ? this.cancelToken : cancelToken as BlocCancelToken?,
      index: index is Omit ? this.index : index as int?,
    );
  }

  @override
  UserRatingState reset() {
    return UserRatingState(
      cancelToken: BlocCancelToken(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserRatingState &&
        super == other &&
        cancelToken == other.cancelToken &&
        index == other.index &&
        ownerData?.ratingNumber == other.ownerData?.ratingNumber &&
        ownerData?.readedPagesCount == other.ownerData?.readedPagesCount;
  }

  @override
  int get hashCode => Object.hash(
    super.hashCode,
    cancelToken,
    index,
    ownerData?.ratingNumber,
    ownerData?.readedPagesCount,
  );

  int get nextIntPageKey {
    if (pages?.isEmpty ?? true) return 0;
    return (keys?.lastOrNull ?? 0) + 1;
  }
}
