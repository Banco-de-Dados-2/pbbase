HA$PBExportHeader$w_login.srw
forward
global type w_login from w_ancestor
end type
type em_usuario from u_em within w_login
end type
end forward

global type w_login from w_ancestor
integer width = 3067
integer height = 1684
string title = "Login"
em_usuario em_usuario
end type
global w_login w_login

on w_login.create
int iCurrent
call super::create
this.em_usuario=create em_usuario
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_usuario
end on

on w_login.destroy
call super::destroy
destroy(this.em_usuario)
end on

type em_usuario from u_em within w_login
integer x = 626
integer y = 564
integer width = 1106
integer height = 100
integer taborder = 10
maskdatatype maskdatatype = stringmask!
string displaydata = "Usuario~t/"
end type

