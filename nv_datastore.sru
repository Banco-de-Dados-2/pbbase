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
public function Integer of_create_group (string as_campo, integer ai_hierarquia)
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

public function Integer of_create_group (string as_campo, integer ai_hierarquia);Long ll_pos = 0, ll_count = 1, ll_hierarquia
String ls_group, ls_syntax

ls_syntax = This.Object.DataWindow.Syntax

If ai_hierarquia = 0 Then
	Do 
		ll_pos = Pos( ls_syntax, 'group(level=', ll_pos)
		If ll_pos = 0 Then
			ll_hierarquia = ll_count
		Else
			ll_count++
		End If
	Loop While ll_pos > 0
Else
	ll_pos = Pos( ls_syntax, 'group(level='+String(ai_hierarquia), ll_pos)
	
End If

ls_group = 'group(level='+String(ll_hierarquia)+' header.height=0 trailer.height=0 by=("' + as_campo +'" ) header.color="536870912" trailer.color="536870912" )'

Return 1 

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

