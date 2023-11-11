HA$PBExportHeader$uo_pesquisa_funcionario.sru
forward
global type uo_pesquisa_funcionario from u_uo
end type
type em_codigo from u_em within uo_pesquisa_funcionario
end type
type ddlb_funcao from u_lb within uo_pesquisa_funcionario
end type
type em_nome from u_em within uo_pesquisa_funcionario
end type
type st_funcao from u_st within uo_pesquisa_funcionario
end type
type st_nome from u_st within uo_pesquisa_funcionario
end type
type st_codigo from u_st within uo_pesquisa_funcionario
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
em_codigo em_codigo
ddlb_funcao ddlb_funcao
em_nome em_nome
st_funcao st_funcao
st_nome st_nome
st_codigo st_codigo
dw_funcionario dw_funcionario
gb_func gb_func
gb_filtros gb_filtros
end type
global uo_pesquisa_funcionario uo_pesquisa_funcionario

event dragdrop;call super::dragdrop;//
end event

on uo_pesquisa_funcionario.create
int iCurrent
call super::create
this.em_codigo=create em_codigo
this.ddlb_funcao=create ddlb_funcao
this.em_nome=create em_nome
this.st_funcao=create st_funcao
this.st_nome=create st_nome
this.st_codigo=create st_codigo
this.dw_funcionario=create dw_funcionario
this.gb_func=create gb_func
this.gb_filtros=create gb_filtros
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_codigo
this.Control[iCurrent+2]=this.ddlb_funcao
this.Control[iCurrent+3]=this.em_nome
this.Control[iCurrent+4]=this.st_funcao
this.Control[iCurrent+5]=this.st_nome
this.Control[iCurrent+6]=this.st_codigo
this.Control[iCurrent+7]=this.dw_funcionario
this.Control[iCurrent+8]=this.gb_func
this.Control[iCurrent+9]=this.gb_filtros
end on

on uo_pesquisa_funcionario.destroy
call super::destroy
destroy(this.em_codigo)
destroy(this.ddlb_funcao)
destroy(this.em_nome)
destroy(this.st_funcao)
destroy(this.st_nome)
destroy(this.st_codigo)
destroy(this.dw_funcionario)
destroy(this.gb_func)
destroy(this.gb_filtros)
end on

type em_codigo from u_em within uo_pesquisa_funcionario
integer x = 279
integer y = 60
integer width = 434
integer taborder = 10
string text = ""
string mask = "#########"
end type

event getfocus;call super::getfocus;//
this.text = ''
end event

type ddlb_funcao from u_lb within uo_pesquisa_funcionario
integer x = 2656
integer y = 72
integer width = 896
integer taborder = 30
string item[] = {"Vendedor","Gerente","Diretor","Estoquista"}
end type

type em_nome from u_em within uo_pesquisa_funcionario
integer x = 937
integer y = 60
integer width = 1458
integer taborder = 20
string text = ""
maskdatatype maskdatatype = stringmask!
end type

type st_funcao from u_st within uo_pesquisa_funcionario
integer x = 2409
integer y = 84
integer width = 233
integer weight = 700
string text = "Fun$$HEX2$$e700e300$$ENDHEX$$o"
alignment alignment = right!
end type

type st_nome from u_st within uo_pesquisa_funcionario
integer x = 690
integer y = 84
integer width = 233
integer weight = 700
string text = "Nome"
alignment alignment = right!
end type

type st_codigo from u_st within uo_pesquisa_funcionario
integer x = 50
integer y = 84
integer width = 233
integer weight = 700
string text = "C$$HEX1$$f300$$ENDHEX$$digo"
end type

type dw_funcionario from u_dw within uo_pesquisa_funcionario
integer x = 27
integer y = 296
integer width = 3557
integer height = 1908
integer taborder = 40
string dataobject = "d_pesquisa_funcionario"
end type

type gb_func from u_gb within uo_pesquisa_funcionario
integer y = 224
integer width = 3621
integer height = 2020
integer weight = 700
string text = "Funcionarios"
end type

type gb_filtros from u_gb within uo_pesquisa_funcionario
integer width = 3621
integer height = 204
integer weight = 700
string text = "Filtros"
end type

