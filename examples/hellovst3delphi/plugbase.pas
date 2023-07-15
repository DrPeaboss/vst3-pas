unit PlugBase;

interface

uses
  SysUtils, VST3Intf;

type

  { TVObject }
  // Like TInterfacedObject, but default reference count is 1
  // Don't forget add virtual
  TVObject = class(TObject, FUnknown)
  protected
    FRefCount:Integer;
  public
    function QueryInterface(const iid:TGuid; out obj):tresult; virtual; winapi;
    function _AddRef:Integer; virtual; winapi;
    function _Release:Integer; virtual; winapi;
    class function NewInstance:TObject; override;
    property RefCount:Integer read FRefCount;
  end;

  { TVPluginBase }

  TVPluginBase = class(TVObject, IPluginBase)
  protected
    FHostContext:IHostApplication;
  public
    function Initialize(context:FUnknown):tresult; virtual; winapi;
    function Terminate:tresult; virtual; winapi;
    property HostContext:IHostApplication read FHostContext;
  end;

  { TVComponent }

  TVComponent = class(TVPluginBase, IComponent)
  protected
    FControllerClass:TGuid;
  public
    function GetControllerClassID(classid:PGuid):tresult; virtual; winapi;
    function SetIOMode(kIOMode:TIOMode):tresult; virtual; winapi;
    function GetBusCount(kMedia:TMediaType; kBusDir:TBusDirection):Int32; virtual; winapi;
    function GetBusInfo(kMedia:TMediaType; kBusDir:TBusDirection; index:Int32;
      var info:TBusInfo):tresult; virtual; winapi;
    function GetRoutingInfo(var ininfo:TRoutingInfo; var outinfo:TRoutingInfo):tresult; virtual; winapi;
    function ActivateBus(kMedia:TMediaType; kBusDir:TBusDirection; index:Int32;
      state:TBool):tresult; virtual; winapi;
    function SetActive(state:TBool):tresult; virtual; winapi;
    function SetState(state:IBStream):tresult; virtual; winapi;
    function GetState(state:IBStream):tresult; virtual; winapi;
    property ControllerClass:TGuid read FControllerClass write FControllerClass;
  end;

  { TVAudioProcessor }

  TVAudioProcessor = class(TVComponent, IAudioProcessor)
  protected
    FProcessSetup:TProcessSetup;
  public
    function SetBusArrangements(inputs:PSpeakerArrangement; NumIns:Int32;
      outputs:PSpeakerArrangement; NumOuts:Int32):tresult; virtual; winapi;
    function GetBusArrangements(kBusDir:TBusDirection; index:Int32;
      var arr:TSpeakerArrangement):tresult; virtual; winapi;
    function CanProcessSampleSize(SymbolicSampleSize:Int32):tresult; virtual; winapi;
    function GetLatencySamples:UInt32; virtual; winapi;
    function SetupProcessing(var setup:TProcessSetup):tresult; virtual; winapi;
    function SetProcessing(state:TBool):tresult; virtual; winapi;
    function Process(var data:TProcessData):tresult; virtual; winapi;
    function GetTailSamples:UInt32; virtual; winapi;
  end;

  { TVEditController }

  TVEditController = class(TVPluginBase, IEditController)
  protected
    FComponentHandler:IComponentHandler;
    procedure RemoveHandler;
  public
    function Terminate:tresult; override; winapi;
    function SetComponentState(state:IBStream):tresult; virtual; winapi;
    function SetState(state:IBStream):tresult; virtual; winapi;
    function GetState(state:IBStream):tresult; virtual; winapi;
    function GetParameterCount:Int32; virtual; winapi;
    function GetParameterInfo(ParamIndex:Int32; var info:TParameterInfo):tresult; virtual; winapi;
    function GetParamStringByValue(id:TParamID; ValueNormalized:TParamValue; str:PChar16):tresult; virtual; winapi;
    function GetParamValueByString(id:TParamID; str:PWideChar;
      var ValueNormalized:TParamValue):tresult; virtual; winapi;
    function NormalizedParamToPlain(id:TParamID; ValueNormalized:TParamValue):TParamValue; virtual; winapi;
    function PlainParamToNormalized(id:TParamID; PlainValue:TParamValue):TParamValue; virtual; winapi;
    function GetParamNormalized(id:TParamID):TParamValue; virtual; winapi;
    function SetParamNormalized(id:TParamID; value:TParamValue):tresult; virtual; winapi;
    function SetComponentHandler(handler:IComponentHandler):tresult; virtual; winapi;
    function CreateView(name:FIDString):IPlugView unsafe; virtual; winapi;
    property ComponentHandler:IComponentHandler read FComponentHandler;
  end;

  { TVPluginFactory }
  // To let the compiler generate the informations of interfaces, we must
  // explicitly specify these three interfaces, or we have to override the
  // QueryInterface method.
  TVPluginFactory = class(TVObject, IPluginFactory, IPluginFactory2, IPluginFactory3)
  protected
    FFactoryInfo:TPFactoryInfo;
  public
    function GetFactoryInfo(info:PPFactoryInfo):tresult; virtual; winapi;
    function CountClasses:Int32; virtual; winapi;
    function GetClassInfo(index:Int32; info:PPClassInfo):tresult; virtual; winapi;
    function CreateInstance(const cid:TGuid; const iid:TGuid; out obj):tresult; virtual; winapi;
    function GetClassInfo2(index:Int32; info:PPClassInfo2):tresult; virtual; winapi;
    function GetClassInfoUnicode(index:Int32; info:PPClassInfoW):tresult; virtual; winapi;
    function SetHostContext(context:FUnknown):tresult; virtual; winapi;
  end;

