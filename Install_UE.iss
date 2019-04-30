; -- Example2.iss --
; Same as Example1.iss, but creates its icon in the Programs folder of the
; Start Menu instead of in a subfolder, and also creates a desktop icon.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName=Unturned Explorer
AppVersion=1.4
DefaultDirName={pf}\UnturnedExplorer
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\UExplorer.exe
Compression=lzma2
SolidCompression=yes    
OutputBaseFilename=UnturnedExplorer_Setup
OutputDir=D:\Мультимедиа\Проекты\UnturnedExplorer\Win32\Install

[Languages]
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Files]
Source: "Win32\Release\UExplorer.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "Win32\Release\sqlite3ex.dll"; DestDir: "{app}"; Flags: ignoreversion  
Source: "Win32\Release\libmysql.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "Win32\Release\libeay32.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "Win32\Release\language\*"; DestDir: "{app}\language"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{commonprograms}\Unturned Explorer"; Filename: "{app}\UExplorer.exe"
Name: "{commondesktop}\Unturned Explorer"; Filename: "{app}\UExplorer.exe"

[Run]
Filename: "{app}\UExplorer.exe"; Description: "Проводник Unturned"; Flags: nowait postinstall skipifsilent runascurrentuser