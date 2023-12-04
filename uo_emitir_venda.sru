HA$PBExportHeader$uo_emitir_venda.sru
forward
global type uo_emitir_venda from u_uo
end type
type dw_info from u_dw within uo_emitir_venda
end type
type dw_item from u_dw within uo_emitir_venda
end type
type dw_venda from u_dw within uo_emitir_venda
end type
end forward

global type uo_emitir_venda from u_uo
integer width = 4498
integer height = 2300
dw_info dw_info
dw_item dw_item
dw_venda dw_venda
end type
global uo_emitir_venda uo_emitir_venda

type variables
nv_dados inv_dados
w_venda iw_pai
Boolean lb_alterando = False, lb_inserindo = False
nv_Datastore ids_funcionario, ids_produto
end variables

forward prototypes
public subroutine of_incluir ()
public function boolean of_incluir_item ()
public subroutine of_inicializar ()
public subroutine of_limpar ()
public subroutine of_set_menu (m_edit am)
public subroutine of_excluir ()
public function boolean of_excluir_item ()
public subroutine of_gravar ()
public subroutine of_busca_tabela (long row, boolean ab_clicked, string tipo)
public subroutine of_get_preco (long row)
public subroutine of_atualiza_total ()
public function boolean of_validar ()
end prototypes

public subroutine of_incluir ();longlong ll_codigo

If uf_null(dw_venda.GetItemNumber(1, 'ven_codigo' ), 0) > 0 Then Return
ll_codigo = inv_dados.of_get_nextval( 'dba.ven_codigo')
If ll_codigo <= 0 Then
	Msg('Erro ao buscar contador')
	this.of_limpar( )
	Return
Else
	lb_alterando = False
	lb_inserindo = True
	iw_pai.of_set_estado('GEVL')
	im_edit.of_enable(is_estado)
	dw_item.Reset()
	dw_venda.Reset()
	dw_venda.InsertRow(0)
	dw_venda.SetItem( 1, 'ven_codigo', ll_codigo)
	dw_venda.SetItem( 1, 'ven_horario', Now())
	dw_venda.of_bloq_campo( {"ven_codigo", "ven_valor_total", "tb_funcionarios_fun_nome"}, true)
	dw_venda.of_bloq_campo( {"tb_funcionarios_fun_codigo", "ven_horario", "b_excluir", "b_incluir"}, false)
	If Not of_incluir_item() Then this.of_limpar( )
End If

end subroutine

public function boolean of_incluir_item ();Long ll_codigo , ll_row, ll_venda
ll_venda = uf_null(dw_venda.GetItemNumber(1, 'ven_codigo' ), 0)
If ll_venda <= 0 Then Return False
ll_codigo = inv_dados.of_get_nextval( 'dba.ite_codigo')
If ll_codigo <= 0 Then
	Msg('Erro ao buscar contador')
	Return False
Else
	ll_row = dw_item.InsertRow(0)
	dw_item.SetItem( ll_row, 'tb_itens_ite_codigo', ll_codigo)
	dw_item.SetItem( ll_row, 'tb_itens_tb_vendas_ven_codigo', ll_venda)
	Return True
End If

end function

public subroutine of_inicializar ();w_ancestor lw_pai

inv_dados = Create nv_dados
lw_pai = GetParent().GetParent()

ids_funcionario = Create Nv_Datastore
ids_funcionario.of_create_from_sql( " select FUN_CODIGO AS CODIGO, FUN_NOME AS DESCRICAO from DBA.TB_FUNCIONARIOS  " , True)

ids_produto = Create Nv_Datastore
ids_produto.of_create_from_sql( " select PRO_CODIGO AS CODIGO, PRO_DESCRICAO AS DESCRICAO from DBA.TB_PRODUTO  " , True)

dw_venda.of_set_w_pai( lw_pai )
dw_venda.of_set_color_background( )
dw_info.of_set_w_pai( lw_pai )
dw_info.of_set_color_background( )
dw_info.InsertRow(0)

