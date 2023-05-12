import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/domain/weather_data/weather_data.dart';
import 'package:weather/infrastructure/home_screen/home_screen_repo.dart';


part 'home_screen_event.dart';
part 'home_screen_state.dart';
part 'home_screen_bloc.freezed.dart';

@injectable
class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  GetWeatherData getdata;
  HomeScreenBloc(this.getdata) : super(HomeScreenState.initial()) {
    on<Initialize>((event, emit) async {
      if (state.homeData.isNotEmpty) {
        emit(HomeScreenState(
          homeData: state.homeData,
          isLoading: false,
          hasError: false,
        ));
        return;
      }
      emit(HomeScreenState(
        homeData: {},
        isLoading: true,
        hasError: false,
      ));

      final result = await getdata.getWeatherData();
      final _state = result.fold((l) {
        return const HomeScreenState(
          homeData: {},
          isLoading: false,
          hasError: true,
        );
      }, (r) {
        return HomeScreenState(
          homeData: r,
          isLoading: false,
          hasError: true,
        );
      });
    });
  }
}
