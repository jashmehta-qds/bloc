import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:listing_repository/listing_repository.dart';
import 'package:calculator_repository/calculator_repository.dart';
part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc({this.listingRepository, this.calculatorRepository})
      : assert(listingRepository != null),
        assert(calculatorRepository != null),
        super(PageLoading());

  final ListingRepository listingRepository;
  final CalculatorRepository calculatorRepository;
  int currentIndex = 0;

  @override
  Stream<BottomNavigationState> mapEventToState(
      BottomNavigationEvent event) async* {
    if (event is Welcome) {
      add(PageTapped(index: currentIndex));
    }
    if (event is PageTapped) {
      currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: currentIndex);
      yield PageLoading();

      if (currentIndex == 0) {
        var data = await _getFirstPageData();
        yield FirstPageLoaded(text: data);
      }
      if (currentIndex == 1) {
        var data = await _getSecondPageData();
        yield SecondPageLoaded(text: data);
      }
      if (currentIndex == 2) {
        var data = await _getThirdPageData();
        yield ThirdPageLoaded(text: data);
      }
    }
  }

  Future<int> _getFirstPageData() async {
    var data = listingRepository.listing;
    if (data == null) {
      await listingRepository.fetchList();
      data = listingRepository.listing;
    }
    return data;
  }

  Future<int> _getSecondPageData() async {
    var data = calculatorRepository.data;
    if (data == null) {
      await calculatorRepository.fetchList();
      data = calculatorRepository.data;
    }
    return data;
  }

  Future<int> _getThirdPageData() async {
    var data = calculatorRepository.data;
    if (data == null) {
      await calculatorRepository.fetchList();
      data = calculatorRepository.data;
    }
    return data;
  }
}