dw_venda.SetTransObject(SQLCA)
dw_item.settransobject( SQLCA)
This.Of_limpar()


end subroutine

public subroutine of_limpar ();dw_venda.Reset()
dw_venda.InsertRow(0)
dw_item.Reset()

iw_pai.of_set_estado('EIVL')
im_edit.of_enable(is_estado)

dw_venda.of_bloq_campo( {"ven_codigo", "ven_valor_total", "tb_funcionarios_fun_nome","tb_funcionarios_fun_codigo", "ven_horario", "b_excluir", "b_incluir"}, true)
end subroutine

public subroutine of_set_menu (m_edit am);im_edit = am
end subroutine

public subroutine of_excluir ();If uf_null(dw_venda.GetItemNumber(1, 'ven_codigo' ), 0) <= 0 Then Return

If MessageBox( gs_sistema, 'Deseja Excluir ', Question!, YesNo!, 2  ) <> 1 Then Return

dw_venda.SetRedraw(False)
dw_item.SetRedraw(False)

dw_venda.DeleteRow(0)
dw_item.RowsMove( 1, dw_item.RowCount(), Primary!, dw_item, 0, Delete!)

lb_alterando = True
lb_inserindo = False

of_gravar()

dw_venda.SetRedraw(True)
dw_item.SetRedraw(True)
end subroutine

public function boolean of_excluir_item ();Long ll_row
ll_row = dw_item.GetSelectedRow(0)
If ll_row <= 0 Then
	Msg('Selecione um item')
	Return False
Else
	dw_item.DeleteRow(ll_row)
	If dw_item.RowCount() >= ll_row Then
		dw_item.SelectRow(ll_row, true)
	Elseif dw_item.RowCount() >= ll_row -1 Then
		dw_item.SelectRow(ll_row - 1, true)
	Else
		dw_item.SelectRow(1, true)
	End If
	Return True
End If


end function

public subroutine of_gravar ();dw_venda.accepttext( )
dw_item.accepttext( )

If Not of_Validar() Then 
	Return
End If 

If inv_dados.Update( { dw_venda, dw_item } ) = 1 Then
	Msg("Gravado com Sucesso")
	This.of_limpar( )
Else
	Msg("Erro ao Gravar")
End If
end subroutine

public subroutine of_busca_tabela (long row, boolean ab_clicked, string tipo);nv_pesquisa lnv_pesquisa
Long ll_find, ll_null
dw_venda.AcceptText()
dw_item.AcceptText()

SetNull(ll_null)

lnv_pesquisa = Create nv_pesquisa
If tipo = 'tb_fun_view' Then
	lnv_pesquisa.of_buscar_pesquisa( row, ab_clicked, dw_venda, ids_funcionario, { "tb_funcionarios_fun_codigo",  "tb_funcionarios_fun_nome", "dba.tb_fun_view" })
	dw_venda.AcceptText()
Elseif tipo = 'produto' Then
	lnv_pesquisa.of_buscar_pesquisa( row, ab_clicked, dw_item , ids_produto , { "tb_itens_tb_produto_pro_codigo",  "tb_produto_pro_descricao", "dba.tb_produto" })	
	dw_item.AcceptText()
	ll_find = dw_item.find( 'tb_itens_tb_produto_pro_codigo = ' + String(Uf_null(dw_item.GetItemNumber( row, 'tb_itens_tb_produto_pro_codigo' ), 0)) , 1, dw_item.RowCount() )
	If ll_find > 0 and ll_find <> row Then
		Msg('Produto j$$HEX2$$e1002000$$ENDHEX$$listado')
		dw_item.SetItem( row, 'tb_itens_tb_produto_pro_codigo', ll_null )
		dw_item.SetFocus()
		dw_item.SetRow(row)
		Return
	End If
	dw_item.AcceptText()
	Post of_get_preco( row )
End If

Destroy( lnv_pesquisa )

end subroutine

public subroutine of_get_preco (long row);Decimal lde_preco, lde_qtd
Long ll_codigo
nv_produto lnv_produto

