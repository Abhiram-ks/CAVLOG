import 'package:bloc/bloc.dart';


class RatingCubit extends Cubit<double> {
  RatingCubit() : super(0.0);

  void setRating(double rating) => emit(rating);
  void clearRating() => emit(0.0);
}
