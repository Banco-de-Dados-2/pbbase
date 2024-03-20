HA$PBExportHeader$uo_pesquisa_generica.sru
forward
global type uo_pesquisa_generica from u_uo
end type
type sle_pesquisa from u_sle within uo_pesquisa_generica
end type
end forward

global type uo_pesquisa_generica from u_uo
integer width = 3355
integer height = 1528
sle_pesquisa sle_pesquisa
end type
global uo_pesquisa_generica uo_pesquisa_generica

on uo_pesquisa_generica.create
int iCurrent
call super::create
this.sle_pesquisa=create sle_pesquisa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_pesquisa
end on

on uo_pesquisa_generica.destroy
call super::destroy
destroy(this.sle_pesquisa)
end on

type sle_pesquisa from u_sle within uo_pesquisa_generica
integer x = 59
integer y = 56
integer width = 1362
integer taborder = 10
end type

