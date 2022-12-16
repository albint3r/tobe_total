import 'package:flutter/material.dart';
import 'forms/form_update_training_itinerary.dart';

class UpdateTrainingItinerary extends StatelessWidget {
  const UpdateTrainingItinerary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TrainingItineraryForm(),
    );
  }
}