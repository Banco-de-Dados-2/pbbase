HA$PBExportHeader$uo_cad_funcionario.sru
forward
global type uo_cad_funcionario from u_uo
end type
type dw_cad_funcionario from u_dw within uo_cad_funcionario
end type
end forward

global type uo_cad_funcionario from u_uo
integer width = 3657
integer height = 2284
dw_cad_funcionario dw_cad_funcionario
end type
global uo_cad_funcionario uo_cad_funcionario

forward prototypes
public subroutine of_inicializar ()
end prototypes

public subroutine of_inicializar ();dw_cad_funcionario.of_set_color_background( )

dw_cad_funcionario.SetTransObject(SQLCA)
dw_cad_funcionario.InsertRow(0)
end subroutine

event constructor;call super::constructor;//

end event

on uo_cad_funcionario.create
int iCurrent
call super::create
this.dw_cad_funcionario=create dw_cad_funcionario
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cad_funcionario
end on

on uo_cad_funcionario.destroy
call super::destroy
destroy(this.dw_cad_funcionario)
end on

type dw_cad_funcionario from u_dw within uo_cad_funcionario
integer x = 169
integer y = 52
integer width = 3314
integer height = 860
integer taborder = 10
string dataobject = "d_cad_funcionario"
boolean border = false
end type

