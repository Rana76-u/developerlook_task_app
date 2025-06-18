import 'package:equatable/equatable.dart';
import 'dart:io';

class ShareReviewState extends Equatable {
  final DateTime? selectedDate;
  final String message;
  final double rating;
  final Map<String, Map<String, dynamic>> selectedItems;
  final Map<String, String> searchQueries;
  final Map<String, List<Map<String, dynamic>>> dropdownItems;
  final List<File> pickedImages;
  final bool showRedBorder;
  final bool isLoading;

  const ShareReviewState({
    this.selectedDate,
    this.message = '',
    this.rating = 4,
    this.selectedItems = const {},
    this.searchQueries = const {},
    this.dropdownItems = const {},
    this.pickedImages = const [],
    this.showRedBorder = false,
    this.isLoading = false,
  });

  ShareReviewState copyWith({
    DateTime? selectedDate,
    String? message,
    double? rating,
    Map<String, Map<String, dynamic>>? selectedItems,
    Map<String, String>? searchQueries,
    Map<String, List<Map<String, dynamic>>>? dropdownItems,
    List<File>? pickedImages,
    bool? showRedBorder,
    bool? isLoading,
  }) {
    return ShareReviewState(
      selectedDate: selectedDate ?? this.selectedDate,
      message: message ?? this.message,
      rating: rating ?? this.rating,
      selectedItems: selectedItems ?? this.selectedItems,
      searchQueries: searchQueries ?? this.searchQueries,
      dropdownItems: dropdownItems ?? this.dropdownItems,
      pickedImages: pickedImages ?? this.pickedImages,
      showRedBorder: showRedBorder ?? this.showRedBorder,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    selectedDate,
    message,
    rating,
    selectedItems,
    searchQueries,
    dropdownItems,
    pickedImages,
    showRedBorder,
    isLoading,
  ];
}