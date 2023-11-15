HA$PBExportHeader$w_cad_fornecedor.srw
forward
global type w_cad_fornecedor from w_ancestor
end type
type uo_cad from uo_cad_fornecedor within w_cad_fornecedor
end type
end forward

global type w_cad_fornecedor from w_ancestor
integer width = 3936
integer height = 2604
string title = "Fornecedor"
string menuname = ""
windowtype windowtype = main!
uo_cad uo_cad
end type
global w_cad_fornecedor w_cad_fornecedor

type variables
m_edit im_edit
end variables

forward prototypes
public subroutine of_set_estado (string as_estado)
end prototypes

public subroutine of_set_estado (string as_estado);is_estado = as_estado
uo_cad.of_set_estado( is_estado )
end subroutine

on w_cad_fornecedor.create
int iCurrent
call super::create
this.uo_cad=create uo_cad
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_cad
end on

on w_cad_fornecedor.destroy
call super::destroy
destroy(this.uo_cad)
end on

event activate;call super::activate;w_ancestor iw_this 

iw_this = This

If ParentWindow().Dynamic of_getwindowativa() = iw_this Then Return
	
ParentWindow().Dynamic of_set_window( this )
 
im_edit = ParentWindow().Dynamic of_get_menu()

If is_estado = '' Then of_set_estado( 'VIL' ) //'VEIL'
im_edit.of_enable( is_estado )

uo_cad.of_set_menu( Ref im_edit )

end event

event deactivate;call super::deactivate;w_ancestor lw_null

SetNull(lw_null)
//If Not ib_fechando Then ParentWindow().Dynamic of_set_window( lw_null )
end event

event ue_incluir;call super::ue_incluir;uo_cad.of_incluir()
end event

event ue_limpar;call super::ue_limpar;uo_cad.of_limpar()
end event

event ue_gravar;call super::ue_gravar;uo_cad.of_gravar()
end event

event ue_excluir;call super::ue_excluir;//uo_cad.of_excluir()
end event

type uo_cad from uo_cad_fornecedor within w_cad_fornecedor
integer width = 3698
integer taborder = 30
end type

on uo_cad.destroy
call uo_cad_fornecedor::destroy
end on

