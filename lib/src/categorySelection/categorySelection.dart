class Category {
  final int _id;
  final String _name;
  bool _selected = false;
  List<String> _words;
  List<String> _hints;

  Category(
    this._id,
    this._name,
    this._words,
    this._hints,
  );

//==================================    getters   ==================================
  String getName() {
    return this._name;
  }
  int getId() {
    return this._id;
  }
  bool getSelected() {
    return this._selected;
  }

//==================================    setters  ==================================
  void setSelected(bool selected) {
    _selected = selected;
  }
}

List<Category> categories = [
  Category(1, "animals",
    ["Elephant", "Dog", "Cat", "Fly", "Frog", "Ant", "Fish", "Whale", "Lion", "Horse", "Shark", "Tiger", "Monkey", "Lizard", "Snake"],
    ["Big", "Friend", "Friend", "Annoying", "Swamp", "Small", "Water", "Water", "King", "Fast", "blood", "Stripes", "human", "Dragon", "Poison"]),
  Category(2, "Food",
    [],
    []),
  Category(3, "Jobs",
    [],
    []),
  Category(4, "Food",
    [],
    []),
  Category(5, "Jobs",
    [],
    []),
  Category(6, "Food",
    [],
    []),
  Category(7, "Jobs",
    [],
    []),
  Category(8, "Food",
    [],
    []),
  Category(9, "Jobs",
    [],
    []),
];