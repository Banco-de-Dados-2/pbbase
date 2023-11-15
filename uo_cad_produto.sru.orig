HA$PBExportHeader$uo_cad_produto.sru
forward
global type uo_cad_produto from u_uo
end type
type dw_filtro from u_dw within uo_cad_produto
end type
type dw_produto from u_dw within uo_cad_produto
end type
type cb_ok from u_cb within uo_cad_produto
end type
type cb_cancel from u_cb within uo_cad_produto
end type
type gb_produto from u_gb within uo_cad_produto
end type
type gb_filtro from u_gb within uo_cad_produto
end type
end forward

global type uo_cad_produto from u_uo
integer width = 5000
integer height = 2300
dw_filtro dw_filtro
dw_produto dw_produto
cb_ok cb_ok
cb_cancel cb_cancel
gb_produto gb_produto
gb_filtro gb_filtro
end type
global uo_cad_produto uo_cad_produto

type variables
String filtro_codigo , filtro_descricao 
nv_dados inv_dados
w_cad_produto iw_pai
Boolean lb_alterando = False, lb_inserindo = False
nv_datastore ids_fornecedor 

KeyCode IKey
end variables

forward prototypes
public subroutine of_retrieve ()
public subroutine of_excluir_dw (long row)
public subroutine of_editar_dw (long row)
public subroutine of_filter (long row, string name)
public subroutine of_inicializar ()
public subroutine of_set_menu (m_edit am)
public subroutine of_limpar ()
public subroutine of_valida_incluir (boolean lb_itemchanged)
public subroutine of_incluir ()
public subroutine of_gravar ()
public function boolean of_validar ()
public subroutine of_busca_fornecedor (long row, boolean ab_clicked)
end prototypes

public subroutine of_retrieve ();dw_produto.Reset()
dw_produto.SetFilter('')
dw_produto.Filter()
dw_produto.Retrieve( filtro_codigo , filtro_descricao )
iw_pai.of_set_estado('VGIL')
im_edit.of_enable( is_estado )
end subroutine

public subroutine of_excluir_dw (long row);Long ll_find
dw_produto.deleteRow(row)
ll_find = dw_produto.Find( " IsNull(pro_descricao) or pro_descricao = '' ", 1, dw_produto.RowCount() ) 
If ll_find > 0 Then	
	iw_pai.of_set_estado('VGL')
	im_edit.of_enable( is_estado )
	dw_produto.SetFocus()
	dw_produto.SetRow( ll_find )
Else
	iw_pai.of_set_estado('VGIL')
	im_edit.of_enable( is_estado )
End If
end subroutine

public subroutine of_editar_dw (long row);If  dw_produto.GetItemString( row, 'flageditar') = 'F' Then
	dw_produto.AcceptText()
	dw_produto.SetItem( row, 'flageditar', 'T')
Else
	dw_produto.AcceptText()
	dw_produto.SetItem( row, 'flageditar', 'F')
	dw_produto.SetSort('pro_codigo asc')
	dw_produto.Sort()
End If




end subroutine

public subroutine of_filter (long row, string name);String ls_filter, data

dw_filtro.AcceptText()

Choose Case name
	Case 'pro_descricao'	
		data = Trim(uf_null(dw_filtro.GetItemString(1, name ), ''))
		filtro_descricao = data
	Case 'pro_codigo'	
		data = uf_null(String(dw_filtro.GetItemNumber(1, name )),'')
		If data = '0' then data = ''
		filtro_codigo = data
End Choose

If Len(filtro_codigo) > 0 Then &
	ls_filter += "If( Pos(String(pro_codigo), '" + filtro_codigo + "') > 0 , 1,0) = 1 and "	
If Len(filtro_descricao) > 0 Then &
	ls_filter += "If( Pos(String(pro_descricao), '" + filtro_descricao + "') > 0 , 1,0) = 1 and "	

ls_filter = Left(ls_filter, Len(ls_filter) - 5)

dw_produto.setFilter( ls_filter )	
dw_produto.Filter()
	
	
end subroutine

