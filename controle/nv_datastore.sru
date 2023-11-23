HA$PBExportHeader$nv_datastore.sru
forward
global type nv_datastore from datastore
end type
end forward

global type nv_datastore from datastore
end type
global nv_datastore nv_datastore

type variables
Boolean ib_NoWait, ib_ForUpdate
end variables

forward prototypes
public function integer of_create_from_sql (string as_sql, boolean ab_retrieve)
public function integer of_update ()
public function Boolean of_lock_table (string as_col, long al_pk)
end prototypes

public function integer of_create_from_sql (string as_sql, boolean ab_retrieve);String ERRORS, ls_Syntax

ls_Syntax = SQLCA.SyntaxFromSQL( as_sql, "", ERRORS )

If Len(ERRORS) > 0 Then
	Return -1
End If

this.Create( ls_Syntax, ERRORS )

If Len(ERRORS) > 0 Then
	Return -1
End If

this.SetTransObject( SQLCA )

If ab_retrieve Then this.retrieve()
	
Return 0
end function

public function integer of_update ();long ll_retorno

try 
	ll_retorno = this.update(True, False)

catch (DWRuntimeError e)
	Msg(e.Text)
	ll_retorno = -1
finally
	return ll_retorno
end try
end function

public function Boolean of_lock_table (string as_col, long al_pk);String ls_table, ls_exec

ls_table = this.Describe("Datawindow.table.updatetable")

ls_exec = "SELECT 1 FROM " + ls_table + " WHERE " + as_col + " = " + String(al_pk) + " FOR UPDATE NOWAIT"

EXECUTE IMMEDIATE :ls_exec USING SQLCA;


If SQLCA.SQLCode <> 0 Then
	this.event dberror( SQLCA.SQLCode , SQLCA.SQLErrText , 'SELECT', Primary!,  0 )
	Return False
Else
	Return True
End If


	
end function

on nv_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event sqlpreview;String ls_Operacao

Try
	If isValid(SQLCA) Then
		Choose Case SQLType
			Case PreviewSelect!
				If ib_NoWait Then
					SetSQLPreview(SQLSyntax + " NOWAIT")
				ElseIf ib_ForUpdate Then
					SetSQLPreview(SQLSyntax + " FOR UPDATE NOWAIT")
				End If
		End Choose
	End If
Catch (RunTimeError e)
	Return 0
End Try
end event

