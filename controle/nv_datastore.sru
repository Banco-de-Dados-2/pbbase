HA$PBExportHeader$nv_datastore.sru
forward
global type nv_datastore from datastore
end type
end forward

global type nv_datastore from datastore
end type
global nv_datastore nv_datastore

forward prototypes
public function integer of_create_from_sql (string as_sql, boolean ab_retrieve)
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

If ab_retrieve Then this.retrieve()
	
Return 0
end function

on nv_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

