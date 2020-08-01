import 'colors_game_page.dart';
import 'package:flutter/material.dart';

void main()=>runApp(ColorsGame());

class ColorsGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.purple),

      home: ColorsGamePage(),
    );
  }
}
