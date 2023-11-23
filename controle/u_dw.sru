HA$PBExportHeader$u_dw.sru
forward
global type u_dw from datawindow
end type
end forward

global type u_dw from datawindow
integer width = 1696
integer height = 848
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_key pbm_dwnkey
end type
global u_dw u_dw

type variables
Boolean ib_NoWait, ib_ForUpdate 
w_ancestor iw_pai
end variables

forward prototypes
public subroutine of_set_color_background ()
public subroutine of_bloq_campo (string as_campos[], boolean ab_bloq)
public subroutine of_set_w_pai (w_ancestor aw_window)
public function integer of_update ()
public function boolean of_lock_table (string as_col, long al_pk)
end prototypes

event ue_key;//
end event

public subroutine of_set_color_background ();//
this.Modify("DataWindow.Color='"+ String(iw_pai.BackColor) +"'")
end subroutine

public subroutine of_bloq_campo (string as_campos[], boolean ab_bloq);Long ll_tam, ll_for
String ls_Protect, ls_BackMode, ls_enabled
ll_tam = UpperBound(as_campos)

If ab_bloq Then
	ls_Protect = '1'
	ls_BackMode = '1'
	ls_enabled = 'No'
Else
	ls_Protect = '0'
	ls_BackMode = '0'	
	ls_enabled = 'Yes'
End If

For ll_for = 1 To ll_tam
	try 
		If left(as_campos[ll_for], 2) = 'b_' Then
			this.Modify(as_campos[ll_for]+".Enabled='"+ ls_enabled + "'")
		Else 
			this.Modify(as_campos[ll_for]+".Protect='"+ ls_Protect + "'")
			this.Modify(as_campos[ll_for]+".Background.Mode='" + ls_BackMode + "'")			
		End If
	catch ( Exception e )
		msg(e.Text)
	end try
Next
end subroutine

public subroutine of_set_w_pai (w_ancestor aw_window);iw_pai = aw_window
end subroutine

public function integer of_update ();long ll_retorno

try 
	ll_retorno = this.update(True, False)

catch ( DWRuntimeError e)
	Msg(e.Text)
	ll_retorno = -1
finally
	return ll_retorno
end try
end function

public function boolean of_lock_table (string as_col, long al_pk);String ls_table, ls_exec

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

on u_dw.create
end on

on u_dw.destroy
end on

event dberror;If SQLDBCode = -308 Or SQLDBCode = -108 Or Pos( Upper( SQLErrText ), "08003" ) > 0 Then
	MessageBox(gs_Sistema, "A conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados foi perdida, o sistema ser$$HEX2$$e1002000$$ENDHEX$$finalizado.", StopSign!)
	
	DISCONNECT USING SQLCA;
	
	Halt Close
End If

String ls_Msg1, ls_Msg2, ls_Column, ls_Col1, ls_Col2, ls_Chaves, ls_Campos = ""
Long ll_Pos, ll_Pos2, ll_Count, ll_For
s_Parm ls_Manda

If SQLDBCode >= -198 And SQLDBCode <= -198 And SQLDBCode <> 0 Then
	ls_Column = Trim(Upper(SQLErrText))
	
	ll_Pos = Pos(Upper(ls_Column), "FROM")
	ls_Col1 = Mid(ls_Column, ll_Pos + 4, 100)
	
	ll_Pos = Pos(Upper(Trim(ls_Col1))," ")
	ls_Col2 = Trim(Mid(ls_Col1, 1, ll_Pos))
	
	ls_Manda.String[1] = "Este registro n$$HEX1$$e300$$ENDHEX$$o pode ser eliminado/alterado porque est$$HEX2$$e1002000$$ENDHEX$$relacionado a outros registros."
	ls_Manda.String[2] = "Este registro n$$HEX1$$e300$$ENDHEX$$o pode ser eliminado da tabela " + String(ls_Col2) + " pois j$$HEX2$$e1002000$$ENDHEX$$est$$HEX2$$e1002000$$ENDHEX$$relacionado com outra tabela."
	
	ROLLBACK USING SQLCA;
	
	If not isValid(w_Msg_Erro) Then
		OpenWithParm(w_Msg_Erro, ls_Manda)
	End If
	
	Return 3