public subroutine of_inicializar ();iw_pai = GetParent() 

dw_produto.SetReDraw(false)
dw_filtro.SetReDraw(false)
inv_dados = Create nv_dados

dw_filtro.of_set_w_pai( iw_pai )
dw_filtro.of_set_color_background( )
dw_filtro.InsertRow(0)

dw_produto.SetTransObject(SQLCA)
dw_produto.retrieve( filtro_codigo , filtro_descricao )

ids_fornecedor = Create nv_datastore
ids_fornecedor.of_create_from_sql("select for_codigo as codigo , for_descricao as descricao from dba.tb_fornecedor", True)

dw_produto.SetReDraw(True)
dw_filtro.SetReDraw(True)
end subroutine

public subroutine of_set_menu (m_edit am);im_edit = am
end subroutine

public subroutine of_limpar ();dw_filtro.Reset()
dw_filtro.InsertRow(0)
filtro_codigo = ''
filtro_descricao = ''
dw_produto.Reset()
dw_produto.SetFilter('')
dw_produto.Filter()

end subroutine

public subroutine of_valida_incluir (boolean lb_itemchanged);Long ll_find
dw_produto.AcceptText()
ll_find = dw_produto.Find( " IsNull(pro_descricao) or pro_descricao = '' ", 1, dw_produto.RowCount() ) 
If ll_find > 0 Then	
	This.iw_pai.of_set_estado('VGL')
	This.im_edit.of_enable( is_estado )
Else
	If lb_itemchanged Then
		This.of_incluir( )
		ll_find = dw_produto.Find( " IsNull(pro_descricao) or pro_descricao = '' ", 1, dw_produto.RowCount() ) 
		dw_produto.SetItem(ll_find, 'flageditar', 'T')
		dw_produto.AcceptText()
		dw_produto.SetFocus()
		dw_produto.SetColumn( 'pro_descricao' )
		dw_produto.SetRow(ll_find)
	Else
		This.iw_pai.of_set_estado('VGIL')
		This.im_edit.of_enable( is_estado )		
	End If
End If

end subroutine

public subroutine of_incluir ();long ll_row, ll_codigo

dw_produto.SetReDraw(False)

ll_codigo = inv_dados.of_get_nextval( 'dba.pro_codigo')
If ll_codigo <= 0 Then
	Msg('Erro ao buscar contador')
	Return
Else
	ll_row = dw_produto.InsertRow(0)
	dw_produto.SetItem(ll_row, 'pro_codigo', ll_codigo )
	iw_pai.of_set_estado('VGL')
	im_edit.of_enable( is_estado )
End If

dw_produto.SetReDraw(True)

end subroutine

public subroutine of_gravar ();dw_produto.SetRedraw( False )

dw_produto.accepttext( )

If Not of_Validar() Then 	
	dw_produto.SetRedraw( True )
	Return
End If

If inv_dados.Update( { dw_produto } ) = 1 Then
	Msg("Gravado com Sucesso")
	This.of_limpar( )
Else
	Msg("Erro ao Gravar")
End If

dw_produto.SetRedraw( True )
end subroutine

public function boolean of_validar ();String ls_descricao 
Long ll_for, ll_for_codigo
Decimal lde_valor

For ll_for = 1 To dw_produto.RowCount()
	ls_descricao = Trim(uf_null(dw_produto.GetItemString( ll_for ,'pro_descricao'), ''))
	lde_valor = uf_null(dw_produto.GetItemNumber( ll_for ,'pro_valor'), 0)  
	ll_for_codigo = uf_null(dw_produto.GetItemNumber( ll_for ,'tb_fornecedor_for_codigo'), 0)
	If ls_descricao = '' Then
		Msg("Descri$$HEX2$$e700e300$$ENDHEX$$o obrigat$$HEX1$$f300$$ENDHEX$$ria")
		Return False
	End If
	If lde_valor<= 0 Then
		Msg("Pre$$HEX1$$e700$$ENDHEX$$o Invalido")
		Return False
	End If
	If ll_for_codigo = 0 Then
		Msg("Fornecedor Invalido")
		Return False
	End If
