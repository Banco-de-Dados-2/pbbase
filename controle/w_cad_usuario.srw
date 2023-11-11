HA$PBExportHeader$w_cad_usuario.srw
forward
global type w_cad_usuario from w_ancestor
end type
end forward

global type w_cad_usuario from w_ancestor
string title = "Cadastro de Funcionario"
end type
global w_cad_usuario w_cad_usuario

on w_cad_usuario.create
call super::create
end on

on w_cad_usuario.destroy
call super::destroy
end on

