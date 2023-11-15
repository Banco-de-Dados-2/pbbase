HA$PBExportHeader$uo_pesquisa_venda.sru
forward
global type uo_pesquisa_venda from u_uo
end type
end forward

global type uo_pesquisa_venda from u_uo
integer width = 4677
integer height = 1972
end type
global uo_pesquisa_venda uo_pesquisa_venda

on uo_pesquisa_venda.create
call super::create
end on

on uo_pesquisa_venda.destroy
call super::destroy
end on

