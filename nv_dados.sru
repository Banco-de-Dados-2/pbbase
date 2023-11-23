HA$PBExportHeader$nv_dados.sru
$PBExportComments$usado para operacoes no banco
forward
global type nv_dados from nv_ancobject
end type
end forward

global type nv_dados from nv_ancobject
end type
global nv_dados nv_dados

forward prototypes
public function integer update (powerobject pwo[])
public function longlong of_get_nextval (string as_sequence)
end prototypes

public function integer update (powerobject pwo[]);long ll_for 
For ll_for = 1 To UpperBound(pwo)
	If pwo[ll_For].TypeOf( ) = datastore! Then
		nv_datastore lds_update
		lds_update = pwo[ll_for]
		If lds_update.of_Update( ) <> 1 Then
			RollBack Using SQLCA;
			Return -1
		End If
	Elseif pwo[ll_For].TypeOf() = datawindow! Then
		u_dw ldw_update
		ldw_update = pwo[ll_for]
		If ldw_update.of_Update( ) <> 1 Then
			RollBack Using SQLCA;
			Return -1
		End If	
	End If
Next

If SQLCA.sqlcode = -1 Then
	Return -1
Else
	Commit Using SQLCA;
	Return 1
End If
end function

public function longlong of_get_nextval (string as_sequence);LongLong ll_retorno = -1
nv_datastore lds
nv_Transaction lt_contador 

lt_contador = Create nv_Transaction
lt_contador.of_connect( )

lds = Create nv_datastore
lds.DataObject = 'd_contador'
lds.setTransobject( lt_contador )
lds.Retrieve( as_sequence )
Commit Using lt_contador;

If lds.RowCount() > 0 Then
	ll_retorno = uf_null(lds.GetItemNumber(1, 'next_val'), -1)
End If

lt_contador.of_disconnect()
Destroy(lds)
Destroy(lt_contador)

Return ll_retorno
end function

on nv_dados.create
call super::create
end on

on nv_dados.destroy
call super::destroy
end on

