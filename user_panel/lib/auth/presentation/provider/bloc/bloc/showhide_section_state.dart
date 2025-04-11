part of 'showhide_section_bloc.dart';

abstract class ShowhideSectionState {}

final class ShowhideSectionInitial extends ShowhideSectionState {}
class ShowTopsectionState extends ShowhideSectionState{
  final bool showTopSection;
  ShowTopsectionState(this.showTopSection);
}