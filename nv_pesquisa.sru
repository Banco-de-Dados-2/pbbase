HA$PBExportHeader$nv_pesquisa.sru
forward
global type nv_pesquisa from nonvisualobject
end type
end forward

global type nv_pesquisa from nonvisualobject
end type
global nv_pesquisa nv_pesquisa

forward prototypes
public function boolean of_buscar_pesquisa (long row, boolean ab_clicked, ref u_dw adw, nv_datastore ads, string as_col[])
public function long of_busca_codigo (string tabela, long al_long)
end prototypes

public function boolean of_buscar_pesquisa (long row, boolean ab_clicked, ref u_dw adw, nv_datastore ads, string as_col[]);Long ll_row, ll_codigo
If ab_clicked Then
	W_PES:
	s_parm lst_envia, lst_recese
	lst_envia.string[1] = as_col[3]
	OpenWithParm(w_pesquisa, lst_envia)
	lst_recese = Message.Powerobjectparm
	If IsValid(lst_recese) Then
		If UpperBound(lst_recese.boolean) > 0 Then
			If lst_recese.boolean[1] Then
				adw.SetItem( row, as_col[1], lst_recese.Long[1] )
				adw.SetItem( row, as_col[2], lst_recese.String[1] )
				adw.accepttext( )
			End If
		End If
	End If
Else
	If ads.RowCount() > 0 Then
		FORN:
		ll_codigo = Uf_Null(adw.GetItemNumber( row, as_col[1]),0)
		ll_row = ads.Find( ' codigo = ' + String(ll_codigo) , 1, ads.RowCount())
		If ll_row > 0 Then
			adw.SetItem( row, as_col[2], uf_null(ads.GetItemString( ll_row, 'descricao'), 'n/a'))
			adw.accepttext( )
		Else
			GOTO W_PES
			Msg("N$$HEX1$$e300$$ENDHEX$$o foi encontrado nenhum registro")
		End If
	Else
		If ads.Retrieve() > 0 Then
			GOTO FORN
		Else
			GOTO W_PES
			Msg("N$$HEX1$$e300$$ENDHEX$$o foi encontrado nenhum registro")
		End If
	End If
End If

Return True
end function

public function long of_busca_codigo (string tabela, long al_long);long ll_retorno

Choose Case tabela
	Case 'dba.tb_itens'
		SELECT 
			ite_codigo 
		INTO :ll_retorno
		FROM 
			dba.tb_itens
		WHERE
			ite_codigo = :al_long
		USING SQLCA;
	Case 'dba.tb_produto'
		SELECT 
			pro_codigo 
		INTO :ll_retorno
		FROM 
			dba.tb_produto
		WHERE
			pro_codigo = :al_long
		USING SQLCA;		
	Case 'dba.tb_fornecedor'
		SELECT 
			for_codigo 
		INTO :ll_retorno
		FROM 
			dba.tb_fornecedor
		WHERE
			for_codigo = :al_long
		USING SQLCA;
	Case 'dba.tb_vendas'
		SELECT 
			ven_codigo 
		INTO :ll_retorno
		FROM 
			dba.tb_vendas
		WHERE
			ven_codigo = :al_long
		USING SQLCA;
	Case 'dba.tb_funcionarios'
		SELECT 
			fun_codigo 
		INTO :ll_retorno
		FROM 
			dba.tb_funcionarios
		WHERE
			fun_codigo = :al_long
		USING SQLCA;
	Case Else
		ll_retorno = 0
End Choose

Return Uf_Null(ll_retorno, 0)
end function

on nv_pesquisa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_pesquisa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

