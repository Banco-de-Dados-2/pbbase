HA$PBExportHeader$uo_cad_fornecedor.sru
forward
global type uo_cad_fornecedor from u_uo
end type
type cb_cancel from u_cb within uo_cad_fornecedor
end type
type cb_ok from u_cb within uo_cad_fornecedor
end type
type dw_fornecedor from u_dw within uo_cad_fornecedor
end type
type dw_filtro from u_dw within uo_cad_fornecedor
end type
type gb_fornecedor from u_gb within uo_cad_fornecedor
end type
type gb_filtro from u_gb within uo_cad_fornecedor
end type
end forward

global type uo_cad_fornecedor from u_uo
integer width = 3698
integer height = 2300
cb_cancel cb_cancel
cb_ok cb_ok
dw_fornecedor dw_fornecedor
dw_filtro dw_filtro
gb_fornecedor gb_fornecedor
gb_filtro gb_filtro
end type
global uo_cad_fornecedor uo_cad_fornecedor

type variables
String filtro_codigo , filtro_descricao 
nv_dados inv_dados
w_cad_usuario iw_pai
Boolean lb_alterando = False, lb_inserindo = False

KeyCode IKey
end variables

forward prototypes
public subroutine of_inicializar ()
public subroutine of_retrieve ()
public subroutine of_set_menu (m_edit am)
public subroutine of_incluir ()
public subroutine of_excluir_dw (long row)
public subroutine of_editar_dw (long row)
public subroutine of_valida_incluir (boolean lb_itemchanged)
public subroutine of_set_key (keycode key)
public subroutine of_limpar ()
public subroutine of_filter (long row, string name)
public subroutine of_gravar ()
public function boolean of_validar ()
end prototypes

public subroutine of_inicializar ();iw_pai = GetParent() 

dw_fornecedor.SetReDraw(false)
dw_filtro.SetReDraw(false)
inv_dados = Create nv_dados

dw_filtro.of_set_w_pai( iw_pai )
dw_filtro.of_set_color_background( )
dw_filtro.InsertRow(0)

dw_fornecedor.SetTransObject(SQLCA)
dw_fornecedor.retrieve( filtro_codigo , filtro_descricao )

dw_fornecedor.SetReDraw(True)
dw_filtro.SetReDraw(True)
end subroutine

public subroutine of_retrieve ();dw_fornecedor.Reset()
dw_fornecedor.SetFilter('')
dw_fornecedor.Filter()
dw_fornecedor.Retrieve( filtro_codigo , filtro_descricao )
iw_pai.of_set_estado('VGIL')
im_edit.of_enable( is_estado )
end subroutine

public subroutine of_set_menu (m_edit am);im_edit = am
end subroutine

public subroutine of_incluir ();long ll_row, ll_codigo

dw_fornecedor.SetReDraw(False)

ll_codigo = inv_dados.of_get_nextval( 'dba.for_codigo')
If ll_codigo <= 0 Then
	Msg('Erro ao buscar contador')
	Return
Else
	ll_row = dw_fornecedor.InsertRow(0)
	dw_fornecedor.SetItem(ll_row, 'for_codigo', ll_codigo )
	iw_pai.of_set_estado('VGL')
	im_edit.of_enable( is_estado )
End If

dw_fornecedor.SetReDraw(True)

end subroutine

public subroutine of_excluir_dw (long row);Long ll_find
dw_fornecedor.deleteRow(row)
ll_find = dw_fornecedor.Find( " IsNull(for_descricao) or for_descricao = '' ", 1, dw_fornecedor.RowCount() ) 
If ll_find > 0 Then	
	iw_pai.of_set_estado('VGL')
	im_edit.of_enable( is_estado )
	dw_fornecedor.SetFocus()
	dw_fornecedor.SetRow( ll_find )
Else
	iw_pai.of_set_estado('VGIL')
	im_edit.of_enable( is_estado )
End If
end subroutine

public subroutine of_editar_dw (long row);If  dw_fornecedor.GetItemString( row, 'flageditar') = 'F' Then
	dw_fornecedor.AcceptText()
	dw_fornecedor.SetItem( row, 'flageditar', 'T')
	If Not dw_fornecedor.of_lock_table( 'for_codigo' , dw_fornecedor.GetItemNumber(row, 'for_codigo') ) Then
		dw_fornecedor.SetItem( row, 'flageditar', 'F')		
	End If
	dw_fornecedor.AcceptText()
Else
	dw_fornecedor.AcceptText()
	dw_fornecedor.SetItem( row, 'flageditar', 'F')
	dw_fornecedor.SetSort('for_codigo asc')
	dw_fornecedor.Sort()
End If




end subroutine

public subroutine of_valida_incluir (boolean lb_itemchanged);Long ll_find
dw_fornecedor.AcceptText()
ll_find = dw_fornecedor.Find( " IsNull(for_descricao) or for_descricao = '' ", 1, dw_fornecedor.RowCount() ) 
If ll_find > 0 Then	
	This.iw_pai.of_set_estado('VGL')
	This.im_edit.of_enable( is_estado )
