import '../import_path/import_path.dart';

class ThemeProvider extends ChangeNotifier {
  //initially light mode
  ThemeData _themeData = lightMode;

  //get theme
  ThemeData get themeData => _themeData;

//is dark mode
  bool get isDarkMode => _themeData == darkMode;

//set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    //update UI
    notifyListeners();
  }

//toggle Theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
