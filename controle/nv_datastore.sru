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
	
	If ll_retorno = 1 Then
		this.ResetUpdate()
	End If
catch (DWRuntimeError e)
	Msg(e.Text)
	ll_retorno = -1
finally
	return ll_retorno
end try
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
			Case PreviewInsert!
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

