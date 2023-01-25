// Obtain shared preferences.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String currentBookIdKey = 'currentBookIdKey';

final bookPreferenceProvider = Provider<BookPreference>((ref) {
  return BookPreference();
});

class BookPreference {
  late SharedPreferences pref;

  Future<bool> setCurrentBookId(String bookId) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(currentBookIdKey, bookId);
  }

  Future<String?> getCurrentBookId() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(currentBookIdKey);
  }
}
