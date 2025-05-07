 
import 'dart:core';

import 'package:flutter_bloc/flutter_bloc.dart'; 

part 'voice_note_state.dart';

class VoiceNoteCubit extends Cubit<VoiceNoteState> {
  VoiceNoteCubit() : super(VoiceNoteInitial());
  static VoiceNoteCubit get(ctx) => BlocProvider.of(ctx);
  
}