End If

nv_DataStore lds_Aux
lds_Aux = Create nv_DataStore

If SQLDBCode = -195 Or SQLDBCode = -209 Then
	ll_Pos = Pos(SQLErrText, "column")
	ls_Column = Mid(SQLErrText, ll_Pos, 100)
	
	ls_Col1 = Mid(ls_Column, Pos(ls_Column, "'") + 1, 100)
	ls_Col1 = Mid(ls_Col1, 1, Pos(ls_Col1, "'") - 1)
	
	ls_Col2 = Mid(ls_Column, Pos(ls_Column, "in table '"), 50)
	ls_Col2 = Mid(ls_Col2, Pos(ls_Col2, "'") + 1, 50) 
	ls_Col2 = Mid(ls_Col2, 1, Pos(ls_Col2, "'") - 1)
	
	ls_Msg1 = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gravar este registro!~rVerifique se o conte$$HEX1$$fa00$$ENDHEX$$do do campo " + ls_Col1 + " da tabela " + ls_Col2 + " foi preenchido corretamente."
	ls_Msg2 = SQLErrText
End If

If SQLDBCode = -196 Then
	ll_Pos = Pos(SQLErrText, "index")
	ls_Column = Mid(SQLErrText, ll_Pos, 100)
	
	ls_Col1 = Mid(ls_Column, Pos(ls_Column, "'") + 1, 100)
	ls_Col1 = Mid(ls_Col1, 1, Pos(ls_Col1, "'") - 1)
	ls_Col1 = uf_strtran(ls_Col1, '_', ', ')
	
	ls_Col2 = Mid(ls_Column, Pos(ls_Column, "table"), 100)
	ls_Col2 = Mid(ls_Col2, Pos(ls_Col2, "'") + 1, 100) 
	ls_Col2 = Mid(ls_Col2, 1, Pos(ls_Col2, "'") - 1)
	
   ls_Msg1 = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gravar ou inserir os dados!~rOs campos " + ls_Col1 + " da tabela " + ls_Col2 + " n$$HEX1$$e300$$ENDHEX$$o aceitam valores duplicados."
	ls_Msg2 = SQLErrText
End If

If SQLDBCode = -194 Then
	ll_Pos = Pos(SQLErrText,"foreign key")
	ls_Column = Mid(SQLErrText, ll_Pos, 100)
	
	ls_Col2 = Mid(ls_Column, Pos(ls_Column,"'") + 1, 100)
	ls_Col2 = Mid(ls_Col2, 1, Pos(ls_Col2,"'") - 1)
	
	lds_Aux.DataObject = "d_constraint"
	lds_Aux.SetTransObject(SQLCA)
	
	If lds_Aux.Retrieve(ls_Col2, "%FK%") > 0 Then
		ll_Count = lds_Aux.rowcount()
		
		For ll_For = 1 To ll_Count
			If ll_For = 1 Then 
				ls_Campos = lds_Aux.GetItemString(ll_For, "column_name")
			Else
				ls_Campos += ", " + lds_Aux.GetItemString(ll_For, "column_name")
			End If
		Next
		
		ls_Msg1 = "Os dados do(s) campo(s) " + ls_Campos + " que est$$HEX1$$e300$$ENDHEX$$o sendo tentados gravar na tabela " + lds_Aux.GetItemString(1, "tabelafilha") + ", n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o cadastrados na tabela ~r" + lds_Aux.GetItemString(1, "tabelapai") + ".~r"		
	End If	
	
	ls_Msg2 = "C$$HEX1$$f300$$ENDHEX$$digo do Retorno da Opera$$HEX2$$e700e300$$ENDHEX$$o : " + String(SQLDBCode) + " Msg : " + SQLErrText
