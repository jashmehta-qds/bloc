part of 'bottom_navigation_bloc.dart';

class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex});

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';
}

class PageLoading extends BottomNavigationState {
  @override
  String toString() => 'PageLoading';
}

class FirstPageLoaded extends BottomNavigationState {
  FirstPageLoaded({@required this.text});
  final int text;
  @override
  String toString() => 'FirstPageLoaded with text: $text';
}

class SecondPageLoaded extends BottomNavigationState {
  SecondPageLoaded({@required this.text});
  final int text;
  @override
  String toString() => 'SecondPageLoaded with text: $text';
}

class ThirdPageLoaded extends BottomNavigationState {
  ThirdPageLoaded({@required this.text});
  final int text;
  @override
  String toString() => 'ThirdPageLoaded with text: $text';
}
