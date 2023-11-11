HA$PBExportHeader$uo_pesquisa_funcionario.sru
forward
global type uo_pesquisa_funcionario from u_uo
end type
type dw_filtro from u_dw within uo_pesquisa_funcionario
end type
type dw_funcionario from u_dw within uo_pesquisa_funcionario
end type
type gb_func from u_gb within uo_pesquisa_funcionario
end type
type gb_filtros from u_gb within uo_pesquisa_funcionario
end type
end forward

global type uo_pesquisa_funcionario from u_uo
integer width = 3657
integer height = 2284
dw_filtro dw_filtro
dw_funcionario dw_funcionario
gb_func gb_func
gb_filtros gb_filtros
end type
global uo_pesquisa_funcionario uo_pesquisa_funcionario

forward prototypes
public subroutine of_inicializar ()
end prototypes

public subroutine of_inicializar ();w_ancestor lw_pai
lw_pai = GetParent().GetParent() 

dw_filtro.of_set_w_pai( lw_pai )
dw_filtro.of_set_color_background( )
dw_filtro.InsertRow(0)
end subroutine

event dragdrop;call super::dragdrop;//
end event

on uo_pesquisa_funcionario.create
int iCurrent
call super::create
this.dw_filtro=create dw_filtro
this.dw_funcionario=create dw_funcionario
this.gb_func=create gb_func
this.gb_filtros=create gb_filtros
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filtro
this.Control[iCurrent+2]=this.dw_funcionario
this.Control[iCurrent+3]=this.gb_func
this.Control[iCurrent+4]=this.gb_filtros
end on

on uo_pesquisa_funcionario.destroy
call super::destroy
destroy(this.dw_filtro)
destroy(this.dw_funcionario)
destroy(this.gb_func)
destroy(this.gb_filtros)
end on

type dw_filtro from u_dw within uo_pesquisa_funcionario
integer x = 64
integer y = 60
integer width = 3474
integer height = 228
integer taborder = 10
string dataobject = "d_filtro_funcionario"
boolean border = false
end type

type dw_funcionario from u_dw within uo_pesquisa_funcionario
integer x = 27
integer y = 416
integer width = 3557
integer height = 1784
integer taborder = 40
string dataobject = "d_pesquisa_funcionario"
end type

type gb_func from u_gb within uo_pesquisa_funcionario
integer y = 344
integer width = 3621
integer height = 1896
integer weight = 700
string text = "Funcionarios"
end type

type gb_filtros from u_gb within uo_pesquisa_funcionario
integer width = 3621
integer height = 316
integer weight = 700
string text = "Filtros"
end type

