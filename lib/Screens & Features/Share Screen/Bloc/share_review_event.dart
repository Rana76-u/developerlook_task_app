import 'package:equatable/equatable.dart';
import 'dart:io';

abstract class ShareReviewEvent extends Equatable {
  const ShareReviewEvent();

  @override
  List<Object?> get props => [];
}

class UpdateSelectedDate extends ShareReviewEvent {
  final DateTime selectedDate;
  const UpdateSelectedDate(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];
}

class UpdateRating extends ShareReviewEvent {
  final double rating;
  const UpdateRating(this.rating);

  @override
  List<Object?> get props => [rating];
}

class UpdateMessage extends ShareReviewEvent {
  final String message;
  const UpdateMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdatePickedImagesList extends ShareReviewEvent {
  final List<File> images;
  const UpdatePickedImagesList(this.images);

  @override
  List<Object?> get props => [images];
}

class ToggleRedBorder extends ShareReviewEvent {
  final bool show;
  const ToggleRedBorder(this.show);

  @override
  List<Object?> get props => [show];
}

class UpdateDropdownSelectedItem extends ShareReviewEvent {
  final String dropdownType;
  final Map<String, dynamic> selectedItem;

  const UpdateDropdownSelectedItem({
    required this.dropdownType,
    required this.selectedItem,
  });

  @override
  List<Object?> get props => [dropdownType, selectedItem];
}

class UpdateDropdownSearchQuery extends ShareReviewEvent {
  final String dropdownType;
  final String query;

  const UpdateDropdownSearchQuery({
    required this.dropdownType,
    required this.query,
  });

  @override
  List<Object?> get props => [dropdownType, query];
}

class UpdateDropdownItemsList extends ShareReviewEvent {
  final String dropdownType;
  final List<Map<String, dynamic>> items;

  const UpdateDropdownItemsList({
    required this.dropdownType,
    required this.items,
  });

  @override
  List<Object?> get props => [dropdownType, items];
}

class UpdateIsLoading extends ShareReviewEvent {
  final bool isLoading;

  const UpdateIsLoading(this.isLoading);

  @override
  List<Object?> get props => [isLoading];
}