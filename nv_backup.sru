HA$PBExportHeader$nv_backup.sru
forward
global type nv_backup from nv_ancobject
end type
end forward

global type nv_backup from nv_ancobject
end type
global nv_backup nv_backup

forward prototypes
public subroutine of_run ()
end prototypes

public subroutine of_run ();run('wscript.exe scriptbackup.vbs ' + gs_directory_backup + ' ' + String(today(),'dd-mm-yyyy-') + string( now(), 'hh-mm-ss' ) + '' )


end subroutine

on nv_backup.create
call super::create
end on

on nv_backup.destroy
call super::destroy
end on

event constructor;call super::constructor;If Not DirectoryExists ( gs_directory_backup ) Then
	If CreateDirectory ( gs_directory_backup ) <> 1 Then
		Msg("Erro ao criar backup")
		Return -1
	End If
End If


end event

