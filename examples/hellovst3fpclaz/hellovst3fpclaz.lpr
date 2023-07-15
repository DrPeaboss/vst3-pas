library hellovst3fpclaz;

{$Interfaces CORBA} // Every file needed
{$mode objfpc}{$H+}

uses
  Forms, Interfaces, VST3Intf, HelloPlug, HelloForm;

var
  gFactory:THelloFactory;

function GetPluginFactory:IPluginFactory;winapi;
begin
  if gFactory=nil then
    gFactory:=THelloFactory.Create
  else
    gFactory._AddRef;
  Result:=gFactory;
end;

function InitDll:Boolean;winapi; // optional
begin
  Result:=True;
end;

function ExitDll:Boolean;winapi; // optional
begin
  Result:=True;
end;

exports
  InitDll, ExitDll, GetPluginFactory;

begin
  Application.Initialize;
end.

