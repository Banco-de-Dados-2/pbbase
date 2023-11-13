HA$PBExportHeader$w_venda.srw
forward
global type w_venda from w_ancestor
end type
type tab_vendas from tab within w_venda
end type
type tabpage_emitir from uo_emitir_venda within tab_vendas
end type
type tabpage_emitir from uo_emitir_venda within tab_vendas
end type
type tab_vendas from tab within w_venda
tabpage_emitir tabpage_emitir
end type
end forward

global type w_venda from w_ancestor
integer width = 4480
integer height = 2488
string title = "Vendas"
string menuname = ""
windowtype windowtype = main!
tab_vendas tab_vendas
end type
global w_venda w_venda

type variables
m_edit im_edit
end variables

forward prototypes
public subroutine of_set_estado (string as_estado)
end prototypes

public subroutine of_set_estado (string as_estado);is_estado = as_estado
tab_vendas.tabpage_emitir.of_set_estado( as_estado )
end subroutine

on w_venda.create
int iCurrent
call super::create
this.tab_vendas=create tab_vendas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_vendas
end on

on w_venda.destroy
call super::destroy
destroy(this.tab_vendas)
end on

event activate;call super::activate;w_ancestor iw_this 

iw_this = This

If ParentWindow().Dynamic of_getwindowativa() = iw_this Then Return
	
ParentWindow().Dynamic of_set_window( this )
 
im_edit = ParentWindow().Dynamic of_get_menu()

If is_estado = '' Then of_set_estado( 'VIL' )
im_edit.of_enable( is_estado )

tab_vendas.tabpage_emitir.of_set_menu( Ref im_edit )

end event

event deactivate;call super::deactivate;w_ancestor lw_null

SetNull(lw_null)
//If Not ib_fechando Then ParentWindow().Dynamic of_set_window( lw_null )
end event

event ue_incluir;call super::ue_incluir;If tab_vendas.Selectedtab = 1 Then
	tab_vendas.tabpage_emitir.of_incluir( )
End If
end event

event ue_limpar;call super::ue_limpar;If tab_vendas.Selectedtab = 1 Then
	tab_vendas.tabpage_emitir.of_limpar( )
End If
end event

event ue_gravar;call super::ue_gravar;If tab_vendas.Selectedtab = 1 Then
	tab_vendas.tabpage_emitir.of_gravar( )
End If
end event

event ue_excluir;call super::ue_excluir;If tab_vendas.Selectedtab = 1 Then
	tab_vendas.tabpage_emitir.of_excluir( )
End If
end event

type tab_vendas from tab within w_venda
integer width = 4379
integer height = 2324
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_emitir tabpage_emitir
end type

on tab_vendas.create
this.tabpage_emitir=create tabpage_emitir
this.Control[]={this.tabpage_emitir}
end on

on tab_vendas.destroy
destroy(this.tabpage_emitir)
end on

type tabpage_emitir from uo_emitir_venda within tab_vendas
integer x = 18
integer y = 112
integer width = 4343
integer height = 2196
string text = "Emitir"
end type

