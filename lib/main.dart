

import 'import_path/import_path.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlayListProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}
