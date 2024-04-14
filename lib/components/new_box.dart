import '../import_path/import_path.dart';

class NewBox extends StatelessWidget {
  final Widget child;
  const NewBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    //is dark mode
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            //darker shadow on bottom right
            BoxShadow(
              color: isDarkMode?Colors.black:Colors.grey.shade500,
              blurRadius: 15,
              offset: const Offset(4, 4),
            ), //lighter shadow on bottom right
             BoxShadow(
              color:isDarkMode?Colors.grey.shade800:Colors.white,
              blurRadius: 15,
              offset: const Offset(-4, -4),
            ),
          ]),
      child: child,
    );
  }
}
