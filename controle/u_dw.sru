HA$PBExportHeader$u_dw.sru
forward
global type u_dw from datawindow
end type
end forward

global type u_dw from datawindow
integer width = 1696
integer height = 848
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type
global u_dw u_dw

type variables
w_ancestor iw_pai
end variables
forward prototypes
public subroutine of_set_color_background ()
end prototypes

public subroutine of_set_color_background ();//
this.Modify("DataWindow.Color='"+ String(iw_pai.BackColor) +"'")
end subroutine

on u_dw.create
end on

on u_dw.destroy
end on

event constructor;iw_pai = this.GetParent()
end event

