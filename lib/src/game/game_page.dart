import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:imposter_party_game/src/ui_elements/custom_app_bar.dart' show CustomAppBar;
import 'package:imposter_party_game/src/ui_elements/custom_text.dart'; 
import 'package:imposter_party_game/src/category_managment/category_object.dart' show CategoriesList;

import 'game_ui.dart';
import 'game_object.dart';
import 'background.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: CustomAppBar(title: "Game page"),
      body: FutureBuilder(
        future: Future.wait([
          context.read<CategoriesList>().allSelectedWords,
          context.read<CategoriesList>().allSelectedHints
        ]),
        builder: (context, AsyncSnapshot<List<List<String>>> snapshot) { // AsyncSnapshot<[wordslist, hintslist]>
          if (snapshot.hasError) {
            return Center(child: Text('Category grid building Error: ${snapshot.error}', style: AppTextStyles.standard,));
          } 
          else if (!snapshot.hasData) {               // On beggining snapshot has no data which returns unnecessary error
            return Center(child: Text('Loading Data!', style: AppTextStyles.standard,));   
          }
          else {
            return ChangeNotifierProvider(
              create: (context) => GameState(wordsList: snapshot.data![0], hintsList: snapshot.data![1]),
              builder: (context, child) {
                return Stack(
                  children: [
            //================================================== PAGE LAYOUT ==================================================
                    Background(vsync: this),
                    AnimatedSwitcher(   // player transition animation
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) => SlideTransition(position: Tween<Offset>(
                        begin: Offset(1.0, 0.0),
                        end: Offset.zero).animate(animation), child: child,
                      ),         
                      child: Center(
                        key: ValueKey(context.watch<GameState>().currentIndex),
                        child: Column (
                          children: [
                            Text(
                              context.read<GameState>().playerList[context.read<GameState>().currentIndex], style: AppTextStyles.standard, textAlign: TextAlign.center,
                            ),
                            TextBox(),
                            NextButton(),
                          ],
                        ),
                      )
                    ),
                  ],
                );
              }
            );
          }
        }
      )
    );
  }
}

// class GamePageLayout extends StatefulWidget {
//   const GamePageLayout({super.key});

//   @override
//   State<GamePageLayout> createState() => _GamePageState();
// }

// class _GamePageState extends State<GamePageLayout> with SingleTickerProviderStateMixin {
//   late final Background background;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
// //================================================== PAGE LAYOUT ==================================================
//         background,
//         AnimatedSwitcher(   // player transition animation
//           duration: const Duration(milliseconds: 400),
//           transitionBuilder: (child, animation) => SlideTransition(position: Tween<Offset>(
//             begin: Offset(1.0, 0.0),
//             end: Offset.zero).animate(animation), child: child,
//           ),         
//           child: Center(
//             key: ValueKey(context.watch<GameState>().currentIndex),
//             child: Column (
//               children: [
//                 Text(
//                   context.read<GameState>().playerList[context.read<GameState>().currentIndex], style: AppTextStyles.standard, textAlign: TextAlign.center,
//                 ),
//                 TextBox(),
//                 NextButton(incrementIndex: () => setState(() => context.read<GameState>().incrementCurrentIndex())),
//               ],
//             ),
//           )
//         ),
//       ],
//     );
//   }

//   @override
//   void initState() {
//     background = Background(backgroundColor: context.read<GameState>().currentPlayerColor, vsync: this);
//     super.initState();
//   }
// }