lnv_produto = Create nv_produto 
ll_codigo = uf_null(dw_item.GetItemNumber(row, 'tb_itens_tb_produto_pro_codigo'), 0)
lde_preco = lnv_produto.of_get_preco( ll_codigo )
lde_qtd = lnv_produto.of_get_qtd( ll_codigo )

If lde_preco > 0 Then
	dw_item.SetItem(row, 'tb_produto_pro_valor', lde_preco )
	dw_item.SetItem(row, 'tb_itens_ite_valor_parceial', lde_preco )
	dw_info.SetItem(1, 'valor', lde_preco)
	dw_item.AcceptText()
	dw_item.event itemchanged( row , dw_item.object.tb_itens_ite_valor_parceial , String(lde_preco))
End If

If lde_qtd > 0 Then
	dw_item.SetItem(row, 'tb_produto_pro_quantidade', lde_qtd )
	dw_info.SetItem(1, 'qtd', lde_qtd)
	dw_item.AcceptText()
	dw_item.event itemchanged( row , dw_item.object.tb_produto_pro_quantidade , String(lde_qtd))
End If
end subroutine

public subroutine of_atualiza_total ();Decimal lde_total
If dw_item.RowCount() <= 0 Then Return
lde_total = uf_null(dw_item.GetItemNumber(1, 'cpt_total' ), 0)
If lde_total  > 0 Then
	dw_venda.SetItem( 1, 'ven_valor_total', lde_total )
End If
end subroutine

public function boolean of_validar ();Datetime ldt_horario
Decimal lde_valortotal
Long ll_venda, ll_funcionario, ll_row, ll_for
nv_pesquisa lnv_pesquisa

lnv_pesquisa = Create nv_pesquisa

If lb_inserindo Then
	ldt_horario = dw_venda.getItemDateTime(1, 'ven_horario')
	lde_valortotal = uf_null(dw_venda.getItemNumber(1, 'ven_valor_total'), 0)
	ll_venda = uf_null(dw_venda.getItemNumber(1, 'ven_codigo'), 0)
	ll_funcionario = uf_null(dw_venda.getItemNumber(1, 'tb_funcionarios_fun_codigo'), 0)
	
	If IsNull(ldt_horario) Then 
		Msg("Horario invalida")
		Return False
	End If
	If lde_valortotal < 0 Then
		Msg("valor invalido")
		Return False
	End If
	If ll_venda < 0 Then
		Msg("C$$HEX1$$f300$$ENDHEX$$digo venda invalido")
		Return False
	End If
	If ll_funcionario < 0 Then
		Msg("C$$HEX1$$f300$$ENDHEX$$digo funcionario invalido")
		Return False
	End If
	
	if lnv_pesquisa.of_busca_codigo(  'dba.tb_funcionarios'  , ll_funcionario) <= 0 Then 
		Msg("Funcionario N$$HEX1$$e300$$ENDHEX$$o Existe")
		Return False
	End If
	
	For ll_for = 1 To dw_item.RowCount()
		Decimal lde_valoruniotario
		Long ll_qtd, ll_produto, ll_item
		lde_valoruniotario = uf_null(dw_item.GetItemNumber( ll_for, 'tb_itens_ite_valor_parceial' ),0)
		ll_qtd = uf_null(dw_item.GetItemNumber( ll_for, 'tb_itens_ite_quantidade' ),0)
		ll_produto = uf_null(dw_item.GetItemNumber( ll_for, 'tb_itens_tb_produto_pro_codigo' ),0)
		ll_item = uf_null(dw_item.GetItemNumber( ll_for, 'tb_itens_ite_codigo' ),0)
		If ll_item <= 0 Then 
			Msg("Produto N$$HEX1$$e300$$ENDHEX$$o Existe")
			Return False
		End If
		if lnv_pesquisa.of_busca_codigo(  'dba.tb_produto'  , ll_produto) <= 0 Then 
			Msg("Produto N$$HEX1$$e300$$ENDHEX$$o Existe")
			Return False
		End If
		If lde_valoruniotario <= 0 Then 
			Msg("Valor Invalido")
			Return False
		End If
		If ll_qtd <= 0 Then 
			Msg("Qtd Invalida")
			Return False
		End If
	Next
	
