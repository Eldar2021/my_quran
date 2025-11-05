part of 'quran_page_paging_bloc.dart';

@immutable
final class QuranPagePagingState extends PagingStateBase<int, QuranDataEntity> {
  QuranPagePagingState({
    this.cancelToken,
    this.index,
    super.pages,
    super.keys,
    super.error,
    super.hasNextPage,
    super.isLoading,
  });

  final BlocCancelToken? cancelToken;
  final int? index;

  @override
  QuranPagePagingState copyWith({
    Defaulted<List<List<QuranDataEntity>>?>? pages = const Omit(),
    Defaulted<List<int>?>? keys = const Omit(),
    Defaulted<Object?>? error = const Omit(),
    Defaulted<bool>? hasNextPage = const Omit(),
    Defaulted<bool>? isLoading = const Omit(),
    Defaulted<BlocCancelToken?> cancelToken = const Omit(),
    Defaulted<int?> index = const Omit(),
  }) {
    return QuranPagePagingState(
      pages: pages is Omit ? this.pages : pages as List<List<QuranDataEntity>>?,
      keys: keys is Omit ? this.keys : keys as List<int>?,
      error: error is Omit ? this.error : error,
      hasNextPage: hasNextPage is Omit ? this.hasNextPage : hasNextPage! as bool,
      isLoading: isLoading is Omit ? this.isLoading : isLoading! as bool,
      cancelToken: cancelToken is Omit ? this.cancelToken : cancelToken as BlocCancelToken?,
      index: index is Omit ? this.index : index as int?,
    );
  }

  @override
  QuranPagePagingState reset() {
    return QuranPagePagingState(
      cancelToken: BlocCancelToken(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is QuranPagePagingState && super == other && cancelToken == other.cancelToken && index == other.index;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, cancelToken, index);
}
