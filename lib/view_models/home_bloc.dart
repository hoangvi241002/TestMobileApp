import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeLoaded([])); // Start with empty list

  List<String> items = List.generate(10, (index) => 'Item ${index + 1}');

  void refresh() {
    items = List.generate(10, (index) => 'Item ${index + 1}');
    emit(HomeLoaded(items));
  }

  void loadMore() {
    final int currentLength = items.length;
    final List<String> newItems = List.generate(10, (index) => 'Item ${currentLength + index + 1}');
    items.addAll(newItems);
    emit(HomeLoaded(items));
  }
}


abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final List<String> items;

  HomeLoaded(this.items);
}