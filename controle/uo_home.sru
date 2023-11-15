HA$PBExportHeader$uo_home.sru
forward
global type uo_home from u_uo
end type
type pb_vendas from picturebutton within uo_home
end type
type pb_produtos from picturebutton within uo_home
end type
type pb_fornecedor from picturebutton within uo_home
end type
type pb_funcionario from picturebutton within uo_home
end type
end forward

global type uo_home from u_uo
integer width = 4500
integer height = 2300
pb_vendas pb_vendas
pb_produtos pb_produtos
pb_fornecedor pb_fornecedor
pb_funcionario pb_funcionario
end type
global uo_home uo_home

type variables
w_ancestor iw_pai, iw_cad_usuario, iw_cad_fornecedor, iw_cad_produto, iw_venda
//w_cad_usuario iw_cad_usuario
end variables

forward prototypes
public subroutine of_set_iw_pai (w_ancestor aw_pai)
public subroutine of_abrir_funcionario ()
public subroutine of_abrir_fornecedor ()
public subroutine of_abrir_produto ()
public subroutine of_abrir_venda ()
end prototypes

public subroutine of_set_iw_pai (w_ancestor aw_pai);iw_pai = aw_pai
end subroutine

public subroutine of_abrir_funcionario ();If Not IsValid(iw_cad_usuario) Then 
	OpenSheet( iw_cad_usuario, 'w_cad_usuario', iw_pai, 0 , Original!)
Else
	iw_cad_usuario.setfocus( )
End If



end subroutine

public subroutine of_abrir_fornecedor ();If Not IsValid(iw_cad_fornecedor) Then 
	OpenSheet( iw_cad_fornecedor, 'w_cad_fornecedor', iw_pai, 0 , Original!)
Else
	iw_cad_fornecedor.setfocus( )
End If



end subroutine

public subroutine of_abrir_produto ();If Not IsValid(iw_cad_produto) Then 
	OpenSheet( iw_cad_produto, 'w_cad_produto', iw_pai, 0 , Original!)
Else
	iw_cad_produto.setfocus( )
End If



end subroutine

public subroutine of_abrir_venda ();If Not IsValid(iw_venda) Then 
	OpenSheet( iw_venda, 'w_venda', iw_pai, 0 , Original!)
Else
	iw_venda.setfocus( )
End If



end subroutine

event constructor;call super::constructor;//
end event

on uo_home.create
int iCurrent
call super::create
this.pb_vendas=create pb_vendas
this.pb_produtos=create pb_produtos
this.pb_fornecedor=create pb_fornecedor
this.pb_funcionario=create pb_funcionario
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_vendas
this.Control[iCurrent+2]=this.pb_produtos
this.Control[iCurrent+3]=this.pb_fornecedor
this.Control[iCurrent+4]=this.pb_funcionario
end on

on uo_home.destroy
call super::destroy
destroy(this.pb_vendas)
destroy(this.pb_produtos)
destroy(this.pb_fornecedor)
destroy(this.pb_funcionario)
end on

type pb_vendas from picturebutton within uo_home
integer x = 3310
integer y = 60
integer width = 960
integer height = 528
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Vendas"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;of_abrir_venda()
end event

type pb_produtos from picturebutton within uo_home
integer x = 2226
integer y = 60
integer width = 960
integer height = 528
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Produtos"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;of_abrir_produto()
end event

type pb_fornecedor from picturebutton within uo_home
integer x = 1143
integer y = 60
integer width = 960
integer height = 528
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Fornecedor"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;of_abrir_fornecedor()
end event

type pb_funcionario from picturebutton within uo_home
integer x = 59
integer y = 60
integer width = 960
integer height = 528
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Funcionario"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;of_abrir_funcionario()
end event

