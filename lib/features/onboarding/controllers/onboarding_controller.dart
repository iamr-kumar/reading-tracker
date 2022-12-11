import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingState {
  final int? type;
  final int? minutes;
  final int? pages;
  final TimeOfDay? time;

  OnboardingState({
    this.type = 1,
    this.minutes,
    this.pages,
    this.time,
  });

  OnboardingState copyWith({
    int? type,
    int? minutes,
    int? pages,
    TimeOfDay? time,
  }) {
    return OnboardingState(
      type: type ?? this.type,
      minutes: minutes ?? this.minutes,
      pages: pages ?? this.pages,
      time: time ?? this.time,
    );
  }
}

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingState>(
        (ref) => OnboardingController());

class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController() : super(OnboardingState());

  void setType(int? type) {
    state = state.copyWith(type: type);
  }

  void setMinutes(int? minutes) {
    state = state.copyWith(minutes: minutes);
  }

  void setPages(int? pages) {
    state = state.copyWith(pages: pages);
  }

  void setTime(TimeOfDay? time) {
    state = state.copyWith(time: time);
  }

  void completeOnboarding() {
    // implement this
  }
}
