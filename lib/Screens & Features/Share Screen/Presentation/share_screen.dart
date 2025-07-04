import 'package:developerlook_task_app/Core/app_export.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_bloc.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_state.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Presentation/Widgets/Image%20Picker/share_image_uploader.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Presentation/Widgets/message_textbox.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Presentation/Widgets/rating.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Presentation/Widgets/share_dropdown_widget.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Presentation/Widgets/submit_button.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Presentation/Widgets/Date%20Picker/traveldate_picker.dart';
import 'package:flutter/material.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShareReviewBloc, ShareReviewState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: state.isLoading ?
            const Center(
                child: CircularProgressIndicator(),
              )
                :
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Page Title
                    const Text(
                      'Share',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),

                    // Image Uploader
                    const SizedBox(height: 20),
                    ShareImageUploader(state: state,),

                    //Dropdowns for Departure
                    const SizedBox(height: 30),
                    ShareDropdownWidget(state: state, dropdownType: 'departure'),

                    //Dropdowns for Arrival
                    const SizedBox(height: 15),
                    ShareDropdownWidget(state: state, dropdownType: 'arrival'),

                    //Dropdowns for Airline
                    const SizedBox(height: 15),
                    ShareDropdownWidget(state: state, dropdownType: 'airline'),

                    //Dropdowns for Class
                    const SizedBox(height: 15),
                    ShareDropdownWidget(state: state, dropdownType: 'class'),

                    //Message Textbox
                    const SizedBox(height: 15),
                    MessageTextbox(),

                    //Rating & Date Picker
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TravelDatePicker(state: state,),
                        const SizedBox(width: 10),
                        Rating(state: state,),
                      ],
                    ),

                    const SizedBox(height: 20),

                    //Submit Button
                    SubmitButton()
                  ],
                ),
              ),
            )
          ),
        );
      },
    );
  }
}


