part of 'home_screen_bloc.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState({
    required Map<String,dynamic> homeData, required bool isLoading, required bool hasError,
  }) = _Initial;
  factory HomeScreenState.initial() =>  const HomeScreenState(homeData: {},isLoading: false,hasError: false);
}
