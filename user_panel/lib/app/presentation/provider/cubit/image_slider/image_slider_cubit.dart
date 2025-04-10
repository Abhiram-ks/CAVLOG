import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class ImageSliderCubit  extends Cubit<int> {
  final PageController pageController = PageController();
  final List<String> imageList;
  Timer? autoScrollTimer;

  ImageSliderCubit({required this.imageList}) : super(0) {
    _startAutoScroll();
  }

  void _startAutoScroll() {
    autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (pageController.hasClients) {
        int nextPage = pageController.page!.round() + 1;
        if (nextPage >= imageList.length) {
          nextPage = 0;
        }
       pageController.animateToPage(
        nextPage, 
        duration:  const Duration(milliseconds: 500),
        curve: Curves.easeInOut);
        emit(nextPage);
      }
    });
  }

  void updatePage(int index){
    emit(index);
  }

  void dispose (){
    autoScrollTimer?.cancel();
    pageController.dispose();
  }
}