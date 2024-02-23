unit HelloForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  VST3Intf, PlugBase, HelloPlug;

type
  THelloPlugView = class;

  TForm1 = class(TForm)
    LabelGain: TLabel;
    TrackBarGain: TTrackBar;
    ButtonReset: TButton;
    procedure TrackBarGainChange(Sender: TObject);
    procedure ButtonResetClick(Sender: TObject);
  private
    FAutomating:Boolean;
    FTimer:TTimer;
    FCount:Integer;
    procedure OnTimer(Sender: TObject);
    function GetAmpValue:Double;
  public
    PlugView:THelloPlugView;
    ComponentHandler:IComponentHandler; // To perform parameter changes
    procedure Init; // Use this one instead of FormCreate
    procedure AutomateTrackBar(AmpValue:Double);
  end;

  { THelloPlugView }

  THelloPlugView = class(TVObject, IPlugView, IUpdateGUI)
  private
    FForm:TForm1;
    FFrame:IPlugFrame;
    FController:THelloController;
  public
    constructor Create(AController:THelloController);
    destructor Destroy; override;
    function IsPlatformTypeSupported(Typ:FIDString):tresult; winapi;
    function Attached(Parent:Pointer; Typ:FIDString):tresult; winapi;
    function Removed:tresult; winapi;
    function OnWheel(Distance:Single):tresult; winapi;
    function OnKeyDown(key:Char16; KeyCode,Modifiers:Int16):tresult; winapi;
    function OnKeyUp(key:Char16; KeyCode,Modifiers:Int16):tresult; winapi;
    function GetSize(size:PViewRect):tresult; winapi;
    function OnSize(NewSize:PViewRect):tresult; winapi;
    function OnFocus(state:TBool):tresult; winapi;
    function SetFrame(frame:IPlugFrame):tresult; winapi;
    function CanResize:tresult; winapi;
    function CheckSizeConstraint(rect:PViewRect):tresult; winapi;
    procedure UpdateGUI(id:TParamID; value:TParamValue);
    property Controller:THelloController read FController;
  end;

implementation

{$R *.dfm}

constructor THelloPlugView.Create(AController:THelloController);
begin
  FController:=AController;
  FForm:=TForm1.Create(nil);
  FForm.PlugView:=Self;
  FForm.ComponentHandler:=AController.ComponentHandler;
  FForm.Init;
end;

destructor THelloPlugView.Destroy;
begin
  FForm.Free;
  inherited Destroy;
end;

function THelloPlugView.IsPlatformTypeSupported(Typ:FIDString):tresult; winapi;
begin
  if Typ=kPlatformTypeHWND then
    Result:=kResultOk
  else
    Result:=kResultFalse;
end;

function THelloPlugView.Attached(Parent:Pointer; Typ:FIDString):tresult; winapi;
begin
  Result:=kResultFalse;
  if Typ=kPlatformTypeHWND then
  begin
    FForm.ParentWindow:=PtrUInt(Parent);
    FForm.Show;
    Result:=kResultOk;
  end;
end;

function THelloPlugView.Removed:tresult; winapi;
begin
  FForm.Hide;
  FForm.ParentWindow:=0;
  Result:=kResultOk;
end;

function THelloPlugView.OnWheel(Distance:Single):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function THelloPlugView.OnKeyDown(key:Char16; KeyCode,Modifiers:Int16):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function THelloPlugView.OnKeyUp(key:Char16; KeyCode,Modifiers:Int16):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function THelloPlugView.GetSize(size:PViewRect):tresult; winapi;
begin
  if size=nil then
    Exit(kInvalidArgument);
  size^.Create(FForm.Width,FForm.Height);
  Result:=kResultOk;
end;

function THelloPlugView.OnSize(NewSize:PViewRect):tresult; winapi;
begin
  if NewSize=nil then
    Exit(kInvalidArgument);
  FForm.SetBounds(0,0,NewSize^.Width,NewSize^.Height);
  Result:=kResultOk;
end;

function THelloPlugView.OnFocus(state:TBool):tresult; winapi;
begin
  if state and FForm.CanFocus then
    FForm.SetFocus;
  Result:=kResultOk;
end;

function THelloPlugView.SetFrame(frame:IPlugFrame):tresult; winapi;
begin
  FFrame:=frame;
  Result:=kResultOk;
end;

function THelloPlugView.CanResize:tresult; winapi;
begin
  Result:=kResultOk;
end;

function THelloPlugView.CheckSizeConstraint(rect:PViewRect):tresult; winapi;
begin
  Result:=kResultOk;
end;

procedure THelloPlugView.UpdateGUI(id:TParamID; value:TParamValue);
begin
  case id of
    100: FForm.AutomateTrackBar(value*1.95);
  end;  
end;

// 0 ~ 1 ==> 0 ~ 1.95, 0.8 --> 1.0
function Raw2Amp(x:Double):Double;inline;
begin
  Result:=1.944444444444445*x*x*x+0.005555555555554945*x;
end;

function Raw2Amp_d(x:Double):Double;inline;
begin
  Result:=3*1.944444444444445*x*x+0.005555555555554945;
end;

// 0 ~ 1.95 ==> 0 ~ 1
function Amp2Raw(x:Double):Double;
var
  t,fx:Double;
begin
  t:=x;
  repeat
    fx:=Raw2Amp(t)-x;
    t:=t-fx/Raw2Amp_d(t);
  until Abs(fx)<0.00001;
  Result:=t;
end;

procedure TForm1.ButtonResetClick(Sender: TObject);
begin
  TrackBarGain.Position:=8000;
end;

function TForm1.GetAmpValue:Double;
var
  RawValue:Double;
begin
  RawValue:=TrackBarGain.Position/TrackBarGain.Max;
  Result:=Raw2Amp(RawValue);
end;

procedure TForm1.OnTimer(Sender: TObject);
begin
  Inc(FCount);
  if FCount>5 then
  begin
    ComponentHandler.EndEdit(100);
    FCount:=0;
    FTimer.Enabled:=False;
  end;
end;

procedure TForm1.Init;
begin
  FTimer:=TTimer.Create(Self);
  FTimer.Enabled:=False;
  FTimer.Interval:=200;
  FTimer.OnTimer:=OnTimer;
  SetBounds(0,0,Width,Height);
  BorderStyle:=bsNone;
  TrackBarGain.Position:=8000; // After timer created
end;

procedure TForm1.AutomateTrackBar(AmpValue:Double);
var
  Raw:Double;
begin
  FAutomating:=True;
  Raw:=Amp2Raw(AmpValue);
  TrackBarGain.Position:=Round(Raw*TrackBarGain.Max);
  FAutomating:=False;
end;

procedure TForm1.TrackBarGainChange(Sender: TObject);
var
  Value:Double;
begin
  Value:=GetAmpValue;
  LabelGain.Caption:=Format('Gain: %.2f dB',[Amp2dB(Value)]);
  if not FAutomating then
  begin
    // https://steinbergmedia.github.io/vst3_dev_portal/pages/Technical+Documentation/Parameters+Automation/Index.html#sliders--knobs
    // Due to Delphi doesn't have OnMouseDown and OnMouseUp in TTrackBar, so we use a TTimer like Steinberg said
    if FCount=0 then
    begin
      ComponentHandler.BeginEdit(100);
      FTimer.Enabled:=True;
    end
    else
      FCount:=1;
    ComponentHandler.PerformEdit(100, Value/1.95);
  end;
end;

end.
