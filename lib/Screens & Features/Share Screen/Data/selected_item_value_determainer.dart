class SelectedItemValueDeterminer {

  String getTitle(String dropdownType, Map<String, dynamic> item){

    if(item.isEmpty) {
      return '';
    }

    return dropdownType == 'departure' || dropdownType == 'arrival'
        ? item['city']
        : dropdownType == 'airline'
        ? item['name']
        : item['name'];
  }

  String getSubtitle(String dropdownType, Map<String, dynamic> item) {

    if(item.isEmpty) {
      return '';
    }

    return dropdownType == 'departure' || dropdownType == 'arrival'
        ? item['airport']
        : item['country'];
  }

  String getTrailing(String dropdownType, Map<String, dynamic> item){

    if(item.isEmpty) {
      return '';
    }

    return item['code'];
  }

}