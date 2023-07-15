library hellovst3delphi;

uses
  Vcl.Forms, VST3Intf, HelloPlug;

{$R *.res}

var
  gFactory:THelloFactory;

function GetPluginFactory:IPluginFactory unsafe;stdcall;
begin
  if gFactory=nil then
    gFactory:=THelloFactory.Create
  else
    gFactory._AddRef;
  Result:=gFactory;
end;

function InitDll:Boolean;stdcall;
begin
  Result:=True;
end;

function ExitDll:Boolean;stdcall;
begin
  Result:=True;
end;

exports
  GetPluginFactory, InitDll, ExitDll;

begin
  Application.Initialize;
end.
