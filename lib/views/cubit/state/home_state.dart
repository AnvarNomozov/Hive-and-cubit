part of '../cubit/home_cubit.dart';

@immutable
abstract class HomeState {
  HomeState();
}

class HomeInitialState extends HomeState {
  HomeInitialState();
}

class HomeLoadingState extends HomeState {
  HomeLoadingState();
}

class HomeComplateState extends HomeState {
  List<CurrencyModel>? users = [];
  HomeComplateState(this.users);
}

class HomeErrorState extends HomeState {
  String error;
  HomeErrorState(this.error);
}