Elseif lb_alterando Then
	//Criar Toda opera$$HEX2$$e700e300$$ENDHEX$$o de Altera$$HEX2$$e700e300$$ENDHEX$$o de venda
End If

Destroy( lnv_pesquisa )

Return True
end function

on uo_emitir_venda.create
int iCurrent
call super::create
this.dw_info=create dw_info
this.dw_item=create dw_item
this.dw_venda=create dw_venda
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_info
this.Control[iCurrent+2]=this.dw_item
this.Control[iCurrent+3]=this.dw_venda
end on

on uo_emitir_venda.destroy
call super::destroy
destroy(this.dw_info)
destroy(this.dw_item)
destroy(this.dw_venda)
end on

event constructor;call super::constructor;iw_pai = GetParent().Dynamic GetParent()
end event

event destructor;call super::destructor;Destroy(ids_funcionario)
end event

type dw_info from u_dw within uo_emitir_venda
integer x = 146
integer y = 2160
integer width = 1925
integer height = 108
integer taborder = 30
string dataobject = "d_info_prod"
boolean border = false
end type

type dw_item from u_dw within uo_emitir_venda
integer x = 37
integer y = 392
integer width = 4251
integer height = 1756
integer taborder = 20
string dataobject = "d_emitir_venda_item"
end type

event clicked;call super::clicked;Long ll_find

If row > 0 Then	
	If this.GetSelectedRow(0) > 0 Then this.selectRow( this.GetSelectedRow(0), False)
	this.selectRow( row , true)
	If dwo.Name = 'b_produto' Then
		Post of_busca_tabela( row, True, 'produto' )
	End If
End If
end event

event itemchanged;call super::itemchanged;Long ll_find

If dwo.Name = 'tb_itens_tb_produto_pro_codigo' Then
	Post of_busca_tabela( row, false, 'produto' )
End If

If dwo.name = 'tb_itens_ite_valor_parceial' or dwo.name = 'tb_itens_ite_quantidade' Then
	Post of_atualiza_total()
End If
end event

event rowfocuschanged;call super::rowfocuschanged;If currentrow > 0 Then
	dw_info.SetItem(1, 'valor', Uf_Null(this.GetItemNumber(currentrow, 'tb_produto_pro_valor'),0))
	dw_info.SetItem(1, 'qtd', Uf_Null(this.GetItemNumber(currentrow, 'tb_produto_pro_quantidade'),0))
Else 
	dw_info.SetItem(1, 'valor', 0)
	dw_info.SetItem(1, 'qtd', 0)	
End If

dw_info.Accepttext( )
end event

type dw_venda from u_dw within uo_emitir_venda
integer x = 37
integer y = 40
integer width = 4261
integer height = 252
integer taborder = 10
string dataobject = "d_emitir_venda"
boolean border = false
end type

event clicked;call super::clicked;if dwo.name = 'b_incluir' Then
	of_incluir_item()
Elseif dwo.name = 'b_excluir' Then
	of_excluir_item()	
End If
end event

event doubleclicked;call super::doubleclicked;If this.RowCount() <= 0 Then Return
If uf_null(this.GetItemNumber(1, 'ven_codigo'), 0) <= 0 Then Return
If dwo.name = 'tb_funcionarios_fun_codigo' Then
	Post of_busca_tabela( row, true, 'tb_fun_view' )
End If
end event

event itemchanged;call super::itemchanged;If this.RowCount() <= 0 Then Return
If uf_null(this.GetItemNumber(1, 'ven_codigo'), 0) <= 0 Then Return
If dwo.name = 'tb_funcionarios_fun_codigo' Then
	Post of_busca_tabela( row, False, 'funcionarios')
End If
end event

