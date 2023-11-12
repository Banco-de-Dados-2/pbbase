HA$PBExportHeader$nv_object.sru
forward
global type nv_object from nonvisualobject
end type
end forward

global type nv_object from nonvisualobject
end type
global nv_object nv_object

on nv_object.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_object.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

