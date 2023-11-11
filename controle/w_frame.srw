HA$PBExportHeader$w_frame.srw
forward
global type w_frame from w_ancestor
end type
type uo_hom from uo_home within w_frame
end type
end forward

global type w_frame from w_ancestor
integer width = 3982
integer height = 1496
boolean titlebar = false
string title = ""
string menuname = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean border = false
windowtype windowtype = popup!
windowstate windowstate = maximized!
uo_hom uo_hom
end type
global w_frame w_frame

type variables
w_ancestor iw_pai
end variables
on w_frame.create
int iCurrent
call super::create
this.uo_hom=create uo_hom
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_hom
end on

on w_frame.destroy
call super::destroy
destroy(this.uo_hom)
end on

event post_open;call super::post_open;iw_pai = This.ParentWindow()
uo_hom.of_set_iw_pai( iw_pai )

Return 1
end event

type uo_hom from uo_home within w_frame
integer x = 434
integer y = 208
integer width = 3319
integer height = 1052
integer taborder = 20
end type

on uo_hom.destroy
call uo_home::destroy
end on

