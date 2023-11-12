HA$PBExportHeader$nv_ancobject.sru
forward
global type nv_ancobject from nonvisualobject
end type
end forward

global type nv_ancobject from nonvisualobject
end type
global nv_ancobject nv_ancobject

on nv_ancobject.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_ancobject.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