implementation

{ TVObject }

function TVObject.QueryInterface(const iid:TGuid; out obj):tresult; winapi;
begin
  if GetInterface(iid, obj) then
    Result:=kResultOk
  else
    Result:=kNoInterface;
end;

function TVObject._AddRef:Integer; winapi;
begin
  Result:=AtomicIncrement(FRefCount);
end;

function TVObject._Release:Integer; winapi;
begin
  Result:=AtomicDecrement(FRefCount);
  if Result=0 then
    Self.Destroy;
end;

class function TVObject.NewInstance:TObject;
begin
  Result:=inherited NewInstance;
  TVObject(Result).FRefCount:=1;
end;

{ TVPluginBase }

function TVPluginBase.Initialize(context:FUnknown):tresult; winapi;
begin
  if context=nil then
    Exit(kInvalidArgument);
  context.QueryInterface(IID_IHostApplication, FHostContext); // optional
  Result:=kResultOk;
end;

function TVPluginBase.Terminate:tresult; winapi;
begin
  FHostContext:=nil;
  Result:=kResultOk;
end;

{ TVComponent }

function TVComponent.GetControllerClassID(classid:PGuid):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVComponent.SetIOMode(kIOMode:TIOMode):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVComponent.GetBusCount(kMedia:TMediaType; kBusDir:TBusDirection):Int32; winapi;
begin
  Result:=kNotImplemented;
end;

function TVComponent.GetBusInfo(kMedia:TMediaType; kBusDir:TBusDirection; index:Int32;
  var info:TBusInfo):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVComponent.GetRoutingInfo(var ininfo:TRoutingInfo; var outinfo:TRoutingInfo):tresult;
  winapi;
begin
  Result:=kNotImplemented;
end;

function TVComponent.ActivateBus(kMedia:TMediaType; kBusDir:TBusDirection; index:Int32; state:TBool):tresult;
  winapi;
begin
  Result:=kNotImplemented;
end;

function TVComponent.SetActive(state:TBool):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVComponent.SetState(state:IBStream):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVComponent.GetState(state:IBStream):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

{ TVAudioProcessor }

