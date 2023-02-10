abstract class AppStates {}

class AppInitState extends AppStates {}

class AppChangeModeState extends AppStates {}

class AppChangeGridState extends AppStates {}

class AppChangeSelectedColorState extends AppStates {}

class AppChangeVariableState extends AppStates {}

class AppCreateDBState extends AppStates {}
class AppGetFromDBState extends AppStates {}
class AppInsertIntoDBState extends AppStates {}
class AppUpdateDBEditNoteState extends AppStates {}
class AppUpdateDBNoteStatusState extends AppStates {}
class AppDeleteFromDBState extends AppStates {}