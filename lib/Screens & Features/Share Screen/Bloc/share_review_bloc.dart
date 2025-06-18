import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_event.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShareReviewBloc extends Bloc<ShareReviewEvent, ShareReviewState> {
  ShareReviewBloc() : super(const ShareReviewState()) {
    on<UpdateSelectedDate>((event, emit) {
      emit(state.copyWith(selectedDate: event.selectedDate));
    });

    on<UpdateRating>((event, emit) {
      emit(state.copyWith(rating: event.rating));
    });

    on<UpdateMessage>((event, emit) {
      emit(state.copyWith(message: event.message));
    });

    on<UpdatePickedImagesList>((event, emit) {
      emit(state.copyWith(pickedImages: event.images));
    });

    on<ToggleRedBorder>((event, emit) {
      emit(state.copyWith(showRedBorder: event.show));
    });

    on<UpdateDropdownSelectedItem>((event, emit) {
      final updatedDropdownSelectedItems = Map<String, Map<String, dynamic>>.from(state.selectedItems);
      updatedDropdownSelectedItems[event.dropdownType] = event.selectedItem;
      emit(state.copyWith(selectedItems: updatedDropdownSelectedItems));
    });

    on<UpdateDropdownSearchQuery>((event, emit) {
      final updatedDropdownSearchQueries = Map<String, String>.from(state.searchQueries);
      updatedDropdownSearchQueries[event.dropdownType] = event.query;
      emit(state.copyWith(searchQueries: updatedDropdownSearchQueries));
    });

    on<UpdateDropdownItemsList>((event, emit) {
      final updatedDropdownItems = Map<String, List<Map<String, dynamic>>>.from(state.dropdownItems);
      updatedDropdownItems[event.dropdownType] = event.items;
      emit(state.copyWith(dropdownItems: updatedDropdownItems));
    });

    on<UpdateIsLoading>((event, emit) {
      emit(state.copyWith(isLoading: event.isLoading));
    });
  }
}