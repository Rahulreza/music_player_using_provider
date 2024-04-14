
import 'import_path/import_path.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}
