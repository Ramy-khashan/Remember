abstract class AppStates {}

class InitialAppState extends AppStates {}

class InitialDatabaseState extends AppStates {}

class CreateDatabaseState extends AppStates {}
class CreateVoiceNoteDatabaseState extends AppStates {}

class OpenDatabaseState extends AppStates {}

class InsertNoteToDatabaseState extends AppStates {}

class UpdateNoteToDatabaseState extends AppStates {}

class SuccesGetNoteToDatabaseState extends AppStates {}

class DeleteNoteToDatabaseState extends AppStates {}

class LoadingDatabaseState extends AppStates {}

class FaildGetDatabaseState extends AppStates {}

class LanguageHeadState extends AppStates {}

class GetDateValueState extends AppStates {}

class GetStartEndTimeState extends AppStates {}

class UpdateReminderValueState extends AppStates {}

class InserttodoToDatabaseState extends AppStates {}

class UpdateTodoToDatabaseState extends AppStates {}

class SuccesGetTodoToDatabaseState extends AppStates {}

class DeleteTodoToDatabaseState extends AppStates {}

class GetIdTodoToDatabaseState extends AppStates {}

class RefreshState extends AppStates {}
