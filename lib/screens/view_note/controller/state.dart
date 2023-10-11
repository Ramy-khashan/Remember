part of 'cubit.dart';

@immutable
abstract class ViewNoteState {}

class ViewNoteInitial extends ViewNoteState {}
class GetImageToViewState extends ViewNoteState {}
class StartLoadingState extends ViewNoteState {}
