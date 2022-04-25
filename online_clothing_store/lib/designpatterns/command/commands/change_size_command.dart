

import '../command.dart';
import '../item.dart';

class ChangeSizeCommand implements Command {
  Item item;
  late String previousSize;

  List sizes = [
    'Small',
    'Medium',
    'Large',
    'Extra Large',

  ];

  ChangeSizeCommand(this.item) {
    previousSize = item.size;
  }

  @override
  void execute() {
    if (item.size == 'Small') {
      item.size = "Medium";
    } else if (item.size == 'Medium') {
      item.size = "Large";
    } else if (item.size == 'Large') {
      item.size = "Extra Large";
    } else if (item.size == 'Extra Large') {
    
      item.size = "Small";
    }
    print(item.size);
  }

  @override
  String getTitle() {
    return 'Change Size';
  }

  @override
  void undo() {
    item.size = previousSize;
  }
}
