
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../auth/presentation/provider/cubit/button_progress_cubit/button_progress_cubit.dart';
import '../../../../../core/common/custom_snackbar_widget.dart';
import '../../../../../core/themes/colors.dart';
import '../../../provider/bloc/rating_review_bloc/rating_review_bloc.dart';

void handleRatingAndReviewState(BuildContext context, RatingReviewState state) {
    final buttonCubit = context.read<ButtonProgressCubit>();
  if(state is RatingReviewLoading){
    buttonCubit.bottomSheetStart();
  }else if (state is RatingReviewFailure) {
    buttonCubit.bottomSheetStop();
    Navigator.pop(context);
     buttonCubit.bottomSheetStop();
     CustomeSnackBar.show(
      context: context,
      title: 'Submition Request Failed!',
      description: 'Oops! ${state.errorMessage}. Your submition failed. Try again!',
      titleClr: AppPalette.redClr,
    );
  } else if(state is RatingReviewSuccess){
        buttonCubit.bottomSheetStop();
    Navigator.pop(context);
     buttonCubit.bottomSheetStop();
     CustomeSnackBar.show(
      context: context,
      title: 'Submition Request Success',
      description: 'Thank you! Your review and rating have been submitted successfully. It helps other users.',
      titleClr: AppPalette.greenClr,
    );
  }
}
