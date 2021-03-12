part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class Welcome extends BottomNavigationEvent {
  @override
  String toString() => 'Welcome';
}

class PageTapped extends BottomNavigationEvent {
  PageTapped({@required this.index});
  final int index;
  @override
  String toString() => 'PageTapped: $index';
}