Else
	If lb_itemchanged Then
		This.of_incluir( )
		ll_find = dw_fornecedor.Find( " IsNull(for_descricao) or for_descricao = '' ", 1, dw_fornecedor.RowCount() ) 
		dw_fornecedor.SetItem(ll_find, 'flageditar', 'T')
		dw_fornecedor.AcceptText()
		dw_fornecedor.SetFocus()
		dw_fornecedor.SetColumn( 'for_descricao' )
		dw_fornecedor.SetRow(ll_find)
	Else
		This.iw_pai.of_set_estado('VGIL')
		This.im_edit.of_enable( is_estado )		
	End If
End If

end subroutine

public subroutine of_set_key (keycode key);IKey = key
end subroutine

public subroutine of_limpar ();dw_filtro.Reset()
dw_filtro.InsertRow(0)
filtro_codigo = ''
filtro_descricao = ''
dw_fornecedor.Reset()
dw_fornecedor.SetFilter('')
dw_fornecedor.Filter()

end subroutine

public subroutine of_filter (long row, string name);String ls_filter, data

dw_filtro.AcceptText()

Choose Case name
	Case 'for_descricao'	
		data = Trim(uf_null(dw_filtro.GetItemString(1, name ), ''))
		filtro_descricao = data
	Case 'for_codigo'	
		data = uf_null(String(dw_filtro.GetItemNumber(1, name )),'')
		If data = '0' then data = ''
		filtro_codigo = data
End Choose

If Len(filtro_codigo) > 0 Then &
	ls_filter += "If( Pos(String(for_codigo), '" + filtro_codigo + "') > 0 , 1,0) = 1 and "	
If Len(filtro_descricao) > 0 Then &
	ls_filter += "If( Pos(String(for_descricao), '" + filtro_descricao + "') > 0 , 1,0) = 1 and "	

ls_filter = Left(ls_filter, Len(ls_filter) - 5)

dw_fornecedor.setFilter( ls_filter )	
dw_fornecedor.Filter()
	
	
end subroutine

public subroutine of_gravar ();dw_fornecedor.SetRedraw( False )

dw_fornecedor.accepttext( )

If Not of_Validar() Then 
	dw_fornecedor.SetRedraw( True )
	Return
End If

If inv_dados.Update( { dw_fornecedor} ) = 1 Then
	Msg("Gravado com Sucesso")
	This.of_limpar( )
Else
	Msg("Erro ao Gravar")
End If

dw_fornecedor.SetRedraw( True )
end subroutine

public function boolean of_validar ();String ls_descricao 
Long ll_for

For ll_for = 1 To dw_fornecedor.RowCount()
	ls_descricao = Trim(uf_null(dw_fornecedor.GetItemString( ll_for ,'for_descricao'), ''))
	If ls_descricao = '' Then
		Msg("Descri$$HEX2$$e700e300$$ENDHEX$$o obrigat$$HEX1$$f300$$ENDHEX$$ria")
		Return False
	End If
Next 

Return True
end function

on uo_cad_fornecedor.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_fornecedor=create dw_fornecedor
this.dw_filtro=create dw_filtro
this.gb_fornecedor=create gb_fornecedor
this.gb_filtro=create gb_filtro
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_fornecedor
this.Control[iCurrent+4]=this.dw_filtro
this.Control[iCurrent+5]=this.gb_fornecedor
this.Control[iCurrent+6]=this.gb_filtro
end on

on uo_cad_fornecedor.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_fornecedor)
destroy(this.dw_filtro)
destroy(this.gb_fornecedor)
destroy(this.gb_filtro)
end on

type cb_cancel from u_cb within uo_cad_fornecedor
integer x = 3141
integer y = 92
integer taborder = 20
string text = "Cancelar"
end type

event clicked;call super::clicked;of_limpar()
end event

type cb_ok from u_cb within uo_cad_fornecedor
integer x = 2725
integer y = 92
integer taborder = 20
end type

event clicked;call super::clicked;of_retrieve()
end event

type dw_fornecedor from u_dw within uo_cad_fornecedor
integer x = 78
integer y = 336
integer width = 3465
integer height = 1656
integer taborder = 40
string dataobject = "d_cad_fornecedor"
end type

event clicked;call super::clicked;if dwo.name = 'b_excluir' Then 
	If Row > 0 Then of_excluir_dw( row )
Elseif dwo.name = 'b_editar' Then
	If Row > 0 Then of_editar_dw( row )
End If

end event

event itemchanged;call super::itemchanged;of_editar_dw(row)
of_valida_incluir(False)


end event

event ue_key;call super::ue_key;If key = KeyTab! or key = KeyEnter!  Then
	of_valida_incluir(True)
End If
end event

type dw_filtro from u_dw within uo_cad_fornecedor
integer x = 78
integer y = 92
integer width = 2624
integer height = 112
integer taborder = 10
string dataobject = "d_filtro_fornecedor"
boolean border = false
end type

event editchanged;call super::editchanged;of_filter( row, dwo.name )



end event

type gb_fornecedor from u_gb within uo_cad_fornecedor
integer x = 46
integer y = 256
integer width = 3552
integer height = 1900
integer taborder = 50
integer weight = 700
string text = "Fornecedor"
end type

type gb_filtro from u_gb within uo_cad_fornecedor
integer x = 46
integer y = 24
integer width = 3552
integer height = 216
integer taborder = 30
integer weight = 700
string text = "Filtro"
end type

