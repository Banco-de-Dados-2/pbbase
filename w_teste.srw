HA$PBExportHeader$w_teste.srw
forward
global type w_teste from w_ancestor
end type
end forward

global type w_teste from w_ancestor
integer width = 2551
integer height = 1632
string menuname = ""
boolean resizable = true
windowtype windowtype = main!
end type
global w_teste w_teste

event open;call super::open;//
end event

on w_teste.create
call super::create
end on

on w_teste.destroy
call super::destroy
end on

