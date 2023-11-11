HA$PBExportHeader$uo_home.sru
forward
global type uo_home from u_uo
end type
type pb_funcionario from picturebutton within uo_home
end type
end forward

global type uo_home from u_uo
integer width = 4201
integer height = 1884
pb_funcionario pb_funcionario
end type
global uo_home uo_home

type variables
window iw_pai, iw_cad_usuario
//w_cad_usuario iw_cad_usuario
end variables
forward prototypes
public subroutine of_set_iw_pai (w_ancestor aw_pai)
public subroutine of_abrir_funcionario ()
end prototypes

public subroutine of_set_iw_pai (w_ancestor aw_pai);iw_pai = aw_pai
end subroutine

public subroutine of_abrir_funcionario ();OpenSheet( iw_cad_usuario, 'w_cad_usuario', iw_pai, 0 , Original!)


end subroutine

event constructor;call super::constructor;//
end event

on uo_home.create
int iCurrent
call super::create
this.pb_funcionario=create pb_funcionario
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_funcionario
end on

on uo_home.destroy
call super::destroy
destroy(this.pb_funcionario)
end on

type pb_funcionario from picturebutton within uo_home
integer x = 59
integer y = 60
integer width = 402
integer height = 224
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

