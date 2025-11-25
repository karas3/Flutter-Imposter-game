import 'dart:math';

class PreSets {
  final _animalsPreSet = ["Elephant", "Dog", "Cat", "Fly", "Frog", "Ant", "Fish", "Whale", "Lion", "Horse", "Shark", "Tiger", "Monkey", "Lizard", "Snake"];

  String getRandomAnimal() {
    var index = Random().nextInt(_animalsPreSet.length);
    return _animalsPreSet[index];
  }
}