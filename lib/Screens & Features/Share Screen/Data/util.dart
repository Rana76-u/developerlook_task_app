class ShareScreenUtil {

  bool isListTileView(String dropdownType) {
    if(dropdownType == 'departure' || dropdownType == 'arrival' || dropdownType == 'airline'){
      return true;
    } else if(dropdownType == 'class') {
      return false;
    } else {
      throw Exception('Invalid dropdown type: $dropdownType');
    }
  }

  String getHintText(String dropdownType) {
    switch (dropdownType) {
      case 'departure':
        return 'Departure Airport';
      case 'arrival':
        return 'Arrival Airport';
      case 'airline':
        return 'Airline';
      case 'class':
        return 'Class';
      default:
        throw Exception('Invalid dropdown type: $dropdownType');
    }
  }

}