End If		

If SQLDBCode = -3 Then
	ll_Pos = Pos(SQLErrText, "UPDATE")
	
	If ll_Pos = 0 Then
		ll_Pos = Pos(SQLErrText, "DELETE FROM")
		ll_Pos2 = Pos(SQLErrText, "WHERE")
		
		ls_Column = Mid(SQLErrText, ll_Pos + 11, ll_Pos2)
		ls_Column = Replace(ls_Column, ll_Pos2 - ll_Pos - 11, Len(ls_Column), "")
	Else
		ll_Pos2 = Pos(SQLErrText, "SET")
		
		ls_Column = Mid(SQLErrText, ll_Pos + 7, ll_Pos2)
		ls_Column = Replace(ls_Column, ll_Pos2 - ll_Pos - 7, Len(ls_Column), "")
	End If
	
	If Len(Trim(ls_Column)) > 0 Then
		MessageBox(gs_Sistema, "Relacionamento (" + ls_Column + ") n$$HEX1$$e300$$ENDHEX$$o mais existente!")
	Else
		MessageBox(gs_Sistema, "Relacionamento n$$HEX1$$e300$$ENDHEX$$o mais existente, favor carregar os dados novamente!")
	End If
	
	Return 3
End If	

If SQLDBCode = -193 Then
	ll_Pos = Pos(SQLErrText, "table")
	ls_Column = Mid(SQLErrText, ll_Pos, 100)
	
	ls_Col2 = Mid(ls_Column, Pos(ls_Column, "'") + 1, 100)
	ls_Col2 = Mid(ls_Col2, 1, Pos(ls_Col2, "'") - 1)
	
	lds_Aux.Reset()
   lds_Aux.DataObject = 'd_constraint'	
	lds_Aux.SetTransObject(SQLCA)
	ll_Count = lds_Aux.Retrieve(ls_Col2, "%PK%")
	
	For ll_For = 1 To ll_Count
		If ll_For = 1 Then 
			ls_Chaves = lds_Aux.GetItemString(ll_For, "column_name")
		Else
			ls_Chaves += ", " + lds_Aux.GetItemString(ll_For, "column_name")
		End If
	Next	
	
	ls_Msg1 = "O banco de dados n$$HEX1$$e300$$ENDHEX$$o permite que sejam gravados dois registros na tabela " + ls_Col2 + " com as mesmas informa$$HEX2$$e700f500$$ENDHEX$$es na chave prim$$HEX1$$e100$$ENDHEX$$ria(campos obrigat$$HEX1$$f300$$ENDHEX$$rios). Os campos da chave prim$$HEX1$$e100$$ENDHEX$$ria(campos obrigat$$HEX1$$f300$$ENDHEX$$rios) s$$HEX1$$e300$$ENDHEX$$o:~r" + ls_Chaves + ".~r"
	ls_Msg2 = SQLErrText
End If		

If SQLDBCode = -158 Then
	ls_Msg1 = "Valor informado $$HEX2$$e9002000$$ENDHEX$$muito grande para ser armazenado!.~r"
	ls_Msg2 = SQLErrText
End If	

If ls_Msg1 <> "" Then
	ls_Manda.String[1] = ls_Msg1
	ls_Manda.String[2] = ls_Msg2
Else
	ls_Manda.String[1] = "~r~rOpera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida! C$$HEX1$$f300$$ENDHEX$$digo do Retorno da Opera$$HEX2$$e700e300$$ENDHEX$$o: " + String(SQLDBCode)
	ls_Manda.String[2] = SQLErrText
End If	

ROLLBACK USING SQLCA;

If not isValid(w_Msg_Erro) Then
	OpenWithParm(w_Msg_Erro, ls_Manda)
End If

Return 3
end event

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

event destructor;ROLLBACK USING SQLCA;
end event

