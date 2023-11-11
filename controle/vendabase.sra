HA$PBExportHeader$vendabase.sra
$PBExportComments$Generated Application Object
forward
global type vendabase from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
Boolean gb_desenv
end variables
global type vendabase from application
string appname = "vendabase"
end type
global vendabase vendabase

on vendabase.create
appname="vendabase"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on vendabase.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;Open(w_login)
end event

