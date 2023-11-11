HA$PBExportHeader$u_tab.sru
forward
global type u_tab from tab
end type
type tabpage_1 from userobject within u_tab
end type
type tabpage_1 from userobject within u_tab
end type
end forward

global type u_tab from tab
string tag = "u_tab"
integer width = 3675
integer height = 1876
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean fixedwidth = true
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean powertips = true
boolean boldselectedtext = true
boolean pictureonright = true
boolean createondemand = true
tabpage_1 tabpage_1
end type
global u_tab u_tab

on u_tab.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on u_tab.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within u_tab
integer x = 18
integer y = 112
integer width = 3639
integer height = 1748
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

