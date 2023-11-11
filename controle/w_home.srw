HA$PBExportHeader$w_home.srw
forward
global type w_home from w_ancestor
end type
end forward

global type w_home from w_ancestor
integer width = 5902
integer height = 2488
string title = ""
windowtype windowtype = mdi!
windowstate windowstate = maximized!
boolean clientedge = true
end type
global w_home w_home

type variables
w_ancestor iw_ativa
end variables

forward prototypes
public function w_ancestor of_getwindowativa ()
public subroutine of_set_window (w_ancestor aw_window)
end prototypes

public function w_ancestor of_getwindowativa ();Return this.iw_ativa
end function

public subroutine of_set_window (w_ancestor aw_window);iw_ativa = aw_window
end subroutine

on w_home.create
call super::create
end on

on w_home.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;OpenSheet(w_frame, w_home, 0, Layered!)

end event