Next 

Return True
end function

public subroutine of_busca_fornecedor (long row, boolean ab_clicked);nv_pesquisa lnv_pesquisa

lnv_pesquisa = Create nv_pesquisa

lnv_pesquisa.of_buscar_pesquisa( row, ab_clicked, dw_produto, ids_fornecedor, { "tb_fornecedor_for_codigo" , "tb_fornecedor_for_descricao" , "dba.tb_fornecedor"})

Destroy( lnv_pesquisa )
end subroutine

on uo_cad_produto.create
int iCurrent
call super::create
this.dw_filtro=create dw_filtro
this.dw_produto=create dw_produto
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.gb_produto=create gb_produto
this.gb_filtro=create gb_filtro
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filtro
this.Control[iCurrent+2]=this.dw_produto
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.gb_produto
this.Control[iCurrent+6]=this.gb_filtro
end on

on uo_cad_produto.destroy
call super::destroy
destroy(this.dw_filtro)
destroy(this.dw_produto)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.gb_produto)
destroy(this.gb_filtro)
end on

event destructor;call super::destructor;Destroy(ids_fornecedor)
end event

type dw_filtro from u_dw within uo_cad_produto
integer x = 78
integer y = 92
integer width = 3936
integer height = 112
integer taborder = 10
string dataobject = "d_filtro_produto"
boolean border = false
end type

event editchanged;call super::editchanged;of_filter( row, dwo.name )



end event

type dw_produto from u_dw within uo_cad_produto
integer x = 78
integer y = 336
integer width = 4818
integer height = 1656
integer taborder = 20
string dataobject = "d_cad_produto"
end type

event clicked;call super::clicked;If Row > 0 Then 
	if dwo.name = 'b_excluir' Then 
		of_excluir_dw( row )
	Elseif dwo.name = 'b_editar' Then
		of_editar_dw( row )
	ElseIf dwo.name = 'b_fornecedor' Then
		If this.GetItemString(row, 'flageditar') = 'T' Then of_busca_fornecedor( row, true )
	End If
End If

end event

event itemchanged;call super::itemchanged;of_valida_incluir(False)

If dwo.name = 'tb_fornecedor_for_codigo' Then
	Post of_busca_fornecedor( row, false )
End If

end event

event rowfocuschanging;call super::rowfocuschanging;//String  ls_descricao
//Long ll_fornecedor_for_codigo, ll_quantidade
//Decimal lde_valor
//If currentrow = this.RowCount() Then
//	this.AcceptText()
//	ll_fornecedor_for_codigo = uf_null(this.getItemNumber(currentrow, 'tb_fornecedor_for_codigo') , 0)
//	lde_valor = uf_null(this.getItemNumber(currentrow, 'pro_valor'), 0)
//	ls_descricao = Trim(uf_Null(this.getItemString(currentrow, 'pro_descricao'), ''))
//	//ll_quantidade = this.getItemNumber(currentrow, 'pro_quantidade')
//	
//	If ls_descricao <> '' And lde_valor > 0 And ll_fornecedor_for_codigo > 0 Then
//		of_valida_incluir( True )
//	End If
//End If 
end event

type cb_ok from u_cb within uo_cad_produto
integer x = 4069
integer y = 92
integer taborder = 10
end type

event clicked;call super::clicked;of_retrieve()
end event

type cb_cancel from u_cb within uo_cad_produto
integer x = 4494
integer y = 92
integer taborder = 10
string text = "Cancelar"
end type

event clicked;call super::clicked;of_limpar()
end event

type gb_produto from u_gb within uo_cad_produto
integer x = 46
integer y = 256
integer width = 4905
integer height = 1900
integer taborder = 60
integer weight = 700
string text = "Produto"
end type

type gb_filtro from u_gb within uo_cad_produto
integer x = 46
integer y = 24
integer width = 4905
integer height = 216
integer taborder = 10
integer weight = 700
string text = "Filtro"
end type