function TVAudioProcessor.SetBusArrangements(inputs:PSpeakerArrangement; NumIns:int32;
  outputs:PSpeakerArrangement; NumOuts:int32):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVAudioProcessor.GetBusArrangements(kBusDir:TBusDirection; index:int32;
  var arr:TSpeakerArrangement):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVAudioProcessor.CanProcessSampleSize(SymbolicSampleSize:Int32):tresult; winapi;
begin
  if SymbolicSampleSize=kSample32 then // use 32bit float by default
    Exit(kResultOk);
  Result:=kResultFalse;
end;

function TVAudioProcessor.GetLatencySamples:uint32; winapi;
begin
  Result:=0;
end;

function TVAudioProcessor.SetupProcessing(var setup:TProcessSetup):tresult; winapi;
begin
  if CanProcessSampleSize(setup.SymbolicSampleSize)<>kResultOk then // check
    Exit(kResultFalse);
  FProcessSetup.SymbolicSampleSize:=setup.SymbolicSampleSize;
  FProcessSetup.MaxSamplePerBlock:=setup.MaxSamplePerBlock;
  FProcessSetup.SampleRate:=setup.SampleRate;
  FProcessSetup.ProcessMode:=setup.ProcessMode;
  Result:=kResultOk;
end;

function TVAudioProcessor.SetProcessing(state:TBool):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVAudioProcessor.Process(var data:TProcessData):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVAudioProcessor.GetTailSamples:UInt32; winapi;
begin
  Result:=kNoTail;
end;

{ TVEditController }

procedure TVEditController.RemoveHandler;
begin
  FComponentHandler:=nil;
end;

function TVEditController.Terminate:tresult; winapi;
begin
  RemoveHandler;
  Result:=inherited Terminate;
end;

function TVEditController.SetComponentState(state:IBStream):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVEditController.SetState(state:IBStream):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVEditController.GetState(state:IBStream):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVEditController.GetParameterCount:Int32; winapi;
begin
  Result:=0;
end;

function TVEditController.GetParameterInfo(ParamIndex:Int32; var info:TParameterInfo):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVEditController.GetParamStringByValue(id:TParamID; ValueNormalized:TParamValue;
  str:PChar16):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVEditController.GetParamValueByString(id:TParamID; str:PWideChar;
  var ValueNormalized:TParamValue):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVEditController.NormalizedParamToPlain(id:TParamID;
  ValueNormalized:TParamValue):TParamValue; winapi;
begin
  Result:=ValueNormalized;
end;

function TVEditController.PlainParamToNormalized(id:TParamID; PlainValue:TParamValue):TParamValue;
  winapi;
begin
  Result:=PlainValue;
end;

function TVEditController.GetParamNormalized(id:TParamID):TParamValue; winapi;
begin
  Result:=0;
end;

function TVEditController.SetParamNormalized(id:TParamID; value:TParamValue):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVEditController.SetComponentHandler(handler:IComponentHandler):tresult; winapi;
begin
  if handler=nil then
    Exit(kInvalidArgument);
  if handler=FComponentHandler then
    Exit(kResultOk);
  RemoveHandler;
  FComponentHandler:=handler;
  Result:=kResultOk;
end;

function TVEditController.CreateView(name:FIDString):IPlugView unsafe; winapi;
begin
  Result:=nil;
end;

{ TVPluginFactory }

function TVPluginFactory.GetFactoryInfo(info:PPFactoryInfo):tresult; winapi;
begin
  if info=nil then
    Exit(kInvalidArgument);
  info^:=FFactoryInfo;
  Result:=kResultOk;
end;

function TVPluginFactory.CountClasses:Int32; winapi;
begin
  Result:=2;
end;

function TVPluginFactory.GetClassInfo(index:Int32; info:PPClassInfo):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVPluginFactory.CreateInstance(const cid:TGuid; const iid:TGuid; out obj):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVPluginFactory.GetClassInfo2(index:Int32; info:PPClassInfo2):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVPluginFactory.GetClassInfoUnicode(index:Int32; info:PPClassInfoW):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

function TVPluginFactory.SetHostContext(context:FUnknown):tresult; winapi;
begin
  Result:=kNotImplemented;
end;

end.

