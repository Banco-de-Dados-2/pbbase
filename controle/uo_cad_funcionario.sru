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
public subroutine of_incluir ()
end prototypes

public subroutine of_inicializar ();w_ancestor lw_pai

lw_pai = GetParent().GetParent()

dw_cad_funcionario.of_set_w_pai( lw_pai )
dw_cad_funcionario.of_set_color_background( )

dw_cad_funcionario.SetTransObject(SQLCA)
dw_cad_funcionario.InsertRow(0)
dw_cad_funcionario.of_bloq_campo( {"senhae", "fun_nome", "fun_funcao", "fun_senha", "fun_cpf"}, true )

end subroutine

public subroutine of_incluir ();dw_cad_funcionario.Reset()
dw_cad_funcionario.InsertRow(0)
dw_cad_funcionario.of_bloq_campo( {"fun_codigo"}, true)
dw_cad_funcionario.of_bloq_campo( {"senhae", "fun_nome", "fun_funcao", "fun_senha", "fun_cpf"}, false)
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

