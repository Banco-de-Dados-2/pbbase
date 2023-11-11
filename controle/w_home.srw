HA$PBExportHeader$w_home.srw
forward
global type w_home from w_ancestor
end type
type uo_hom from uo_home within w_home
end type
end forward

global type w_home from w_ancestor
integer width = 5883
integer height = 2472
string title = "Home"
windowtype windowtype = mdi!
windowstate windowstate = maximized!
uo_hom uo_hom
end type
global w_home w_home

type variables

end variables

on w_home.create
int iCurrent
call super::create
this.uo_hom=create uo_hom
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_hom
end on

on w_home.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_hom)
end on

event post_open;call super::post_open;uo_hom.of_set_iw_pai( this )

Return 1
end event

type uo_hom from uo_home within w_home
integer width = 5824
integer height = 2260
integer taborder = 20
end type

on uo_hom.destroy
call uo_home::destroy
end on

