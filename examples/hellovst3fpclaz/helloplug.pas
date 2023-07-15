unit HelloPlug;

{$Interfaces CORBA}
{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, VST3Intf, PlugBase;

const
  CID_HelloProcessor:TGuid  = '{D2320513-341D-4EA3-82FA-63828685C394}';
  CID_HelloController:TGuid = '{3BB5C04E-AD1F-4997-BAAD-7496397887FF}';

type

  { THelloProcessor }

  THelloProcessor = class(TVAudioProcessor)
  protected
    FAudioIn:TBusInfo;  // Audio bus, input
    FAudioOut:TBusInfo; // Audio bus, output
    FParam1:TParamValue; // Parameter 1 value
    procedure DoProcess(inputs,outputs:PPSample32; samples:Int32); // Real process
  public
    function Initialize(context:FUnknown):tresult; override; winapi;
    function GetControllerClassID(classid:PGuid):tresult; override; winapi;
    function GetBusCount(kMedia:TMediaType; kBusDir:TBusDirection):Int32; override; winapi;
    function GetBusInfo(kMedia:TMediaType; kBusDir:TBusDirection; index:Int32;
      var info:TBusInfo):tresult; override; winapi;
    function ActivateBus(kMedia:TMediaType; kBusDir:TBusDirection; index:Int32;
      state:TBool):tresult; override; winapi;
    function SetActive(state:TBool):tresult; override; winapi;
    function SetBusArrangements(inputs:PSpeakerArrangement; NumIns:Int32;
      outputs:PSpeakerArrangement; NumOuts:Int32):tresult; override; winapi;
    function GetBusArrangements(kBusDir:TBusDirection; index:Int32;
      var arr:TSpeakerArrangement):tresult; override; winapi;
    function Process(var data:TProcessData):tresult; override; winapi;
  end;

  IUpdateGUI = interface(FUnknown)
    ['{21A86633-8D80-41DD-92B6-7354FF7F9BFE}']
    procedure UpdateGUI(id:TParamID; value:TParamValue);
  end;

  { THelloController }

  THelloController = class(TVEditController)
  protected
    FParamInfo1:TParameterInfo; // Information of parameter 1
    FParam1:TParamValue; // parameter 1 value
    FUpdateGUI:IUpdateGUI;
  public
    function Initialize(context:FUnknown):tresult; override; winapi;
    function GetParameterCount:Int32; override; winapi;
    function GetParameterInfo(ParamIndex:Int32; var info:TParameterInfo):tresult; override; winapi;
    function GetParamStringByValue(id:TParamID; ValueNormalized:TParamValue; str:PChar16):tresult; override; winapi;
    function GetParamValueByString(id:TParamID; str:PWideChar; var ValueNormalized:TParamValue):tresult; override; winapi;
    function NormalizedParamToPlain(id:TParamID; ValueNormalized:TParamValue):TParamValue; override; winapi;
    function PlainParamToNormalized(id:TParamID; PlainValue:TParamValue):TParamValue; override; winapi;
    function GetParamNormalized(id:TParamID):TParamValue; override; winapi;
    function SetParamNormalized(id:TParamID; value:TParamValue):tresult; override; winapi;
    function CreateView(name:FIDString):IPlugView; override; winapi;
  end;

  { THelloFactory }

  THelloFactory = class(TVPluginFactory)
  protected
    FClassProcessor:TPClassInfo2;
    FClassController:TPClassInfo2;
  public
    constructor Create;
    function GetClassInfo(index:Int32; info:PPClassInfo):tresult; override; winapi;
    function GetClassInfo2(index:Int32; info:PPClassInfo2):tresult; override; winapi;
    function GetClassInfoUnicode(index:Int32; info:PPClassInfoW):tresult; override; winapi;
    function CreateInstance(const cid:TGuid; const iid:TGuid; out obj):tresult; override; winapi;
  end;

function Amp2dB(x:Double):Double;
function dB2Amp(x:Double):Double;

implementation

uses
  Math, HelloForm;

{ THelloProcessor }

procedure THelloProcessor.DoProcess(inputs,outputs:PPSample32; samples:Int32);
var
  i:Integer;
begin
   // Apply gain to channels
  for i:=0 to samples-1 do
  begin
    outputs[0,i]:=inputs[0,i]*FParam1;
    outputs[1,i]:=inputs[1,i]*FParam1;
  end;
end;

function THelloProcessor.Initialize(context:FUnknown):tresult; winapi;
begin
  FAudioIn.MediaType:=kAudio;
  FAudioIn.BusType:=kMain;
  FAudioIn.Direction:=kInput;
  FAudioIn.Name:='Stereo In';
  FAudioIn.Flags:=kDefaultActive;
  FAudioIn.ChannelCount:=2;
  FAudioOut.MediaType:=kAudio;
  FAudioOut.BusType:=kMain;
  FAudioOut.Direction:=kOutput;
  FAudioOut.Name:='Stereo Out';
  FAudioOut.Flags:=kDefaultActive;
  FAudioOut.ChannelCount:=2;
  FParam1:=1; // 0 ~ 1.95
  Result:=inherited Initialize(context);
end;

function THelloProcessor.GetControllerClassID(classid:PGuid):tresult; winapi;
begin
  if classid=nil then
    Exit(kInvalidArgument);
  classid^:=CID_HelloController;
  Result:=kResultOk;
end;

function THelloProcessor.GetBusCount(kMedia:TMediaType; kBusDir:TBusDirection):Int32; winapi;
begin
  if kMedia<>kAudio then // Only support kAudio
    Exit(0);
  case kBusDir of
    kInput, kOutput: Result:=1;
    else Result:=0;
  end;
end;

function THelloProcessor.GetBusInfo(kMedia:TMediaType; kBusDir:TBusDirection; index:Int32;
  var info:TBusInfo):tresult; winapi;
begin
  if (kMedia<>kAudio) or (index<>0) then
    Exit(kResultFalse);
  case kBusDir of
    kInput: info:=FAudioIn;
    kOutput: info:=FAudioOut;
    else Exit(kResultFalse);
  end;
  Result:=kResultOk;
end;

function THelloProcessor.ActivateBus(kMedia:TMediaType; kBusDir:TBusDirection; index:Int32;
  state:TBool):tresult; winapi;
begin
  Result:=kResultOk;
end;

function THelloProcessor.SetActive(state:TBool):tresult; winapi;
begin
  Result:=kResultOk;
end;

function THelloProcessor.SetBusArrangements(inputs:PSpeakerArrangement; NumIns:Int32;
  outputs:PSpeakerArrangement; NumOuts:Int32):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function THelloProcessor.GetBusArrangements(kBusDir:TBusDirection; index:Int32;
  var arr:TSpeakerArrangement):tresult; winapi;
begin
  arr:=kStereo; // Left and right
  Result:=kResultOk;
end;

function THelloProcessor.Process(var data:TProcessData):tresult; winapi;
var
  changes:IParameterChanges;
  ParamQueue:IParamValueQueue;
  SampleOffset,PointCount:int32;
  Value:TParamValue;
  i:Integer;
begin
  changes:=data.InputParameterChanges;
  if changes<>nil then
  begin
    for i:=0 to changes.GetParameterCount-1 do
    begin
      ParamQueue:=changes.GetParameterData(i);
      if ParamQueue<>nil then
      begin
        PointCount:=ParamQueue.GetPointCount;
        SampleOffset:=0;
        Value:=0;
        case ParamQueue.GetParameterID of
          100: if ParamQueue.GetPoint(PointCount-1,SampleOffset,Value)=kResultOk then
                 FParam1:=Value * 1.95; // Update parameter
        end;
      end;
    end;
  end;
  if (data.NumInputs=0) or (data.NumOutputs=0) then
    Exit(kResultOk);
  if data.NumSamples>0 then
    DoProcess(data.Inputs[0].ChannelBuffers32, data.Outputs[0].ChannelBuffers32, data.NumSamples);
  Result:=kResultOk;
end;

{ THelloController }

function THelloController.Initialize(context:FUnknown):tresult; winapi;
begin
  FParam1:=1; // 0 ~ 1.95
  FParamInfo1.ID:=100;
  FParamInfo1.ID:=100;
  FParamInfo1.Title:='Gain';
  FParamInfo1.ShortTitle:='Gain';
  FParamInfo1.Units:='dB';
  FParamInfo1.StepCount:=0;
  FParamInfo1.DefaultNormalizedValue:=1/1.95; // 0 ~ 1
  FParamInfo1.UnitID:=0;
  FParamInfo1.Flags:=kCanAutomate;
  Result:=inherited Initialize(context);
end;

function THelloController.GetParameterCount:Int32; winapi;
begin
  Result:=1;
end;

function THelloController.GetParameterInfo(ParamIndex:Int32; var info:TParameterInfo):tresult; winapi;
begin
  if ParamIndex<>0 then
    Exit(kResultFalse);
  info:=FParamInfo1;
  Result:=kResultOk;
end;

function THelloController.GetParamStringByValue(id:TParamID; ValueNormalized:TParamValue;
  str:PChar16):tresult; winapi;
begin
  StrPCopy(str, UnicodeString(FormatFloat('0.00',NormalizedParamToPlain(id,ValueNormalized))));
  Result:=kResultOk;
end;

function THelloController.GetParamValueByString(id:TParamID; str:PWideChar;
  var ValueNormalized:TParamValue):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function THelloController.NormalizedParamToPlain(id:TParamID; ValueNormalized:TParamValue):TParamValue;
  winapi;
begin
  case id of
    100: Result:=Amp2dB(1.95*ValueNormalized);
    else Result:=0;
  end;
end;

function THelloController.PlainParamToNormalized(id:TParamID; PlainValue:TParamValue):TParamValue; winapi;
begin
  case id of
    100: Result:=dB2Amp(PlainValue)/1.95;
    else Result:=0;
  end;
end;

function THelloController.GetParamNormalized(id:TParamID):TParamValue; winapi;
begin
  case id of
    100: Result:=FParam1;
    else Result:=0;
  end;
end;

function THelloController.SetParamNormalized(id:TParamID; value:TParamValue):tresult; winapi;
begin
  if FUpdateGUI=nil then
    Exit(kResultFalse);
  case id of
    100: begin
      FParam1:=value;
      FUpdateGUI.UpdateGUI(id,value);
    end;
    else Exit(kResultFalse);
  end;
  Result:=kResultOk;
end;

function THelloController.CreateView(name:FIDString):IPlugView; winapi;
var
  View:THelloPlugView;
begin
  Result:=nil;
  if name=kViewTypeEditor then
  begin
    View:=THelloPlugView.Create(Self);
    FUpdateGUI:=View as IUpdateGUI;
    Result:=View as IPlugView;
  end;
end;

{ THelloFactory }

constructor THelloFactory.Create;
begin
  // Initialize the information of factory and classes
  FFactoryInfo.Init('Peacoor Zomboss','https://github.com/drpzboss','mailto:peazomboss@outlook.com');
  FClassProcessor.Init(CID_HelloProcessor,kManyInstances,kDistributable,kVstAudioEffectClass,
    'Fx','HelloVst3FPCLaz','Peacoor Zomboss','0.0.1',kVstVersionString);
  FClassController.Init(CID_HelloController,kManyInstances,0,kVstComponentControllerClass,
    '','HelloVst3FPCLaz','Peacoor Zomboss','0.0.1',kVstVersionString);
end;

function THelloFactory.GetClassInfo(index:Int32; info:PPClassInfo):tresult; winapi;
begin
  if info=nil then
    Exit(kInvalidArgument);
  case index of
    0: info^:=PPClassInfo(@FClassProcessor)^;
    1: info^:=PPClassInfo(@FClassController)^;
    else Exit(kResultFalse);
  end;
  Result:=kResultOk;
end;

function THelloFactory.GetClassInfo2(index:Int32; info:PPClassInfo2):tresult; winapi;
begin
  if info=nil then
    Exit(kInvalidArgument);
  case index of
    0: info^:=FClassProcessor;
    1: info^:=FClassController;
    else Exit(kResultFalse);
  end;
  Result:=kResultOk;
end;

function THelloFactory.GetClassInfoUnicode(index:Int32; info:PPClassInfoW):tresult; winapi;
begin
  if info=nil then
    Exit(kInvalidArgument);
  case index of
    0: info^.FromInfo2(FClassProcessor);
    1: info^.FromInfo2(FClassController);
    else Exit(kResultFalse);
  end;
  Result:=kResultOk;
end;

function THelloFactory.CreateInstance(const cid:TGuid; const iid:TGuid; out obj):tresult; winapi;
begin
  if IsEqualGUID(cid, CID_HelloProcessor) then
  begin
    if not IsEqualGUID(iid, IID_IComponent) then
      Exit(kResultFalse);
    Pointer(obj):=THelloProcessor.Create as IComponent; // must use as IComponent
    Exit(kResultOk);
  end;
  if IsEqualGUID(cid, CID_HelloController) then
  begin
    if not IsEqualGUID(iid, IID_IEditController) then
      Exit(kResultFalse);
    Pointer(obj):=THelloController.Create as IEditController;
    Exit(kResultOk);
  end;
  Result:=kResultFalse;
end;

function Amp2dB(x:Double):Double;
begin
  if x>1E-50 then
    Result:=20*Log10(x)
  else
    Result:=NegInfinity;
end;

function dB2Amp(x:Double):Double;
begin
  if x>-1000 then
    Result:=Exp(x*0.1151292546497022842)
  else
    Result:=0;
end;

end.

