part of 'add_voice_note_cubit.dart';

@immutable
abstract class AddVoiceNoteState {}

class AddVoiceNoteInitial extends AddVoiceNoteState {}
class LanguageState extends AddVoiceNoteState {}

class GetDuratioState extends AddVoiceNoteState {}
class StopRecorderState extends AddVoiceNoteState {}
class PauseRecorderState extends AddVoiceNoteState {}
class LoadingAddNoteState extends AddVoiceNoteState {}
class  AddNoteState extends AddVoiceNoteState {} 