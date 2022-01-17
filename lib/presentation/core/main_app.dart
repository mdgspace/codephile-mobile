import 'package:flutter/material.dart';

class Codephile extends StatelessWidget {
  const Codephile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }

  static Future<Widget> run() async {
    // TODO(BURG3R5): Initialize services.
    // TODO(BURG3R5): Wrap `Codephile` widget with `RepositoryProvider`s.
    return const Codephile();
  }
}
