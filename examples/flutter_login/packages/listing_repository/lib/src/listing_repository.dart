import 'dart:async';

class ListingRepository {
  int _listing;

  Future<void> fetchList() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );
    _listing = 999;
  }

  int get listing => _listing;
}
