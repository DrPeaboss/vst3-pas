{-------------------------------------------------------------------------------
  The Object Pascal(FPC and Delphi) bindings of VST 3 API.
  Original API is at <https://github.com/steinbergmedia/vst3_pluginterfaces>

  Current API version is 3.7.12 (2024/07/23).

  This unit is converted from part of VST 3 API,
  constains the main constants, data structures and interfaces.
  This unit is alpha version and has not fully tested!

  Remember, this is not a distribution of VST SDK.
  You can find the full SDK at <https://github.com/steinbergmedia/vst3sdk>
  If you want to use this unit in your projects, please abide by GPLv3 license.
  License at <https://www.gnu.org/licenses/gpl-3.0.html>

  VST is a trademark of Steinberg Media Technologies GmbH,
  registered in Europe and other countries.
-------------------------------------------------------------------------------}

unit VST3Intf;

{$H+}{$I-}{$J-}{$R-}{$S-}

{$ifdef FPC}
  {$mode delphi}
  {$Interfaces CORBA} // Use CORBA interface in FPC
{$endif}

interface

{ Delphi Compatibility }

{$ifndef FPC}
type
  PInt32 = ^Int32;
  PUInt8 = ^UInt8;
  PtrUInt = NativeUInt;
{$endif}

{ VST Versions }

const
  kVstVersionString = 'VST 3.7.12'; // SDK version for TPClassInfo2

  kVstVersionMajor  = 3;
  kVstVersionMinor  = 7;
  kVstVersionSub    = 12;

  VST_VERSION = kVstVersionMajor shl 16 or kVstVersionMinor shl 8 or kVstVersionSub;

  // Versions History which allows to write such code:
  // {$IF VST_VERSION >= VST_3_6_5_VERSION}

  VST_3_7_12_VERSION = $03070C;
  VST_3_7_11_VERSION = $03070B;
  VST_3_7_10_VERSION = $03070A;
  VST_3_7_9_VERSION  = $030709;
  VST_3_7_8_VERSION  = $030708;
  VST_3_7_7_VERSION  = $030707;
  VST_3_7_6_VERSION  = $030706;
  VST_3_7_5_VERSION  = $030705;
  VST_3_7_4_VERSION  = $030704;
  VST_3_7_3_VERSION  = $030703;
  VST_3_7_2_VERSION  = $030702;
  VST_3_7_1_VERSION  = $030701;
  VST_3_7_0_VERSION  = $030700;
  VST_3_6_14_VERSION = $03060E;
  VST_3_6_13_VERSION = $03060D;
  VST_3_6_12_VERSION = $03060C;
  VST_3_6_11_VERSION = $03060B;
  VST_3_6_10_VERSION = $03060A;
  VST_3_6_9_VERSION  = $030609;
  VST_3_6_8_VERSION  = $030608;
  VST_3_6_7_VERSION  = $030607;
  VST_3_6_6_VERSION  = $030606;
  VST_3_6_5_VERSION  = $030605;
  VST_3_6_0_VERSION  = $030600;
  VST_3_5_0_VERSION  = $030500;
  VST_3_1_0_VERSION  = $030100;
  VST_3_0_0_VERSION  = $030000;

  SDKVersionString  = kVstVersionString;
  SDKVersionMajor   = kVstVersionMajor;
  SDKVersionMinor   = kVstVersionMinor;
  SDKVersionSub     = kVstVersionSub;
  SDKVersion        = VST_VERSION;
  SDKVersion_3_7_12 = VST_3_7_12_VERSION;
  SDKVersion_3_7_11 = VST_3_7_11_VERSION;
  SDKVersion_3_7_10 = VST_3_7_10_VERSION;
  SDKVersion_3_7_9  = VST_3_7_9_VERSION;
  SDKVersion_3_7_8  = VST_3_7_8_VERSION;
  SDKVersion_3_7_7  = VST_3_7_7_VERSION;
  SDKVersion_3_7_6  = VST_3_7_6_VERSION;
  SDKVersion_3_7_5  = VST_3_7_5_VERSION;
  SDKVersion_3_7_4  = VST_3_7_4_VERSION;
  SDKVersion_3_7_3  = VST_3_7_3_VERSION;
  SDKVersion_3_7_2  = VST_3_7_2_VERSION;
  SDKVersion_3_7_1  = VST_3_7_1_VERSION;
  SDKVersion_3_7_0  = VST_3_7_0_VERSION;
  SDKVersion_3_6_14 = VST_3_6_14_VERSION;
  SDKVersion_3_6_13 = VST_3_6_13_VERSION;
  SDKVersion_3_6_12 = VST_3_6_12_VERSION;
  SDKVersion_3_6_11 = VST_3_6_11_VERSION;
  SDKVersion_3_6_10 = VST_3_6_10_VERSION;
  SDKVersion_3_6_9  = VST_3_6_9_VERSION;
  SDKVersion_3_6_8  = VST_3_6_8_VERSION;
  SDKVersion_3_6_7  = VST_3_6_7_VERSION;
  SDKVersion_3_6_6  = VST_3_6_6_VERSION;
  SDKVersion_3_6_5  = VST_3_6_5_VERSION;
  SDKVersion_3_6_0  = VST_3_6_0_VERSION;
  SDKVersion_3_5_0  = VST_3_5_0_VERSION;
  SDKVersion_3_1_0  = VST_3_1_0_VERSION;
  SDKVersion_3_0_0  = VST_3_0_0_VERSION;

{ Basic Interfaces }

type
  UChar   = Byte;
  UCoord  = Int32;
  TSize   = Int64;
  tresult = HRESULT; // Int32, but use built-in for delphi compatibility
  TPtrInt = PtrUInt;
  TBool   = ByteBool;
  Char8   = AnsiChar;
  Char16  = Widechar;
  PChar8  = PAnsiChar;
  PChar16 = PWideChar;
  FIDString = PAnsiChar; // identifier as string (used for attributes, messages)
  // Conflict in namespace Steinberg and Steinberg::Vst, see ftypes.h and vsttypes.h
  //TChar   = Char;
  //CStringA = PAnsiChar;
  //CStringW = PWideChar;
  //CString  = PChar;

const
  kMaxLong   = High(Int32);
  kMinLong   = Low(Int32);
  kMaxInt32  = kMaxLong;
  kMinInt32  = kMinLong;
  kMaxInt32u = High(UInt32);
  kMaxCoord  = $7FFFFFFF;
  kMinCoord  = -$7FFFFFFF;
  kMaxInt64  = High(Int64);
  kMinInt64  = Low(Int64);
  kMaxInt64u = High(UInt64);
  kMaxFloat  = 3.40282346638528860E38;
  kMaxDouble = 1.7976931348623158E308;

  kPlatformStringWin   = 'WIN';
  kPlatformStringMac   = 'MAC';
  kPlatformStringIOS   = 'IOS';
  kPlatformStringLinux = 'Linux';
{$if defined(MSWINDOWS)}
  kPlatformString = kPlatformStringWin;
{$elseif defined(IOS)}
  kPlatformString = kPlatformStringIOS;
{$elseif defined(DARWIN) or defined(MACOS) or defined(OSX)}
  kPlatformString = kPlatformStringMac;
{$elseif defined(LINUX)}
  kPlatformString = kPlatformStringLinux;
{$endif}

{$ifdef MSWINDOWS}
  kNoInterface     = tresult($80004002); // E_NOINTERFACE
  kResultOk        = tresult($00000000); // S_OK
  kResultTrue      = kResultOk;
  kResultFalse     = tresult($00000001); // S_FALSE
  kInvalidArgument = tresult($80070057); // E_INVALIDARG
  kNotImplemented  = tresult($80004001); // E_NOTIMPL
  kInternalError   = tresult($80004005); // E_FAIL
  kNotInitialized  = tresult($8000FFFF); // E_UNEXPECTED
  kOutOfMemory     = tresult($8007000E); // E_OUTOFMEMORY
{$else}
  kNoInterface     = tresult($80000004); // E_NOINTERFACE
  kResultOk        = tresult($00000000); // S_OK
  kResultTrue      = kResultOk;
  kResultFalse     = tresult($00000001); // S_FALSE
  kInvalidArgument = tresult($80000003); // E_INVALIDARG
  kNotImplemented  = tresult($80000001); // E_NOTIMPL
  kInternalError   = tresult($80000008); // E_FAIL
  kNotInitialized  = tresult($8000FFFF); // E_UNEXPECTED
  kOutOfMemory     = tresult($80000002); // E_OUTOFMEMORY
{$endif}

const
  GUID_FUnknown = '{00000000-0000-0000-C000-000000000046}';
  GUID_IBStream = '{C3BF6EA2-3099-4752-9B6B-F9901EE33E9B}';
  GUID_ISizeableStream = '{04F9549E-E02F-4E6E-87E8-6A8747F4E17F}';
  GUID_IPluginBase = '{22888DDB-156E-45AE-8358-B34808190625}';
  GUID_IPluginFactory = '{7A4D811C-5211-4A1F-AED9-D2EE0B43BF9F}';
  GUID_IPluginFactory2 = '{0007B650-F24B-4C0B-A464-EDB9F00B2ABB}';
  GUID_IPluginFactory3 = '{4555A2AB-C123-4E57-9B12-291036878931}';
  GUID_IStringResult = '{550798BC-8720-49DB-8492-0A153B50B7A8}';
  GUID_IString = '{F99DB7A3-0FC1-4821-800B-0CF98E348EDF}';
  GUID_IUpdateHandler = '{F5246D56-8654-4d60-B026-AFB57B697B37}';
  GUID_IDependent = '{EC5E9713-71FF-49C2-82DA-8520AC017E63}';
  GUID_IPersistent = '{BA1A4637-3C9F-46D0-A65D-BA0EB85DA829}';
  GUID_IAttributes = '{FA1E32F9-CA6D-46F5-A982-F956B1191B58}';
  GUID_IAttributes2 = '{1382126A-FECA-4871-97D5-2A45B042AE99}';
  GUID_IErrorContext = '{12BCD07B-7C69-4336-B7DA-77C3444A0CD0}';
  GUID_ICloneable = '{D45406B9-3A2D-4443-9DAD-9BA985A1454B}';
  GUID_IPlugFrame = '{01AF7F36-9346-A9AF-8D4D-A2A0ED0882A3}';
  GUID_IPlugView = '{0725C35B-EA49-60D0-A615-1B522B755B29}';
{$IFDEF LINUX}
  GUID_IEventHandler = '{C9651E56-6F49-A013-813A-2C35654D7983}';
  GUID_ITimerHandler = '{4FD9BD10-7447-4241-821F-AD8FECA72CA9}';
  GUID_IRunLoop = '{6653C318-1A4F-7697-9C5B-83857A871389}';
{$ENDIF}
  GUID_IPlugViewContentScaleSupport = '{65ED9690-8AC4-4525-8AAD-EF7A72EA703F}';
  GUID_IAttributeList = '{1E5F0AEB-CC7F-4533-A254-401138AD5EE4}';
  GUID_IStreamAttributes = '{D6CE2FFC-EFAF-4B8C-9E74-F1BB12DA44B4}';
  GUID_IUnitHandler = '{4B5147F8-4654-486B-8DAB-30BA163A3C56}';
  GUID_IUnitHandler2 = '{F89F8CDF-699E-4BA5-96AA-C9A481452B01}';
  GUID_IUnitInfo = '{3D4BD6B5-913A-4FD2-A886-E768A5EB92C1}';
  GUID_IProgramListData = '{8683B01F-7B35-4F70-A265-1DEC353AF4FF}';
  GUID_IUnitData = '{6C389611-D391-455D-B870-B83394A0EFDD}';
  GUID_IContextMenu = '{2E93C863-0C9C-4588-97DB-ECF5AD17817D}';
  GUID_IComponentHandler3 = '{69F11617-D26B-400D-A4B6-B9647B6EBBAB}';
  GUID_IContextMenuTarget = '{3CDF2E75-85D3-4144-BF86-D36BD7C48940}';
  GUID_IComponent = '{E831FF31-F2D5-4301-928E-BBEE25697802}';
  GUID_IComponentHandler = '{93A0BEA3-0BD0-45DB-8E89-0B0CC1E46AC6}';
  GUID_IComponentHandler2 = '{F040B4B3-A360-45EC-ABCD-C045B4D5A2CC}';
  GUID_IComponentHandlerBusActivation = '{067D02C1-5B4E-274D-A92D-90FD6EAF7240}';
  GUID_IProgress = '{00C9DC5B-9D90-4254-91A3-88C8B4E91B69}';
  GUID_IEditController = '{DCD7BBE3-7742-448D-A874-AACC979C759E}';
  GUID_IEditController2 = '{7F4EFE59-F320-4967-AC27-A3AEAFB63038}';
  GUID_IMidiMapping = '{DF0FF9F7-49B7-4669-B63A-B7327ADBF5E5}';
  GUID_IEditControllerHostEditing = '{C1271208-7059-4098-B9DD-34B36BB0195E}';
  GUID_IComponentHandlerSystemTime = '{F9E53056-D155-4CD5-B769-5E1B7B0F7745}';
  GUID_IParamValueQueue = '{01263A18-ED07-4F6F-98C9-D3564686F9BA}';
  GUID_IParameterChanges = '{A4779663-0BB6-4A56-B443-84A8466FEB9D}';
  GUID_INoteExpressionController = '{B7F8F859-4123-4872-9116-95814F3721A3}';
  GUID_IKeyswitchController = '{1F2F76D3-BFFB-4B96-B995-27A55EBCCEF4}';
  GUID_INoteExpressionPhysicalUIMapping = '{B03078FF-94D2-4AC8-90CC-D303D4133324}';
  GUID_IEventList = '{3A2C4214-3463-49FE-B2C4-F397B9695A44}';
  GUID_IAudioProcessor = '{42043F99-B7DA-453C-A569-E79D9AAEC33D}';
  GUID_IAudioPresentationLatency = '{309ECE78-EB7D-4FAE-8B22-25D909FD08B6}';
  GUID_IProcessContextRequirements = '{2A654303-EF76-4E3D-95B5-FE83730EF6D0}';
  GUID_IDataExchangeHandler = '{36D551BD-6FF5-4F08-B48E-830D8BD5A03B}';
  GUID_IDataExchangeReceiver = '{45A759DC-84FA-4907-ABCB-61752FC786B6}';
  GUID_IMessage = '{936F033B-C6C0-47DB-BB08-82F813C1E613}';
  GUID_IConnectionPoint = '{70A4156F-6E6E-4026-9891-48BFAA60D8D1}';
  GUID_IPrefetchableSupport = '{8AE54FDA-E930-46B9-A285-55BCDC98E21E}';
  GUID_IParameterFinder = '{0F618302-215D-4587-A512-073C77B9D383}';
  GUID_IXmlRepresentationController = '{A81A0471-48C3-4DC4-AC30-C9E13C8393D5}';
  GUID_IHostApplication = '{58E595CC-DB2D-4969-8B6A-AF8C36A664E5}';
  GUID_IVst3ToVst2Wrapper = '{29633AEC-1D1C-47E2-BB85-B97BD36EAC61}';
  GUID_IVst3ToAUWrapper = '{A3B8C6C5-C095-4688-B091-6F0BB697AA44}';
  GUID_IVst3ToAAXWrapper = '{6D319DC6-60C5-6242-B32C-951B93BEF4C6}';
  GUID_IVst3WrapperMPESupport = '{44149067-42CF-4BF9-8800-B750F7359FE3}';
  GUID_IAutomationState = '{B4E8287F-1BB3-46AA-83A4-666768937BAB}';
  GUID_IMidiLearn = '{6B2449CC-4197-40B5-AB3C-79DAC5FE5C86}';
  GUID_IParameterFunctionName = '{6D21E1DC-9119-9D4B-A2A0-2FEF6C1AE55C}';
  GUID_IPlugInterfaceSupport = '{4FB58B9E-9EAA-4E0F-AB36-1C1CCCB56FEA}';
  GUID_IInterAppAudioHost = '{0CE5743D-68DF-415E-AE28-5BD4E2CDC8FD}';
  GUID_IInterAppAudioConnectionNotification = '{6020C72D-5FC2-4AA1-B095-0DB5D7D6D5CF}';
  GUID_IInterAppAudioPresetManager = '{ADE6FCC4-46C9-4E1D-B3B4-9A80C93FEFDD}';
  GUID_IPluginCompatibility = '{4AFD4B6A-35D7-C240-A5C3-1414FB7D15E6}';
  GUID_IRemapParamID = '{2B88021E-6286-B646-B49D-F76A5663061C}';

type
{$ifndef FPC}
  FUnknown = IUnknown;
{$else}
  FUnknown = interface [GUID_FUnknown]
    // Query for a pointer to the specified interface.
    // Returns kResultOk on success or kNoInterface if the object does not implement the interface.
    // The object has to call addRef when returning an interface.
    function QueryInterface(const iid:TGuid;out obj):tresult; winapi;
    // Adds a reference and returns the new reference count.
    // Remarks: The initial reference count after creating an object is 1.
    function _AddRef:Integer; winapi;
    // Releases a reference and returns the new reference count.
    // If the reference count reaches zero, the object will be destroyed in memory.
    function _Release:Integer; winapi;
  end;
{$endif}

  FVariant = record
  public const
    kEmpty    = 0;
    kInteger  = 1;
    kFloat    = 1 shl 1;
    kString8  = 1 shl 2;
    kObject   = 1 shl 3;
    kOwner    = 1 shl 4;
    kString16 = 1 shl 5;
  public
    &Type:Int16;
    case Byte of
      0:(IntValue:Int64);
      1:(FloatValue:Double);
      2:(String8:PChar8);
      3:(String16:PChar16);
      4:({$ifdef DCC}[unsafe]{$endif} &Object:FUnknown);
  end;

const
  kIBSeekSet = 0;  // set absolute seek position
  kIBSeekCur = 1;  // set seek position relative to current position
  kIBSeekEnd = 2;  // set seek position relative to stream end

type
  // Base class for streams.
  // read/write binary data from/to stream
  // get/set stream read-write position (read and write position is the same)
  IBStream = interface(FUnknown) [GUID_IBStream]
    // Reads binary data from stream.
    // param buffer : destination buffer
    // param numBytes : amount of bytes to be read
    // param numBytesRead : result - how many bytes have been read from stream (set to 0 if this is of no interest)
    function Read(buffer:Pointer; NumBytes:Int32; NumBytesRead:PInt32=nil):tresult; winapi;
    // Writes binary data to stream.
    // param buffer : source buffer
    // param numBytes : amount of bytes to write
    // param numBytesWritten : result - how many bytes have been written to stream (set to 0 if this is of no interest)
    function Write(buffer:Pointer; NumBytes:Int32; NumBytesWritten:PInt32=nil):tresult; winapi;
    // Sets stream read-write position.
    // param pos : new stream position (dependent on mode)
    // param mode : value of enum IStreamSeekMode
    // param res : new seek position (set to 0 if this is of no interest)
    function Seek(pos:Int64; mode:Int32; res:PInt64=nil):tresult; winapi;
    // Gets current stream read-write position.
    // param pos : is assigned the current position if function succeeds
    function Tell(pos:PInt64):tresult; winapi;
  end;

  // Stream with a size.
  // [extends IBStream] when stream type supports it (like file and memory stream)
  ISizeableStream = interface(FUnknown) [GUID_ISizeableStream]
    // Return the stream size
    function GetStreamSize(var size:Int64):tresult; winapi;
    // Set the steam size. File streams can only be resized if they are write enabled.
    function SetStreamSize(size:int64):tresult; winapi;
  end;

  // Basic interface to a plug-in component: IPluginBase
  // [plug imp]
  // initialize/terminate the plug-in component
  // The host uses this interface to initialize and to terminate the plug-in component.
  // The context that is passed to the initialize method contains any interface to the
  // host that the plug-in will need to work. These interfaces can vary from category to category.
  // A list of supported host context interfaces should be included in the documentation
  // of a specific category.
  IPluginBase = interface(FUnknown) [GUID_IPluginBase]
    // The host passes a number of interfaces as context to initialize the plug-in class.
    // param context, passed by the host, is mandatory and should implement IHostApplication
    // Extensive memory allocations etc. should be performed in this method rather than in the class' constructor!
    // If the method does NOT return kResultOk, the object is released immediately. In this case terminate is not called!
    function Initialize(context:FUnknown):tresult; winapi;
    // This function is called before the plug-in is unloaded and can be used for cleanups.
    // You have to _Release all references to any host application interfaces.
    function Terminate:tresult; winapi;
  end;

const
  // The number of exported classes can change each time the Module is loaded.
  // If this flag is set, the host does not cache class information.
  // This leads to a longer startup time because the host always has to
  // load the Module to get the current class information.
  kClassesDiscardable = 1 shl 0;
  // Class IDs of components are interpreted as Syncrosoft-License (LICENCE_UID).
  // Loaded in a Steinberg host, the module will not be loaded when the license is not valid
  // Changed in 3.7.4:
  // This flag is deprecated, do not use anynomre, resp. it will get ignored from Cubase/Nuendo 12 and later.
  kLicenseCheck = 1 shl 1 deprecated;
  // Component will not be unloaded until process exit
  kComponentNonDiscardable = 1 shl 3;
  // Components have entirely unicode encoded strings. (True for VST 3 plug-ins so far)
  kUnicode = 1 shl 4;

  // Standard value for TPFactoryInfo::flags
  kDefaultFactoryFlags = kUnicode;

  kManyInstances = $7FFFFFFF; // Used for Cardinality in TPClassInfo

  kDistributable = 1 shl 0;       // Component can be run on remote computer
  kSimpleModeSupported = 1 shl 1; // Component supports simple IO mode (or works in simple mode anyway) see vst3IoMode

  kURLSize = 256;
  kNameSize = 64;
  kEmailSize = 128;
  kVendorSize = 64;
  kVersionSize = 64;
  kCategorySize = 32;
  kSubCategoriesSize = 128;

type
  PPFactoryInfo = ^TPFactoryInfo;
  { TPFactoryInfo }
  // Basic Information about the class factory of the plug-in.
  TPFactoryInfo = record
  public type
    TVendorName = array[0..kNameSize-1] of char8;
    TURLName    = array[0..kURLSize-1] of char8;
    TEmailName  = array[0..kEmailSize-1] of char8;
  public
    Vendor:TVendorName;  // e.g. "Steinberg Media Technologies"
    Url:TURLName;        // e.g. "http://www.steinberg.de"
    Email:TEmailName;    // e.g. "info@steinberg.de"
    Flags:Int32;
    constructor Create(const _Vendor,_Url,_Email:AnsiString; _Flags:Int32=kDefaultFactoryFlags);
  end;

  PPClassInfo = ^TPClassInfo;
  // Basic Information about a class provided by the plug-in.
  TPClassInfo = record
  public type
    TCategoryName = array[0..kCategorySize-1] of char8;
    TName         = array[0..kNameSize-1] of char8;
  public
    CID:TGuid; // Class ID 16 Byte class GUID
    Cardinality:Int32; // cardinality of the class, set to kManyInstances
    Category:TCategoryName; // class category, host uses this to categorize interfaces
    Name:TName; // class name, visible to the user
  end;

  PPClassInfo2 = ^TPClassInfo2;
  { TPClassInfo2 }
  // Version 2 of Basic Information about a class provided by the plug-in.
  TPClassInfo2 = record
  public type
    TCategoryName = TPClassInfo.TCategoryName;
    TName         = TPClassInfo.TName;
    TVendorName   = array[0..kVendorSize-1] of char8;
    TVersionName  = array[0..kVersionSize-1] of char8;
    TSubCategoriesName = array[0..kSubCategoriesSize-1] of char8;
  public
    CID:TGuid; // Class ID 16 Byte class GUID
    Cardinality:Int32; // cardinality of the class, set to kManyInstances
    Category:TCategoryName; // class category, host uses this to categorize interfaces
    Name:TName; // class name, visible to the user
    ClassFlags:UInt32; // flags used for a specific category, must be defined where category is defined
    SubCategories:TSubCategoriesName; // module specific subcategories, can be more than one, logically added by the OR operator
    Vendor:TVendorName; // overwrite vendor information from factory info
    Version:TVersionName; // Version string (e.g. "1.0.0.512" with Major.Minor.Subversion.Build)
    SdkVersion:TVersionName; // SDK version used to build this class (e.g. "VST 3.0")
    constructor Create(const _CID:TGuid; _Cardinality:Int32; _ClassFlags:UInt32;
      const _Category,_SubCategories,_Name,_Vendor,_Version,_SdkVersion:AnsiString);
  end;

  PPClassInfoW = ^PClassInfoW;
  { PClassInfoW }
  // Unicode Version of Basic Information about a class provided by the plug-in
  PClassInfoW = record
  public type
    TCategoryName = TPClassInfo.TCategoryName;
    TNameW        = array[0..kNameSize-1] of char16;
    TVendorNameW  = array[0..kVendorSize-1] of char16;
    TVersionNameW = array[0..kVersionSize-1] of char16;
    TSubCategoriesName = TPClassInfo2.TSubCategoriesName;
  public
    CID:TGuid; // see TPClassInfo
    Cardinality:Int32; // see TPClassInfo
    Category:TCategoryName;
    Name:TNameW; // see TPClassInfo
    ClassFlags:UInt32; // flags used for a specific category, must be defined where category is defined
    SubCategories:TSubCategoriesName; // module specific subcategories, can be more than one, logically added by the OR operator
    Vendor:TVendorNameW; // overwrite vendor information from factory info
    Version:TVersionNameW; // Version string (e.g. "1.0.0.512" with Major.Minor.Subversion.Build)
    SdkVersion:TVersionNameW; // SDK version used to build this class (e.g. "VST 3.0")
    constructor FromInfo2(const ci2:TPClassInfo2);
  end;

  // Class factory that any plug-in defines for creating class instances: IPluginFactory
  // [plug imp]
  // From the host's point of view a plug-in module is a factory which can create
  // a certain kind of object(s). The interface IPluginFactory provides methods
  // to get information about the classes exported by the plug-in and a mechanism
  // to create instances of these classes (that usually define the IPluginBase interface).
  IPluginFactory = interface(FUnknown) [GUID_IPluginFactory]
    // Fill a TPFactoryInfo structure with information about the plug-in vendor.
    function GetFactoryInfo(info:PPFactoryInfo):tresult; winapi;
    // Returns the number of exported classes by this factory.
    // If you are using the CPluginFactory implementation provided by the SDK, it returns the number of classes you registered with CPluginFactory::registerClass.
    function CountClasses:Int32; winapi;
    // Fill a TPClassInfo structure with information about the class at the specified index.
    function GetClassInfo(index:Int32; info:PPClassInfo):tresult; winapi;
    // Create a new class instance.
    function CreateInstance(const cid:TGuid; const iid:TGuid; out obj):tresult; winapi;
  end;

  // IPluginFactory2 interface declaration
  // Version 2 of class factory supporting TPClassInfo2: IPluginFactory2
  IPluginFactory2 = interface(IPluginFactory) [GUID_IPluginFactory2]
    // Returns the class info (version 2) for a given index.
    function GetClassInfo2(index:Int32; info:PPClassInfo2):tresult; winapi;
  end;

  // IPluginFactory3 interface declaration
  // Version 3 of class factory supporting TPClassInfoW: IPluginFactory3
  IPluginFactory3 = interface(IPluginFactory2) [GUID_IPluginFactory3]
    // Returns the unicode class info for a given index.
    function GetClassInfoUnicode(index:Int32; info:PPClassInfoW):tresult; winapi;
    // Receives information about host
    function SetHostContext(context:FUnknown):tresult; winapi;
  end;

  TGetFactoryProc = function:IPluginFactory {$ifdef DCC}unsafe{$endif}; winapi;

type
  // Interface to return an ascii string of variable size.
  // In order to manage memory allocation and deallocation properly,
  // this interface is used to transfer a string as result parameter of
  // a method requires a string of unknown size.
  // - [host imp] or [plug imp]
  // - [released: SX 4]
  IStringResult = interface(FUnknown) [GUID_IStringResult]
    procedure SetText(Text:PChar8); winapi;
  end;

  // Interface to a string of variable size and encoding.
  // - [host imp] or [plug imp]
  // - [released: ]
  IString = interface(FUnknown) [GUID_IString]
    // Assign ASCII string
    procedure SetText8(Text:PChar8); winapi;
    // Assign unicode string
    procedure SetText16(Text:PChar16); winapi;
    // Return ASCII string. If the string is unicode so far, it will be converted.
    // So you need to be careful, because the conversion can result in data loss.
    // It is save though to call getText8 if isWideString() returns false
    function GetText8:PChar8; winapi;
    // Return unicode string. If the string is ASCII so far, it will be converted.
    function GetText16:PChar16; winapi;
    // !Do not use this method! Early implementations take the given pointer as
    // internal string and this will cause problems because 'free' will be used to delete the passed memory.
    // Later implementations will redirect 'take' to setText8 and setText16
    procedure Take(s:Pointer;IsWide:boolean); winapi; deprecated;
    // Returns true if the string is in unicode format, returns false if the string is ASCII
    function IsWideString:boolean; winapi;
  end;

type
  TChangeMessage = Int32;

const
  kWillChange  = 0;
  kChanged     = 1;
  kDestroyed   = 2;
  kWillDestroy = 3;
  kStdChangeMessageLast = kWillDestroy;

type
  IDependent = interface; // forward

  // Host implements dependency handling for plugins.
  // - [host imp]
  // - [get this interface from IHostClasses]
  // - [released N3.1]
  // - Install/Remove change notifications
  // - Trigger updates when an object has changed
  // Can be used between host-objects and the Plug-In or
  // inside the Plug-In to handle internal updates!
  IUpdateHandler = interface(FUnknown) [GUID_IUpdateHandler]
    // Install update notification for given object. It is essential to
    // remove all dependencies again using 'removeDependent'! Dependencies
    // are not removed automatically when the 'object' is released!
    // param object : interface to object that sends change notifications
    // param dependent : interface through which the update is passed
    function AddDependent(obj:FUnknown; dependent:IDependent):tresult; winapi;
    // Remove a previously installed dependency.
    function RemoveDependent(obj:FUnknown; dependent:IDependent):tresult; winapi;
    // Inform all dependents, that object has changed.
    // param object is the object that has changed
    // param message is a value of enum IDependent::ChangeMessage, usually IDependent::kChanged
    //   can be a private message as well (only known to sender and dependent)
    function TriggerUpdates(obj:FUnknown; msg:TChangeMessage):tresult; winapi;
    // Same as triggerUpdates, but delivered in idle (usefull to collect updates)
    function DeferUpdates(obj:FUnknown; msg:TChangeMessage):tresult; winapi;
  end;

  // A dependent will get notified about changes of a model.
  // [plug imp]
  // - notify changes of a model
  // see IUpdateHandler
  IDependent = interface(FUnknown) [GUID_IDependent]
    // Inform the dependent, that the passed FUnknown has changed
    procedure Update(ChangedUnknown:FUnknown; msg:TChangeMessage); winapi;
  end;

  IAttributes = interface;

  // Persistent Object Interface.
  // [plug imp]
  // This interface is used to store/restore attributes of an object.
  // An IPlugController can implement this interface to handle presets.
  IPersistent = interface(FUnknown) [GUID_IPersistent]
    // The class ID must be a 16 bytes unique id that is used to create the object.
    // This ID is also used to identify the preset list when used with presets.
    function GetClassID(uid:PGuid):tresult; winapi;
    // Store all members/data in the passed IAttributes.
    function SaveAttributes(attr:IAttributes):tresult; winapi;
    // Restore all members/data from the passed IAttributes.
    function LoadAttributes(attr:IAttributes):tresult; winapi;
  end;

  IAttrID = FIDString;

  // Object Data Archive Interface.
  // - [host imp]
  // - store data/objects/binary/subattributes in the archive
  // - read stored data from the archive
  // All data stored to the archive are identified by a string (IAttrID), which must be unique on each
  // IAttribute level.
  // The basic set/get methods make use of the FVariant class.
  IAttributes = interface(FUnknown) [GUID_IAttributes]
    // Store any data in the archive. It is even possible to store sub-attributes by creating
    // a new IAttributes instance via the IHostClasses interface and pass it to the parent in the
    // FVariant. In this case the archive must take the ownership of the newly created object, which
    // is true for all objects that have been created only for storing. You tell the archive to take
    // ownership by adding the FVariant::kOwner flag to the FVariant::type member (data.type |= FVariant::kOwner).
    // When using the PAttributes functions, this is done through a function parameter.
    function SetData(AttrID:IAttrID; const data:FVariant):tresult; winapi;
    // Store a list of data in the archive. Please note that the type of data is not mixable! So
    // you can only store a list of integers or a list of doubles/strings/etc. You can also store a list
    // of subattributes or other objects that implement the IPersistent interface.
    function Queue(ListID:IAttrID; const data:FVariant):tresult; winapi;
    // Store binary data in the archive. Parameter 'copyBytes' specifies if the passed data should be copied.
    // The archive cannot take the ownership of binary data. Either it just references a buffer in order
    // to write it to a file (copyBytes = false) or it copies the data to its own buffers (copyBytes = true).
    // When binary data should be stored in the default pool for example, you must always copy it!
    function SetBinaryData(AttrID:IAttrID; data:Pointer; bytes:UInt32; CopyBytes:Boolean):tresult; winapi;
    // Get data previously stored to the archive.
    function GetData(AttrID:IAttrID; var data:FVariant):tresult; winapi;
    // Get list of data previously stored to the archive. As long as there are queue members the method
    // will return kResultTrue. When the queue is empty, the methods returns kResultFalse. All lists except from
    // object lists can be reset which means that the items can be read once again. see IAttributes::resetQueue
    function Unqueue(ListID:IAttrID; var data:FVariant):tresult; winapi;
    // Get the amount of items in a queue.
    function GetQueueItemCount(AttrID:IAttrID):Int32; winapi;
    // Reset a queue. If you need to restart reading a queue, you have to reset it. You can reset a queue at any time.
    function ResetQueue(AttiID:IAttrID):tresult; winapi;
    // Reset all queues in the archive.
    function ResetAllQueues:tresult; winapi;
    // Read binary data from the archive. The data is copied into the passed buffer. The size of that buffer
    // must fit the size of data stored in the archive which can be queried via IAttributes::getBinaryDataSize
    function GetBinaryData(AttrID:IAttrID; data:Pointer; bytes:UInt32):tresult; winapi;
    // Get the size in bytes of binary data in the archive.
    function GetBinaryDataSize(AttrID:IAttrID):UInt32; winapi;
  end;

  // Extended access to Attributes; supports Attribute retrieval via iteration.
  // - [host imp]
  // - [released] C7/N6
  IAttributes2 = interface(IAttributes) [GUID_IAttributes2]
    // Returns the number of existing attributes.
    function CountAttributes:Int32; winapi;
    // Returns the attribute's ID for the given index.
    function GetAttributeID(Index:Int32):IAttrID; winapi;
  end;

  // Interface for error handling.
  // - [plug imp]
  // - [released: Sequel 2]
  IErrorContext = interface(FUnknown) [GUID_IErrorContext]
    // Tells the plug-in to not show any UI elements on errors.
    procedure DisableErrorUI(state:Boolean); winapi;
    // If an error happens and disableErrorUI was not set this should return kResultTrue
    // if the plug-in already showed a message to the user what happened.
    function ErrorMessageShown:tresult; winapi;
    // Fill message with error string. The host may show this to the user.
    function GetErrorMessage(msg:IString):tresult; winapi;
  end;

  // Interface allowing an object to be copied.
  // - [plug & host imp]
  // - [released: N4.12]
  ICloneable = interface(FUnknown) [GUID_ICloneable]
    // Create exact copy of the object
    function Clone:FUnknown {$ifdef DCC}unsafe{$endif}; winapi;
  end;

{ VST Interfaces }

type
  // Conflict in namespace Steinberg and Steinberg::Vst, see ftypes.h and vsttypes.h
  //CString = PChar8;
  //TChar = Char16;

  TString128 = array[0..127] of Char16; // 128 character UTF-16 string

  // General

  TMediaType     = Int32;  // media type (audio/event)
  TBusDirection  = Int32;  // bus direction (in/out)
  TBusType       = Int32;  // bus type (main/aux)
  TIOMode        = Int32;  // I/O mode (see vst3IoMode)
  TUnitID        = Int32;  // unit identifier

  TParamValue    = Double; // parameter value type: normalized value => [0.0, 1.0]
  // parameter identifier: value in range [0, 0x7FFFFFFF].
  // The range [0x80000000, 0xFFFFFFFF], is reserved for host application.
  TParamID       = UInt32;

  TProgramListID = Int32;  // program list identifier
  TCtrlNumber    = Int16;  // MIDI controller number (see ControllerNumbers for allowed values)
  TQuarterNotes  = Double; // time expressed in quarter notes
  TSamples       = Int64;  // time expressed in audio samples
  TColorSpec     = UInt32; // color defining by 4 component ARGB value (Alpha/Red/Green/Blue)
  PParamID       = ^TParamID;

  // Audio Types

  TSample32   = Single; // 32-bit precision audio sample
  TSample64   = Double; // 64-bit precision audio sample
  TSampleRate = Double; // sample rate
  PSample32   = ^TSample32;
  PPSample32  = ^PSample32;
  PSample64   = ^TSample64;
  PPSample64  = ^PSample64;

  TSpeaker            = UInt64; // Bit for one speaker
  TSpeakerArrangement = UInt64; // Bitset of speakers
  PSpeakerArrangement = ^TSpeakerArrangement;

const
  kNoParamId  = $FFFFFFFF; // default for uninitialized parameter ID
  kMinParamId = 0;         // value min for a parameter ID
  kMaxParamId = $7FFFFFFF; // value max for a parameter ID

  kSpeakerL = 1 shl 0;      // Left (L)
  kSpeakerR = 1 shl 1;      // Right (R)
  kSpeakerC = 1 shl 2;      // Center (C)
  kSpeakerLfe = 1 shl 3;    // Subbass (Lfe)
  kSpeakerLs = 1 shl 4;     // Left Surround (Ls)
  kSpeakerRs = 1 shl 5;     // Right Surround (Rs)
  kSpeakerLc = 1 shl 6;     // Left of Center (Lc) - Front Left Center
  kSpeakerRc = 1 shl 7;     // Right of Center (Rc) - Front Right Center
  kSpeakerS = 1 shl 8;      // Surround (S)
  kSpeakerCs = kSpeakerS;   // Center of Surround (Cs) - Back Center - Surround (S)
  kSpeakerSl = 1 shl 9;     // Side Left (Sl)
  kSpeakerSr = 1 shl 10;    // Side Right (Sr)
  kSpeakerTc = 1 shl 11;    // Top Center Over-head; Top Middle (Tc)
  kSpeakerTfl = 1 shl 12;   // Top Front Left (Tfl)
  kSpeakerTfc = 1 shl 13;   // Top Front Center (Tfc)
  kSpeakerTfr = 1 shl 14;   // Top Front Right (Tfr)
  kSpeakerTrl = 1 shl 15;   // Top Rear/Back Left (Trl)
  kSpeakerTrc = 1 shl 16;   // Top Rear/Back Center (Trc)
  kSpeakerTrr = 1 shl 17;   // Top Rear/Back Right (Trr)
  kSpeakerLfe2 = 1 shl 18;  // Subbass 2 (Lfe2)
  kSpeakerM = 1 shl 19;     // Mono (M)
  kSpeakerACN0 = 1 shl 20;  // Ambisonic ACN 0
  kSpeakerACN1 = 1 shl 21;  // Ambisonic ACN 1
  kSpeakerACN2 = 1 shl 22;  // Ambisonic ACN 2
  kSpeakerACN3 = 1 shl 23;  // Ambisonic ACN 3
  kSpeakerTsl = 1 shl 24;   // Top Side Left (Tsl)
  kSpeakerTsr = 1 shl 25;   // Top Side Right (Tsr)
  kSpeakerLcs = 1 shl 26;   // Left of Center Surround (Lcs) - Back Left Center
  kSpeakerRcs = 1 shl 27;   // Right of Center Surround (Rcs) - Back Right Center
  kSpeakerBfl = 1 shl 28;   // Bottom Front Left (Bfl)
  kSpeakerBfc = 1 shl 29;   // Bottom Front Center (Bfc)
  kSpeakerBfr = 1 shl 30;   // Bottom Front Right (Bfr)
  kSpeakerPl = 1 shl 31;    // Proximity Left (Pl)
  kSpeakerPr = 1 shl 32;    // Proximity Right (Pr)
  kSpeakerBsl = 1 shl 33;   // Bottom Side Left (Bsl)
  kSpeakerBsr = 1 shl 34;   // Bottom Side Right (Bsr)
  kSpeakerBrl = 1 shl 35;   // Bottom Rear Left (Brl)
  kSpeakerBrc = 1 shl 36;   // Bottom Rear Center (Brc)
  kSpeakerBrr = 1 shl 37;   // Bottom Rear Right (Brr)
  kSpeakerACN4 = 1 shl 38;  // Ambisonic ACN 4
  kSpeakerACN5 = 1 shl 39;  // Ambisonic ACN 5
  kSpeakerACN6 = 1 shl 40;  // Ambisonic ACN 6
  kSpeakerACN7 = 1 shl 41;  // Ambisonic ACN 7
  kSpeakerACN8 = 1 shl 42;  // Ambisonic ACN 8
  kSpeakerACN9 = 1 shl 43;  // Ambisonic ACN 9
  kSpeakerACN10 = 1 shl 44; // Ambisonic ACN 10
  kSpeakerACN11 = 1 shl 45; // Ambisonic ACN 11
  kSpeakerACN12 = 1 shl 46; // Ambisonic ACN 12
  kSpeakerACN13 = 1 shl 47; // Ambisonic ACN 13
  kSpeakerACN14 = 1 shl 48; // Ambisonic ACN 14
  kSpeakerACN15 = 1 shl 49; // Ambisonic ACN 15
  kSpeakerACN16 = 1 shl 50; // Ambisonic ACN 16
  kSpeakerACN17 = 1 shl 51; // Ambisonic ACN 17
  kSpeakerACN18 = 1 shl 52; // Ambisonic ACN 18
  kSpeakerACN19 = 1 shl 53; // Ambisonic ACN 19
  kSpeakerACN20 = 1 shl 54; // Ambisonic ACN 20
  kSpeakerACN21 = 1 shl 55; // Ambisonic ACN 21
  kSpeakerACN22 = 1 shl 56; // Ambisonic ACN 22
  kSpeakerACN23 = 1 shl 57; // Ambisonic ACN 23
  kSpeakerACN24 = 1 shl 58; // Ambisonic ACN 24
  kSpeakerLw = 1 shl 59;    // Left Wide (Lw)
  kSpeakerRw = 1 shl 60;    // Right Wide (Rw)

  kEmpty          = 0; // empty arrangement
  kMono           = kSpeakerM; // M
  kStereo         = kSpeakerL or kSpeakerR; // L R
  kStereoWide     = kSpeakerLw or kSpeakerRw; // Lw Rw
  kStereoSurround = kSpeakerLs or kSpeakerRs; // Ls Rs
  kStereoCenter   = kSpeakerLc or kSpeakerRc; // Lc Rc
  kStereoSide     = kSpeakerSl or kSpeakerSr; // Sl Sr
  kStereoCLfe     = kSpeakerC or kSpeakerLfe; // C Lfe
  kStereoTF       = kSpeakerTfl or kSpeakerTfr; // Tfl Tfr
  kStereoTS       = kSpeakerTsl or kSpeakerTsr; // Tsl Tsr
  kStereoTR       = kSpeakerTrl or kSpeakerTrr; // Trl Trr
  kStereoBF       = kSpeakerBfl or kSpeakerBfr; // Bfl Bfr
  kCineFront      = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLc or kSpeakerRc; // L R C Lc Rc

  // L R C
  k30Cine =  kSpeakerL or kSpeakerR or kSpeakerC; // 3.0
  // L R C Lfe
  k31Cine =  k30Cine or kSpeakerLfe; // 3.1
  // L R S
  k30Music = kSpeakerL or kSpeakerR or kSpeakerCs;
  // L R Lfe S
  k31Music = k30Music or kSpeakerLfe;
  // L R C S
  k40Cine =  kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerCs; // LCRS
  // L R C Lfe S
  k41Cine =  k40Cine or kSpeakerLfe; // LCRS or Lfe
  // L R Ls Rs
  k40Music = kSpeakerL or kSpeakerR or kSpeakerLs or kSpeakerRs; // 4.0 (Quadro)
  // L R Lfe Ls Rs
  k41Music = k40Music or kSpeakerLfe; // 4.1 (Quadro or Lfe)
  // L R C Ls Rs
  k50 =      kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs; // 5.0 (ITU 0 or 5 or 0.0 Sound System B)
  // L R C Lfe Ls Rs
  k51 =      k50 or kSpeakerLfe; // 5.1 (ITU 0 or 5 or 0.1 Sound System B)
  // L R C Ls Rs Cs
  k60Cine =  kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerCs;
  // L R C Lfe Ls Rs Cs
  k61Cine =  k60Cine or kSpeakerLfe;
  // L R Ls Rs Sl Sr
  k60Music = kSpeakerL or kSpeakerR or kSpeakerLs or kSpeakerRs or kSpeakerSl or kSpeakerSr;
  // L R Lfe Ls Rs Sl Sr
  k61Music = k60Music or kSpeakerLfe;
  // L R C Ls Rs Lc Rc
  k70Cine =  kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerLc or kSpeakerRc;
  // L R C Lfe Ls Rs Lc Rc
  k71Cine =  k70Cine or kSpeakerLfe;
  k71CineFullFront = k71Cine;
  // L R C Ls Rs Sl Sr
  k70Music = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerSl or kSpeakerSr; // (ITU 0 or 7 or 0.0 Sound System I)
  // L R C Lfe Ls Rs Sl Sr
  k71Music = k70Music or kSpeakerLfe; // (ITU 0 or 7 or 0.1 Sound System I)

  // L R C Lfe Ls Rs Lcs Rcs
  k71CineFullRear = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLfe or kSpeakerLs or kSpeakerRs or kSpeakerLcs or kSpeakerRcs;
  k71CineSideFill = k71Music;
  // L R C Lfe Ls Rs Pl Pr
  k71Proximity = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLfe or kSpeakerLs or kSpeakerRs or kSpeakerPl or kSpeakerPr;

  // L R C Ls Rs Lc Rc Cs
  k80Cine =  kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerLc or kSpeakerRc or kSpeakerCs;
  // L R C Lfe Ls Rs Lc Rc Cs
  k81Cine =  k80Cine or kSpeakerLfe;
  // L R C Ls Rs Cs Sl Sr
  k80Music = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerCs or kSpeakerSl or kSpeakerSr;
  // L R C Lfe Ls Rs Cs Sl Sr
  k81Music = k80Music or kSpeakerLfe;
  // L R C Ls Rs Lc Rc Sl Sr
  k90Cine =  kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerLc or kSpeakerRc or kSpeakerSl or kSpeakerSr;
  // L R C Lfe Ls Rs Lc Rc Sl Sr
  k91Cine =  k90Cine or kSpeakerLfe;
  // L R C Ls Rs Lc Rc Cs Sl Sr
  k100Cine = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerLc or kSpeakerRc or kSpeakerCs or kSpeakerSl or kSpeakerSr;
  // L R C Lfe Ls Rs Lc Rc Cs Sl Sr
  k101Cine = k100Cine or kSpeakerLfe;

  // First-Order with Ambisonic Channel Number (ACN) ordering and SN3D normalization (4 channels)
  kAmbi1stOrderACN = kSpeakerACN0 or kSpeakerACN1 or kSpeakerACN2 or kSpeakerACN3;
  // Second-Order with Ambisonic Channel Number (ACN) ordering and SN3D normalization (9 channels)
  kAmbi2cdOrderACN = kAmbi1stOrderACN or kSpeakerACN4 or kSpeakerACN5 or kSpeakerACN6 or kSpeakerACN7 or kSpeakerACN8;
  // Third-Order with Ambisonic Channel Number (ACN) ordering and SN3D normalization (16 channels)
  kAmbi3rdOrderACN = kAmbi2cdOrderACN or kSpeakerACN9 or kSpeakerACN10 or kSpeakerACN11 or kSpeakerACN12 or kSpeakerACN13 or kSpeakerACN14 or kSpeakerACN15;
  // Fourth-Order with Ambisonic Channel Number (ACN) ordering and SN3D normalization (25 channels)
  kAmbi4thOrderACN = kAmbi3rdOrderACN or kSpeakerACN16 or kSpeakerACN17 or kSpeakerACN18 or kSpeakerACN19 or kSpeakerACN20 or kSpeakerACN21 or kSpeakerACN22 or kSpeakerACN23 or kSpeakerACN24;
  // Fifth-Order with Ambisonic Channel Number (ACN) ordering and SN3D normalization (36 channels)
  kAmbi5thOrderACN = $000FFFFFFFFF;
  // Sixth-Order with Ambisonic Channel Number (ACN) ordering and SN3D normalization (49 channels)
  kAmbi6thOrderACN = $0001FFFFFFFFFFFF;
  // Seventh-Order with Ambisonic Channel Number (ACN) ordering and SN3D normalization (64 channels)
  kAmbi7thOrderACN = $FFFFFFFFFFFFFFFF;

  // 3D formats

  // L R Ls Rs Tfl Tfr Trl Trr    4.0.4
  k80Cube = kSpeakerL or kSpeakerR or kSpeakerLs or kSpeakerRs or kSpeakerTfl or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr;
  k40_4   = k80Cube;
  // L R C Lfe Ls Rs Cs Tc        6.1.1
  k71CineTopCenter = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLfe or kSpeakerLs or kSpeakerRs or kSpeakerCs or kSpeakerTc;
  // L R C Lfe Ls Rs Cs Tfc       6.1.1
  k71CineCenterHigh = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLfe or kSpeakerLs or kSpeakerRs or kSpeakerCs or kSpeakerTfc;
  // L R C Ls Rs Tfl Tfr          5.0.2 (ITU 2 or 5 or 0.0 Sound System C)
  k70CineFrontHigh = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerTfl or kSpeakerTfr;
  k70MPEG3D = k70CineFrontHigh;
  k50_2 = k70CineFrontHigh;
  // L R C Lfe Ls Rs Tfl Tfr      5.1.2 (ITU 2 or 5 or 0.1 Sound System C)
  k71CineFrontHigh = k70CineFrontHigh or kSpeakerLfe;
  k71MPEG3D = k71CineFrontHigh;
  k51_2 = k71CineFrontHigh;
  // L R C Ls Rs Tsl Tsr          5.0.2 (Side)
  k70CineSideHigh = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerTsl or kSpeakerTsr;
  k50_2_TS = k70CineSideHigh;
  // L R C Lfe Ls Rs Tsl Tsr      5.1.2 (Side)
  k71CineSideHigh = k70CineSideHigh  or  kSpeakerLfe;
  k51_2_TS = k71CineSideHigh;
  // L R Lfe Ls Rs Tfl Tfc Tfr Bfc    4.1.3.1
  k81MPEG3D = kSpeakerL or kSpeakerR or kSpeakerLfe or kSpeakerLs or kSpeakerRs or kSpeakerTfl or kSpeakerTfc or kSpeakerTfr or kSpeakerBfc;
  k41_4_1 = k81MPEG3D;

  // L R C Ls Rs Tfl Tfr Trl Trr        5.0.4 (ITU 4 or 5 or 0.0 Sound System D)
  k90 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerTfl or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr;
  k50_4 = k90;
  // L R C Lfe Ls Rs Tfl Tfr Trl Trr    5.1.4
  k91 = k90 or kSpeakerLfe;
  k51_4 = k91;
  // L R C Ls Rs Tfl Tfr Trl Trr Bfc        5.0.4.1 (ITU 4 or 5 or 1.0 Sound System E)
  k50_4_1 = k50_4 or kSpeakerBfc;
  // L R C Lfe Ls Rs Tfl Tfr Trl Trr Bfc    5.1.4.1 (ITU 4 or 5 or 1.1 Sound System E)
  k51_4_1 = k50_4_1 or kSpeakerLfe;

  // L R C Ls Rs Sl Sr Tsl Tsr        7.0.2
  k70_2 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerSl or kSpeakerSr or kSpeakerTsl or kSpeakerTsr;
  // L R C Lfe Ls Rs Sl Sr Tsl Tsr    7.1.2
  k71_2 = k70_2 or kSpeakerLfe;
  k91Atmos = k71_2; // 9.1 Dolby Atmos (3D)
  // L R C Ls Rs Sl Sr Tfl Tfr        7.0.2 (~ITU 2+7+0.0)
  k70_2_TF = k70Music or kSpeakerTfl or kSpeakerTfr;
  // L R C Lfe Ls Rs Sl Sr Tfl Tfr    7.1.2 (~ITU 2+7+0.1)
  k71_2_TF = k70_2_TF or kSpeakerLfe;
  // L R C Ls Rs Sl Sr Tfl Tfr Trc    7.0.3 (ITU 3 or 7 or 0.0 Sound System F)
  k70_3 = k70_2_TF or kSpeakerTrc;
  // L R C Lfe Ls Rs Sl Sr Tfl Tfr Trc Lfe2    7.2.3 (ITU 3 or 7 or 0.2 Sound System F)
  k72_3 = k70_3 or kSpeakerLfe or kSpeakerLfe2;
  // L R C Ls Rs Sl Sr Tfl Tfr Trl Trr         7.0.4 (ITU 4 or 7 or 0.0 Sound System J)
  k70_4 = k70_2_TF or kSpeakerTrl or kSpeakerTrr;
  // L R C Lfe Ls Rs Sl Sr Tfl Tfr Trl Trr     7.1.4 (ITU 4 or 7 or 0.1 Sound System J)
  k71_4 = k70_4 or kSpeakerLfe;
  k111MPEG3D = k71_4;
  // L R C Ls Rs Sl Sr Tfl Tfr Trl Trr Tsl Tsr        7.0.6
  k70_6 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerSl or kSpeakerSr or kSpeakerTfl or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr or kSpeakerTsl or kSpeakerTsr;
  // L R C Lfe Ls Rs Sl Sr Tfl Tfr Trl Trr Tsl Tsr    7.1.6
  k71_6 = k70_6 or kSpeakerLfe;

  // L R C Ls Rs Lc Rc Sl Sr Tfl Tfr Trl Trr                9.0.4 (ITU 4 or 9 or 0.0 Sound System G)
  k90_4 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerLc or kSpeakerRc or kSpeakerSl or kSpeakerSr or kSpeakerTfl or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr;
  // L R C Lfe Ls Rs Lc Rc Sl Sr Tfl Tfr Trl Trr            9.1.4 (ITU 4 or 9 or 0.1 Sound System G)
  k91_4 = k90_4 or kSpeakerLfe;
  // L R C Lfe Ls Rs Lc Rc Sl Sr Tfl Tfr Trl Trr Tsl Tsr    9.0.6
  k90_6 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerLc or kSpeakerRc or kSpeakerSl or kSpeakerSr or kSpeakerTfl or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr or kSpeakerTsl or kSpeakerTsr;
  // L R C Lfe Ls Rs Lc Rc Sl Sr Tfl Tfr Trl Trr Tsl Tsr    9.1.6
  k91_6 = k90_6 or kSpeakerLfe;

  // L R C Ls Rs Sl Sr Tfl Tfr Trl Trr Lw Rw                9.0.4 (Dolby)
  k90_4_W = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerLw or kSpeakerRw or kSpeakerSl or kSpeakerSr or kSpeakerTfl or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr;
  // L R C Lfe Ls Rs Sl Sr Tfl Tfr Trl Trr Lw Rw            9.1.4 (Dolby)
  k91_4_W = k90_4_W or kSpeakerLfe;
  // L R C Ls Rs Sl Sr Tfl Tfr Trl Trr Tsl Tsr Lw Rw        9.0.6 (Dolby)
  k90_6_W = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerLw or kSpeakerRw or kSpeakerSl or kSpeakerSr or kSpeakerTfl or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr or kSpeakerTsl or kSpeakerTsr;
  // L R C Lfe Ls Rs Sl Sr Tfl Tfr Trl Trr Tsl Tsr Lw Rw    9.1.6 (Dolby)
  k91_6_W = k90_6_W or kSpeakerLfe;

  // L R C Ls Rs Tc Tfl Tfr Trl Trr              5.0.5 (10.0 Auro-3D)
  k100 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerTc or kSpeakerTfl or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr;
  k50_5 = k100;
  // L R C Lfe Ls Rs Tc Tfl Tfr Trl Trr          5.1.5 (10.1 Auro-3D)
  k101 = k100 or kSpeakerLfe;
  k101MPEG3D = k101;
  k51_5 = k101;
  // L R C Lfe Ls Rs Tfl Tfc Tfr Trl Trr Lfe2    5.2.5
  k102 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLfe or kSpeakerLs or kSpeakerRs or kSpeakerTfl or kSpeakerTfc or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr or kSpeakerLfe2;
  k52_5 = k102;
  // L R C Ls Rs Tc Tfl Tfc Tfr Trl Trr          5.0.6 (11.0 Auro-3D)
  k110 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerTc or kSpeakerTfl or kSpeakerTfc or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr;
  k50_6 = k110;
  // L R C Lfe Ls Rs Tc Tfl Tfc Tfr Trl Trr      5.1.6 (11.1 Auro-3D)
  k111 = k110 or kSpeakerLfe;
  k51_6 = k111;

  // L R C Lfe Ls Rs Lc Rc Tfl Tfc Tfr Trl Trr Lfe2    7.2.5
  k122 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLfe or kSpeakerLs or kSpeakerRs or kSpeakerLc or kSpeakerRc or kSpeakerTfl or kSpeakerTfc or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr or kSpeakerLfe2;
  k72_5 = k122;
  // L R C Ls Rs Sl Sr Tc Tfl Tfc Tfr Trl Trr          7.0.6 (13.0 Auro-3D)
  k130 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerSl or kSpeakerSr or kSpeakerTc or kSpeakerTfl or kSpeakerTfc or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr;
  // L R C Lfe Ls Rs Sl Sr Tc Tfl Tfc Tfr Trl Trr      7.1.6 (13.1 Auro-3D)
  k131 = k130 or kSpeakerLfe;

  // L R Ls Rs Sl Sr Tfl Tfr Trl Trr Bfl Bfr Brl Brr   6.0.4.4
  k140 = kSpeakerL or kSpeakerR or kSpeakerLs or kSpeakerRs or kSpeakerSl or kSpeakerSr or kSpeakerTfl or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr or kSpeakerBfl or kSpeakerBfr or kSpeakerBrl or kSpeakerBrr;
  k60_4_4 = k140;

  // L R C Ls Rs Lc Rc Cs Sl Sr Tc Tfl Tfc Tfr Trl Trc Trr Tsl Tsr Bfl Bfc Bfr    10.0.9.3 (ITU 9 or 10 or 3.0 Sound System H)
  k220 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerLc or kSpeakerRc or kSpeakerCs or kSpeakerSl or kSpeakerSr or kSpeakerTc or kSpeakerTfl or kSpeakerTfc or kSpeakerTfr or kSpeakerTrl or kSpeakerTrc or kSpeakerTrr or kSpeakerTsl or kSpeakerTsr or kSpeakerBfl or kSpeakerBfc or kSpeakerBfr;
  k100_9_3 = k220;
  // L R C Lfe Ls Rs Lc Rc Cs Sl Sr Tc Tfl Tfc Tfr Trl Trc Trr Lfe2 Tsl Tsr Bfl Bfc Bfr    10.2.9.3 (ITU 9 or 10 or 3.2 Sound System H)
  k222 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLfe or kSpeakerLs or kSpeakerRs or kSpeakerLc or kSpeakerRc or kSpeakerCs or kSpeakerSl or kSpeakerSr or kSpeakerTc or kSpeakerTfl or kSpeakerTfc or kSpeakerTfr or kSpeakerTrl or kSpeakerTrc or kSpeakerTrr or kSpeakerLfe2 or kSpeakerTsl or kSpeakerTsr or kSpeakerBfl or kSpeakerBfc or kSpeakerBfr;
  k102_9_3 = k222;

  // L R C Ls Rs Tfl Tfc Tfr Trl Trr Bfl Bfc Bfr        5.0.5.3
  k50_5_3 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerTfl or kSpeakerTfc or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr or kSpeakerBfl or kSpeakerBfc or kSpeakerBfr;
  // L R C Lfe Ls Rs Tfl Tfc Tfr Trl Trr Bfl Bfc Bfr    5.1.5.3
  k51_5_3 = k50_5_3 or kSpeakerLfe;
  // L R C Ls Rs Tsl Tsr Bfl Bfr                        5.0.2.2
  k50_2_2 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerTsl or kSpeakerTsr or kSpeakerBfl or kSpeakerBfr;
  // L R C Ls Rs Tfl Tfr Trl Trr Bfl Bfr                5.0.4.2
  k50_4_2 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerTfl or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr or kSpeakerBfl or kSpeakerBfr;
  // L R C Ls Rs Sl Sr Tfl Tfr Trl Trr Bfl Bfr          7.0.4.2
  k70_4_2 = k50_4_2 or kSpeakerSl or kSpeakerSr;

  // L R C Ls Rs Tfl Tfc Tfr Trl Trr                5.0.5.0 (Sony 360RA)
  k50_5_Sony = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerTfl or kSpeakerTfc or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr;
  // C Sl Sr Cs Tsl Tsr Bsl Bsr                     4.0.2.2 (Sony 360RA)
  k40_2_2 = kSpeakerC or kSpeakerSl or kSpeakerSr or kSpeakerCs or kSpeakerTsl or kSpeakerTsr or kSpeakerBsl or kSpeakerBsr;
  // L R Ls Rs Tfl Tfr Trl Trr Bfl Bfr              4.0.4.2 (Sony 360RA)
  k40_4_2 = kSpeakerL or kSpeakerR or kSpeakerLs or kSpeakerRs or kSpeakerTfl or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr or kSpeakerBfl or kSpeakerBfr;
  // L R C Ls Rs Tfl Tfc Tfr Bfl Bfr                5.0.3.2 (Sony 360RA)
  k50_3_2 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerTfl or kSpeakerTfc or kSpeakerTfr or kSpeakerBfl or kSpeakerBfr;
  // L R C Tfl Tfc Tfr Trl Trr Bfl Bfr              3.0.5.2 (Sony 360RA)
  k30_5_2 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerTfl or kSpeakerTfc or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr or kSpeakerBfl or kSpeakerBfr;
  // L R Ls Rs Tfl Tfr Trl Trr Bfl Bfr Brl Brr      4.0.4.4 (Sony 360RA)
  k40_4_4 = kSpeakerL or kSpeakerR or kSpeakerLs or kSpeakerRs or kSpeakerTfl or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr or kSpeakerBfl or kSpeakerBfr or kSpeakerBrl or kSpeakerBrr;
  // L R C Ls Rs Tfl Tfr Trl Trr Bfl Bfr Brl Brr    5.0.4.4 (Sony 360RA)
  k50_4_4 = kSpeakerL or kSpeakerR or kSpeakerC or kSpeakerLs or kSpeakerRs or kSpeakerTfl or kSpeakerTfr or kSpeakerTrl or kSpeakerTrr or kSpeakerBfl or kSpeakerBfr or kSpeakerBrl or kSpeakerBrr;


  // Speaker Arrangement String Representation.

  kStringMono       = 'Mono';
  kStringStereo     = 'Stereo';
  kStringStereoWide = 'Stereo (Lw Rw)';
  kStringStereoR    = 'Stereo (Ls Rs)';
  kStringStereoC    = 'Stereo (Lc Rc)';
  kStringStereoSide = 'Stereo (Sl Sr)';
  kStringStereoCLfe = 'Stereo (C LFE)';
  kStringStereoTF   = 'Stereo (Tfl Tfr)';
  kStringStereoTS   = 'Stereo (Tsl Tsr)';
  kStringStereoTR   = 'Stereo (Trl Trr)';
  kStringStereoBF   = 'Stereo (Bfl Bfr)';
  kStringCineFront  = 'Cine Front';
  kString30Cine     = 'LRC';
  kString30Music    = 'LRS';
  kString31Cine     = 'LRC+LFE';
  kString31Music    = 'LRS+LFE';
  kString40Cine     = 'LRCS';
  kString40Music    = 'Quadro';
  kString41Cine     = 'LRCS+LFE';
  kString41Music    = 'Quadro+LFE';
  kString50         = '5.0';
  kString51         = '5.1';
  kString60Cine     = '6.0 Cine';
  kString60Music    = '6.0 Music';
  kString61Cine     = '6.1 Cine';
  kString61Music    = '6.1 Music';
  kString70Cine     = '7.0 SDDS';
  kString70CineOld  = '7.0 Cine (SDDS)';
  kString70Music    = '7.0';
  kString70MusicOld = '7.0 Music (Dolby)';
  kString71Cine     = '7.1 SDDS';
  kString71CineOld  = '7.1 Cine (SDDS)';
  kString71Music    = '7.1';
  kString71MusicOld = '7.1 Music (Dolby)';
  kString71CineTopCenter  = '7.1 Cine Top Center';
  kString71CineCenterHigh = '7.1 Cine Center High';
  kString71CineFullRear   = '7.1 Cine Full Rear';
  kString51_2 = '5.1.2';
  kString50_2 = '5.0.2';
  kString50_2TopSide = '5.0.2 Top Side';
  kString51_2TopSide = '5.1.2 Top Side';
  kString71Proximity = '7.1 Proximity';
  kString80Cine  = '8.0 Cine';
  kString80Music = '8.0 Music';
  kString40_4    = '8.0 Cube';
  kString81Cine  = '8.1 Cine';
  kString81Music = '8.1 Music';
  kString90Cine  = '9.0 Cine';
  kString91Cine  = '9.1 Cine';
  kString100Cine = '10.0 Cine';
  kString101Cine = '10.1 Cine';
  kString52_5 = '5.2.5';
  kString72_5 = '12.2';
  kString50_4 = '5.0.4';
  kString51_4 = '5.1.4';
  kString50_4_1 = '5.0.4.1';
  kString51_4_1 = '5.1.4.1';
  kString70_2 = '7.0.2';
  kString71_2 = '7.1.2';
  kString70_2_TF = '7.0.2 Top Front';
  kString71_2_TF = '7.1.2 Top Front';
  kString70_3 = '7.0.3';
  kString72_3 = '7.2.3';
  kString70_4 = '7.0.4';
  kString71_4 = '7.1.4';
  kString70_6 = '7.0.6';
  kString71_6 = '7.1.6';
  kString90_4 = '9.0.4 ITU';
  kString91_4 = '9.1.4 ITU';
  kString90_6 = '9.0.6 ITU';
  kString91_6 = '9.1.6 ITU';
  kString90_4_W = '9.0.4';
  kString91_4_W = '9.1.4';
  kString90_6_W = '9.0.6';
  kString91_6_W = '9.1.6';
  kString50_5 = '10.0 Auro-3D';
  kString51_5 = '10.1 Auro-3D';
  kString50_6 = '11.0 Auro-3D';
  kString51_6 = '11.1 Auro-3D';
  kString130  = '13.0 Auro-3D';
  kString131  = '13.1 Auro-3D';
  kString41_4_1 = '8.1 MPEG';
  kString60_4_4 = '14.0';
  kString220    = '22.0';
  kString222    = '22.2';
  kString50_5_3 = '5.0.5.3';
  kString51_5_3 = '5.1.5.3';
  kString50_2_2 = '5.0.2.2';
  kString50_4_2 = '5.0.4.2';
  kString70_4_2 = '7.0.4.2';
  kString50_5_Sony = '5.0.5 Sony';
  kString40_2_2 = '4.0.3.2';
  kString40_4_2 = '4.0.4.2';
  kString50_3_2 = '5.0.3.2';
  kString30_5_2 = '3.0.5.2';
  kString40_4_4 = '4.0.4.4';
  kString50_4_4 = '5.0.4.4';
  kStringAmbi1stOrder = '1OA';
  kStringAmbi2cdOrder = '2OA';
  kStringAmbi3rdOrder = '3OA';
  kStringAmbi4thOrder = '4OA';
  kStringAmbi5thOrder = '5OA';
  kStringAmbi6thOrder = '6OA';
  kStringAmbi7thOrder = '7OA';

  // Speaker Arrangement String Representation with Speakers Name.

  kStringMonoS       = 'M';
  kStringStereoS     = 'L R';
  kStringStereoWideS = 'Lw Rw';
  kStringStereoRS    = 'Ls Rs';
  kStringStereoCS    = 'Lc Rc';
  kStringStereoSS    = 'Sl Sr';
  kStringStereoCLfeS = 'C LFE';
  kStringStereoTFS   = 'Tfl Tfr';
  kStringStereoTSS   = 'Tsl Tsr';
  kStringStereoTRS   = 'Trl Trr';
  kStringStereoBFS   = 'Bfl Bfr';
  kStringCineFrontS  = 'L R C Lc Rc';
  kString30CineS     = 'L R C';
  kString30MusicS    = 'L R S';
  kString31CineS     = 'L R C LFE';
  kString31MusicS    = 'L R LFE S';
  kString40CineS     = 'L R C S';
  kString40MusicS    = 'L R Ls Rs';
  kString41CineS     = 'L R C LFE S';
  kString41MusicS    = 'L R LFE Ls Rs';
  kString50S         = 'L R C Ls Rs';
  kString51S         = 'L R C LFE Ls Rs';
  kString60CineS     = 'L R C Ls Rs Cs';
  kString60MusicS    = 'L R Ls Rs Sl Sr';
  kString61CineS     = 'L R C LFE Ls Rs Cs';
  kString61MusicS    = 'L R LFE Ls Rs Sl Sr';
  kString70CineS     = 'L R C Ls Rs Lc Rc';
  kString70MusicS    = 'L R C Ls Rs Sl Sr';
  kString71CineS     = 'L R C LFE Ls Rs Lc Rc';
  kString71MusicS    = 'L R C LFE Ls Rs Sl Sr';
  kString80CineS     = 'L R C Ls Rs Lc Rc Cs';
  kString80MusicS    = 'L R C Ls Rs Cs Sl Sr';
  kString81CineS     = 'L R C LFE Ls Rs Lc Rc Cs';
  kString81MusicS    = 'L R C LFE Ls Rs Cs Sl Sr';
  kString40_4S       = 'L R Ls Rs Tfl Tfr Trl Trr';
  kString71CineTopCenterS  = 'L R C LFE Ls Rs Cs Tc';
  kString71CineCenterHighS = 'L R C LFE Ls Rs Cs Tfc';
  kString71CineFullRearS   = 'L R C LFE Ls Rs Lcs Rcs';
  kString50_2S             = 'L R C Ls Rs Tfl Tfr';
  kString51_2S             = 'L R C LFE Ls Rs Tfl Tfl';
  kString50_2TopSideS      = 'L R C Ls Rs Tsl Tsr';
  kString51_2TopSideS      = 'L R C LFE Ls Rs Tsl Tsr';
  kString71ProximityS      = 'L R C LFE Ls Rs Pl Pr';
  kString90CineS  = 'L R C Ls Rs Lc Rc Sl Sr';
  kString91CineS  = 'L R C LFE Ls Rs Lc Rc Sl Sr';
  kString100CineS = 'L R C Ls Rs Lc Rc Cs Sl Sr';
  kString101CineS = 'L R C LFE Ls Rs Lc Rc Cs Sl Sr';
  kString50_4S    = 'L R C Ls Rs Tfl Tfr Trl Trr';
  kString51_4S    = 'L R C LFE Ls Rs Tfl Tfr Trl Trr';
  kString50_4_1S  = 'L R C Ls Rs Tfl Tfr Trl Trr Bfc';
  kString51_4_1S  = 'L R C LFE Ls Rs Tfl Tfr Trl Trr Bfc';
  kString70_2S    = 'L R C Ls Rs Sl Sr Tsl Tsr';
  kString71_2S    = 'L R C LFE Ls Rs Sl Sr Tsl Tsr';
  kString70_2_TFS = 'L R C Ls Rs Sl Sr Tfl Tfr';
  kString71_2_TFS = 'L R C LFE Ls Rs Sl Sr Tfl Tfr';
  kString70_3S    = 'L R C Ls Rs Sl Sr Tfl Tfr Trc';
  kString72_3S    = 'L R C LFE Ls Rs Sl Sr Tfl Tfr Trc LFE2';
  kString70_4S    = 'L R C Ls Rs Sl Sr Tfl Tfr Trl Trr';
  kString71_4S    = 'L R C LFE Ls Rs Sl Sr Tfl Tfr Trl Trr';
  kString70_6S    = 'L R C Ls Rs Sl Sr Tfl Tfr Trl Trr Tsl Tsr';
  kString71_6S    = 'L R C LFE Ls Rs Sl Sr Tfl Tfr Trl Trr Tsl Tsr';
  kString90_4S    = 'L R C Ls Rs Lc Rc Sl Sr Tfl Tfr Trl Trr';
  kString91_4S    = 'L R C LFE Ls Rs Lc Rc Sl Sr Tfl Tfr Trl Trr';
  kString90_6S    = 'L R C Ls Rs Lc Rc Sl Sr Tfl Tfr Trl Trr Tsl Tsr';
  kString91_6S    = 'L R C LFE Ls Rs Lc Rc Sl Sr Tfl Tfr Trl Trr Tsl Tsr';
  kString90_4_WS	= 'L R C Ls Rs Sl Sr Tfl Tfr Trl Trr Lw Rw';
  kString91_4_WS	= 'L R C LFE Ls Rs Sl Sr Tfl Tfr Trl Trr Lw Rw';
  kString90_6_WS	= 'L R C Ls Rs Sl Sr Tfl Tfr Trl Trr Tsl Tsr Lw Rw';
  kString91_6_WS	= 'L R C LFE Ls Rs Sl Sr Tfl Tfr Trl Trr Tsl Tsr Lw Rw';
  kString50_5S    = 'L R C Ls Rs Tc Tfl Tfr Trl Trr';
  kString51_5S    = 'L R C LFE Ls Rs Tc Tfl Tfr Trl Trr';
  kString50_5_SonyS = 'L R C Ls Rs Tfl Tfc Tfr Trl Trr';
  kString50_6S    = 'L R C Ls Rs Tc Tfl Tfc Tfr Trl Trr';
  kString51_6S    = 'L R C LFE Ls Rs Tc Tfl Tfc Tfr Trl Trr';
  kString130S     = 'L R C Ls Rs Sl Sr Tc Tfl Tfc Tfr Trl Trr';
  kString131S     = 'L R C LFE Ls Rs Sl Sr Tc Tfl Tfc Tfr Trl Trr';
  kString52_5S    = 'L R C LFE Ls Rs Tfl Tfc Tfr Trl Trr LFE2';
  kString72_5S    = 'L R C LFE Ls Rs Lc Rc Tfl Tfc Tfr Trl Trr LFE2';
  kString41_4_1S  = 'L R LFE Ls Rs Tfl Tfc Tfr Bfc';
  kString30_5_2S  = 'L R C Tfl Tfc Tfr Trl Trr Bfl Bfr';
  kString40_2_2S  = 'C Sl Sr Cs Tfc Tsl Tsr Trc';
  kString40_4_2S  = 'L R Ls Rs Tfl Tfr Trl Trr Bfl Bfr';
  kString40_4_4S  = 'L R Ls Rs Tfl Tfr Trl Trr Bfl Bfr Brl Brr';
  kString50_4_4S  = 'L R C Ls Rs Tfl Tfr Trl Trr Bfl Bfr Brl Brr';
  kString60_4_4S  = 'L R Ls Rs Sl Sr Tfl Tfr Trl Trr Bfl Bfr Brl Brr';
  kString50_5_3S  = 'L R C Ls Rs Tfl Tfc Tfr Trl Trr Bfl Bfc Bfr';
  kString51_5_3S  = 'L R C LFE Ls Rs Tfl Tfc Tfr Trl Trr Bfl Bfc Bfr';
  kString50_2_2S  = 'L R C Ls Rs Tsl Tsr Bfl Bfr';
  kString50_3_2S  = 'L R C Ls Rs Tfl Tfc Tfr Bfl Bfr';
  kString50_4_2S  = 'L R C Ls Rs Tfl Tfr Trl Trr Bfl Bfr';
  kString70_4_2S  = 'L R C Ls Rs Sl Sr Tfl Tfr Trl Trr Bfl Bfr';
  kString222S     = 'L R C LFE Ls Rs Lc Rc Cs Sl Sr Tc Tfl Tfc Tfr Trl Trc Trr LFE2 Tsl Tsr Bfl Bfc Bfr';
  kString220S     = 'L R C Ls Rs Lc Rc Cs Sl Sr Tc Tfl Tfc Tfr Trl Trc Trr Tsl Tsr Bfl Bfc Bfr';
  kStringAmbi1stOrderS = '0 1 2 3';
  kStringAmbi2cdOrderS = '0 1 2 3 4 5 6 7 8';
  kStringAmbi3rdOrderS = '0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15';
  kStringAmbi4thOrderS = '0..24';
  kStringAmbi5thOrderS = '0..35';
  kStringAmbi6thOrderS = '0..48';
  kStringAmbi7thOrderS = '0..63';

  // Controller Numbers (MIDI)

  kCtrlBankSelectMSB = 0; // Bank Select MSB
  kCtrlModWheel = 1;      // Modulation Wheel
  kCtrlBreath = 2;        // Breath controller
  kCtrlFoot = 4;          // Foot Controller
  kCtrlPortaTime = 5;     // Portamento Time
  kCtrlDataEntryMSB = 6;  // Data Entry MSB
  kCtrlVolume = 7;        // Channel Volume (formerly Main Volume)
  kCtrlBalance = 8;       // Balance
  kCtrlPan = 10;          // Pan
  kCtrlExpression = 11;   // Expression
  kCtrlEffect1 = 12;      // Effect Control 1
  kCtrlEffect2 = 13;      // Effect Control 2

  //---General Purpose Controllers #1 to #4---

  kCtrlGPC1 = 16; // General Purpose Controller #1
  kCtrlGPC2 = 17; // General Purpose Controller #2
  kCtrlGPC3 = 18; // General Purpose Controller #3
  kCtrlGPC4 = 19; // General Purpose Controller #4
  kCtrlBankSelectLSB = 32;    // Bank Select LSB
  kCtrlDataEntryLSB = 38;     // Data Entry LSB
  kCtrlSustainOnOff = 64;     // Damper Pedal On/Off (Sustain)
  kCtrlPortaOnOff  = 65;      // Portamento On/Off
  kCtrlSustenutoOnOff = 66;   // Sustenuto On/Off
  kCtrlSoftPedalOnOff = 67;   // Soft Pedal On/Off
  kCtrlLegatoFootSwOnOff= 68; // Legato Footswitch On/Off
  kCtrlHold2OnOff  = 69;      // Hold 2 On/Off

  //---Sound Controllers #1 to #10---

  kCtrlSoundVariation = 70; // Sound Variation
  kCtrlFilterCutoff = 71;   // Filter Cutoff (Timbre/Harmonic Intensity)
  kCtrlReleaseTime = 72;    // Release Time
  kCtrlAttackTime  = 73;    // Attack Time
  kCtrlFilterResonance= 74; // Filter Resonance (Brightness)
  kCtrlDecayTime  = 75;     // Decay Time
  kCtrlVibratoRate = 76;    // Vibrato Rate
  kCtrlVibratoDepth = 77;   // Vibrato Depth
  kCtrlVibratoDelay = 78;   // Vibrato Delay
  kCtrlSoundCtrler10 = 79;  // undefined

  //---General Purpose Controllers #5 to #8---

  kCtrlGPC5 = 80; // General Purpose Controller #5
  kCtrlGPC6 = 81; // General Purpose Controller #6
  kCtrlGPC7 = 82; // General Purpose Controller #7
  kCtrlGPC8 = 83; // General Purpose Controller #8
  kCtrlPortaControl = 84; // Portamento Control

  //---Effect Controllers---

  kCtrlEff1Depth = 91; // Effect 1 Depth (Reverb Send Level)
  kCtrlEff2Depth = 92; // Effect 2 Depth (Tremolo Level)
  kCtrlEff3Depth = 93; // Effect 3 Depth (Chorus Send Level)
  kCtrlEff4Depth = 94; // Effect 4 Depth (Delay/Variation/Detune Level)
  kCtrlEff5Depth = 95; // Effect 5 Depth (Phaser Level)
  kCtrlDataIncrement = 96; // Data Increment (+1)
  kCtrlDataDecrement = 97; // Data Decrement (-1)
  kCtrlNRPNSelectLSB = 98; // NRPN Select LSB
  kCtrlNRPNSelectMSB = 99; // NRPN Select MSB
  kCtrlRPNSelectLSB = 100; // RPN Select LSB
  kCtrlRPNSelectMSB = 101; // RPN Select MSB

  //---Other Channel Mode Messages---

  kCtrlAllSoundsOff = 120;    // All Sounds Off
  kCtrlResetAllCtrlers = 121; // Reset All Controllers
  kCtrlLocalCtrlOnOff = 122;  // Local Control On/Off
  kCtrlAllNotesOff = 123;     // All Notes Off
  kCtrlOmniModeOff = 124;     // Omni Mode Off + All Notes Off
  kCtrlOmniModeOn = 125;      // Omni Mode On  + All Notes Off
  kCtrlPolyModeOnOff = 126;   // Poly Mode On/Off + All Sounds Off
  kCtrlPolyModeOn  = 127;     // Poly Mode On

  //---Extra--------------------------

  kAfterTouch = 128; // After Touch (associated to Channel Pressure)
  kPitchBend = 129;  // Pitch Bend Change
  kCountCtrlNumber = 130; // Count of Controller Number

  //---Extra for kLegacyMIDICCOutEvent-

  kCtrlProgramChange = 130; // Program Change (use LegacyMIDICCOutEvent.value only)
  // Polyphonic Key Pressure (use LegacyMIDICCOutEvent.value for pitch and
  // LegacyMIDICCOutEvent.value2 for pressure)
  kCtrlPolyPressure = 131;
  kCtrlQuarterFrame = 132;  // Quarter Frame ((use LegacyMIDICCOutEvent.value only)

type
  PViewRect = ^TViewRect;
  { TViewRect }
  // Graphical rectangle structure. Used with IPlugView.
  TViewRect = record
    Left:Int32;
    Top:Int32;
    Right:Int32;
    Bottom:Int32;
    constructor Create(AWidth,AHeight:Int32);
    function GetWidth:Int32;inline;
    function GetHeight:Int32;inline;
    property Width:Int32 read GetWidth;
    property Height:Int32 read GetHeight;
  end;

const
  // List of Platform UI types for IPlugView. This list is used to match the GUI-System between
  // the host and a plug-in in case that an OS provides multiple GUI-APIs.

  // The parent parameter in IPlugView::attached() is a HWND handle.
  // You should attach a child window to it.
  kPlatformTypeHWND = 'HWND'; // HWND handle. (Microsoft Windows)

  // The parent parameter in IPlugView::attached() is a WindowRef.
  // You should attach a HIViewRef to the content view of the window.
  kPlatformTypeHIView = 'HIView'; // HIViewRef. (Mac OS X)

  // The parent parameter in IPlugView::attached() is a NSView pointer.
  // You should attach a NSView to it.
  kPlatformTypeNSView = 'NSView'; // NSView pointer. (Mac OS X)

  // The parent parameter in IPlugView::attached() is a UIView pointer.
  // You should attach an UIView to it.
  kPlatformTypeUIView = 'UIView'; // UIView pointer. (iOS)

  // The parent parameter in IPlugView::attached() is a X11 Window supporting XEmbed.
  // You should attach a Window to it that supports the XEmbed extension.
  // See https://standards.freedesktop.org/xembed-spec/xembed-spec-latest.html
  kPlatformTypeX11EmbedWindowID = 'X11EmbedWindowID'; // X11 Window ID. (X11)

type
  IPlugFrame = interface; // forward

  // Plug-in definition of a view.
  // - [plug imp]
  // - [released: 3.0.0]
  // Sizing of a view
  // Usually, the size of a plug-in view is fixed. But both the host and the plug-in can cause
  // a view to be resized:
  // - Host: If IPlugView::canResize () returns kResultTrue the host will set up the window
  //   so that the user can resize it. While the user resizes the window,
  //   IPlugView::checkSizeConstraint () is called, allowing the plug-in to change the size to a valid
  //   a valid supported rectangle size. The host then resizes the window to this rect and has to call IPlugView::onSize ().
  // - Plug-in: The plug-in can call IPlugFrame::resizeView () and cause the host to resize the window.
  //   Afterwards, in the same callstack, the host has to call IPlugView::onSize () if a resize is needed (size was changed).
  //   Note that if the host calls IPlugView::getSize () before calling IPlugView::onSize () (if needed),
  //   it will get the current (old) size not the wanted one!!
  //   Here the calling sequence:
  //   - plug-in->host: IPlugFrame::resizeView (newSize)
  //   - host->plug-in (optional): IPlugView::getSize () returns the currentSize (not the newSize!)
  //   - host->plug-in: if newSize is different from the current size: IPlugView::onSize (newSize)
  //   - host->plug-in (optional): IPlugView::getSize () returns the newSize
  // Please only resize the platform representation of the view when IPlugView::onSize () is called.
  // Keyboard handling
  // The plug-in view receives keyboard events from the host. A view implementation must not handle
  // keyboard events by the means of platform callbacks, but let the host pass them to the view. The host
  // depends on a proper return value when IPlugView::onKeyDown is called, otherwise the plug-in view may
  // cause a malfunction of the host's key command handling.
  IPlugView = interface(FUnknown) [GUID_IPlugView]
    // Is Platform UI Type supported
    // param type : IDString of platformUIType
    function IsPlatformTypeSupported(&Type:FIDString):tresult; winapi;
    // The parent window of the view has been created, the (platform) representation of the view
    // should now be created as well.
    // Note that the parent is owned by the caller and you are not allowed to alter it in any way
    // other than adding your own views.
    // Note that in this call the plug-in could call a IPlugFrame::resizeView ()!
    // param parent : platform handle of the parent window or view
    // param type : platformUIType which should be created
    function Attached(Parent:Pointer; &Type:FIDString):tresult; winapi;
    // The parent window of the view is about to be destroyed.
    // You have to remove all your own views from the parent window or view.
    function Removed:tresult; winapi;
    // Handling of mouse wheel.
    function OnWheel(Distance:Single):tresult; winapi;
    // Handling of keyboard events : Key Down.
    // param key : unicode code of key
    // param keyCode : virtual keycode for non ascii keys - see VirtualKeyCodes
    // param modifiers : any combination of modifiers - see KeyModifier
    // return kResultTrue if the key is handled, otherwise kResultFalse
    // Please note that kResultTrue must only be returned if the key has really been handled.
    // Otherwise key command handling of the host might be blocked!
    function OnKeyDown(key:Char16; KeyCode,Modifiers:Int16):tresult; winapi;
    // Handling of keyboard events : Key Up.
    // param key : unicode code of key
    // param keyCode : virtual keycode for non ascii keys - see VirtualKeyCodes
    // param modifiers : any combination of KeyModifier - see KeyModifier
    // return kResultTrue if the key is handled, otherwise return kResultFalse.
    function OnKeyUp(key:Char16; KeyCode,Modifiers:Int16):tresult; winapi;
    // Returns the size of the platform representation of the view.
    function GetSize(size:PViewRect):tresult; winapi;
    // Resizes the platform representation of the view to the given rect. Note that if the plug-in
    // requests a resize (IPlugFrame::resizeView ()) onSize has to be called afterward.
    function OnSize(NewSize:PViewRect):tresult; winapi;
    // Focus changed message.
    function OnFocus(state:TBool):tresult; winapi;
    // Sets IPlugFrame object to allow the plug-in to inform the host about resizing.
    function SetFrame(frame:IPlugFrame):tresult; winapi;
    // Is view sizable by user.
    function CanResize:tresult; winapi;
    // On live resize this is called to check if the view can be resized to the given rect, if not
    // adjust the rect to the allowed size.
    function CheckSizeConstraint(rect:PViewRect):tresult; winapi;
  end;

  // Callback interface passed to IPlugView.
  // - [host imp]
  // - [released: 3.0.0]
  // - [mandatory]
  // Enables a plug-in to resize the view and cause the host to resize the window.
  IPlugFrame = interface(FUnknown) [GUID_IPlugFrame]
    function ResizeView(view:IPlugView;NewSize:PViewRect):tresult; winapi;
  end;

{$ifdef linux}
  TimerInterval  = UInt64;
  FileDescriptor = Integer;

  // Linux event handler interface
  // - [plug imp]
  // - [released: 3.6.8]
  IEventHandler = interface(FUnknown) [GUID_IEventHandler]
    procedure OnFDIsSet(fd:FileDescriptor); winapi;
  end;

  // Linux timer handler interface
  // - [plug imp]
  // - [released: 3.6.8]
  ITimerHandler = interface(FUnknown) [GUID_ITimerHandler]
    procedure OnTimer; winapi;
  end;

  // Linux host run loop interface
  // - [host imp]
  // - [extends IPlugFrame]
  // - [released: 3.6.8]
  // On Linux the host has to provide this interface to the plug-in as there's no global event run loop
  // defined as on other platforms.
  // This can be done by IPlugFrame and the context which is passed to the plug-in as an argument
  // in the method IPlugFactory3::setHostContext. This way the plug-in can get a runloop even if
  // it does not have an editor.
  // A plug-in can register an event handler for a file descriptor. The host has to call the event
  // handler when the file descriptor is marked readable.
  // A plug-in also can register a timer which will be called repeatedly until it is unregistered.
  IRunLoop = interface(FUnknown) [GUID_IRunLoop]
    function RegisterEventHandler(handler:IEventHandler; fd:FileDescriptor):TResult; winapi;
    function UnregisterEventHandler(handler:IEventHandler):TResult; winapi;
    function RegisterTimer(handler:ITimerHandler; milliseconds:TimerInterval):TResult; winapi;
    function UnregisterTimer(handler:ITimerHandler):TResult; winapi;
  end;
{$endif linux}

type
  TScaleFactor = Single;

  // Plug-in view content scale support
  // - [plug impl]
  // - [extends IPlugView]
  // - [released: 3.6.6]
  // - [optional]
  // This interface communicates the content scale factor from the host to the plug-in view on
  // systems where plug-ins cannot get this information directly like Microsoft Windows.
  // The host calls setContentScaleFactor directly before or after the plug-in view is attached and when
  // the scale factor changes while the view is attached (system change or window moved to another screen
  // with different scaling settings).
  // The host may call setContentScaleFactor in a different context, for example: scaling the plug-in
  // editor for better readability.
  // When a plug-in handles this (by returning kResultTrue), it needs to scale the width and height of
  // its view by the scale factor and inform the host via a IPlugFrame::resizeView(). The host will then
  // call IPlugView::onSize().
  // Note that the host is allowed to call setContentScaleFactor() at any time the IPlugView is valid.
  // If this happens before the IPlugFrame object is set on your view, make sure that when the host calls
  // IPlugView::getSize() afterwards you return the size of your view for that new scale factor.
  // It is recommended to implement this interface on Microsoft Windows to let the host know that the
  // plug-in is able to render in different scalings.
  IPlugViewContentScaleSupport = interface(FUnknown) [GUID_IPlugViewContentScaleSupport]
    function SetContentScaleFactor(Factor:TScaleFactor):tresult; winapi;
  end;

// Pack records
{$ifdef FPC} {$push} {$endif}
{$if defined(DARWIN) or defined(MACOS)}
  {$if defined(CPU64BITS) or defined(CPU64)}
    {$Align 16}
  {$else}
    {$A1}
  {$endif}
{$elseif defined(MSWINDOWS)}
  {$if defined(CPU64BITS) or defined(CPU64)}
    {$Align 16}
  {$else}
    {$A8}
  {$endif}
{$endif}

const
  // Bus media types

  kAudio = 0; // audio
  kEvent = 1; // events
  kNumMediaTypes = 2;

  // Bus directions

  kInput  = 0;  // input bus
  kOutput = 1;  // output bus

  // Bus Types

  kMain = 0;  // main bus
  kAux  = 1;  // auxiliary bus (sidechain)

  // I/O modes

  kSimple   = 0; // 1:1 Input / Output. Only used for Instruments. See vst3IoMode
  kAdvanced = 1; // n:m Input / Output. Only used for Instruments.
  kOfflineProcessing = 2;  // plug-in used in an offline processing context

  // Bus flags

  // The bus should be activated by the host per default on instantiation (activateBus call is requested).
  // By default a bus is inactive.
  kDefaultActive = 1 shl 0;
  // The bus does not contain ordinary audio data, but data used for control changes at sample rate.
  // The data is in the same format as the audio data [-1..1].
  // A host has to prevent unintended routing to speakers to prevent damage.
  // Only valid for audio media type busses.
  // [released: 3.7.0]
  kIsControlVoltage = 1 shl 1;

type
  // This is the structure used with getBusInfo, informing the host about what is a specific given bus.
  TBusInfo = record
    MediaType:TMediaType;    // Media type - has to be a value of MediaTypes
    Direction:TBusDirection; // input or output BusDirections
    // number of channels (if used then need to be recheck after
    // IAudioProcessor::setBusArrangements is called).
    // For a bus of type MediaTypes::kEvent the channelCount corresponds
    // to the number of supported MIDI channels by this bus
    ChannelCount:Int32;
    Name:TString128; // name of the bus
    BusType:TBusType; // main or aux - has to be a value of BusTypes
    Flags:UInt32;  // flags - a combination of BusFlags
  end;

  // Routing Information:
  // When the plug-in supports multiple I/O busses, a host may want to know how the busses are related. The
  // relation of an event-input-channel to an audio-output-bus in particular is of interest to the host
  // (in order to relate MIDI-tracks to audio-channels)
  TRoutingInfo = record
    MediaType:TMediaType; // media type see MediaTypes
    BusIndex:Int32;  // bus index
    Channel:Int32;   // channel (-1 for all channels)
  end;

  // Component base interface: Vst::IComponent
  // - [plug imp]
  // - [released: 3.0.0]
  // - [mandatory]
  // This is the basic interface for a VST component and must always be supported.
  // It contains the common parts of any kind of processing class. The parts that
  // are specific to a media type are defined in a separate interface. An implementation
  // component must provide both the specific interface and IComponent.
  IComponent = interface(IPluginBase) [GUID_IComponent]
    // Called before initializing the component to get information about the controller class.
    function GetControllerClassID(classid:PGuid):tresult; winapi;
    // Called before 'initialize' to set the component usage (optional). See IoModes
    function SetIOMode(kIOMode:TIOMode):tresult; winapi;
    // Called after the plug-in is initialized. See MediaTypes, BusDirections
    function GetBusCount(kMedia:TMediaType; kBusDir:TBusDirection):Int32; winapi;
    // Called after the plug-in is initialized. See MediaTypes, BusDirections
    function GetBusInfo(kMedia:TMediaType; kBusDir:TBusDirection; index:Int32; var info:TBusInfo):tresult; winapi;
    // Retrieves routing information (to be implemented when more than one regular input or output bus exists).
    // The inInfo always refers to an input bus while the returned outInfo must refer to an output bus!
    function GetRoutingInfo(var ininfo:TRoutingInfo; var outinfo:TRoutingInfo):tresult; winapi;
    // Called upon (de-)activating a bus in the host application. The plug-in should only processed
    // an activated bus, the host could provide less see AudioBusBuffers in the process call
    // (see IAudioProcessor::process) if last busses are not activated. An already activated bus
    // does not need to be reactivated after a IAudioProcessor::setBusArrangements call.
    function ActivateBus(kMedia:TMediaType; kBusDir:TBusDirection; index:Int32; state:TBool):tresult; winapi;
    // Activates / deactivates the component.
    function SetActive(state:TBool):tresult; winapi;
    // Sets complete state of component.
    function SetState(state:IBStream):tresult; winapi;
    // Retrieves complete state of component.
    function GetState(state:IBStream):tresult; winapi;
  end;

const
  // Class Category Name for Controller Component
  kVstComponentControllerClass = 'Component Controller Class';
  kViewTypeEditor = 'editor';

  // No flags wanted.
  // [SDK 3.0.0]
  kNoFlags = 0;
  // Parameter can be automated.
  // [SDK 3.0.0]
  kCanAutomate = 1 shl 0;
  // Parameter cannot be changed from outside the plug-in
  // (implies that kCanAutomate is NOT set).
  // [SDK 3.0.0]
  kIsReadOnly = 1 shl 1;
  // Attempts to set the parameter value out of the limits will result in a wrap around.
  // [SDK 3.0.2]
  kIsWrapAround = 1 shl 2;
  // Parameter should be displayed as list in generic editor or automation editing.
  // [SDK 3.1.0]
  kIsList = 1 shl 3;
  // Parameter should be NOT displayed and cannot be changed from outside the plug-in
  // (implies that kCanAutomate is NOT set and kIsReadOnly is set).
  // [SDK 3.7.0]
  kIsHidden = 1 shl 4;
  // Parameter is a program change (unitId gives info about associated unit - see vst3ProgramLists).
  // [SDK 3.0.0]
  kIsProgramChange = 1 shl 15;
  // Special bypass parameter (only one allowed): plug-in can handle bypass.
  // Highly recommended to export a bypass parameter for effect plug-in.
  // [SDK 3.0.0]
  kIsBypass = 1 shl 16;

type
  // Controller Parameter Info.
  // A parameter info describes a parameter of the controller.
  // The id must always be the same for a parameter as this uniquely identifies the parameter.
  TParameterInfo = record
    ID:TParamID;     // unique identifier of this parameter (named tag too)
    Title:TString128; // parameter title (e.g. "Volume")
    ShortTitle:TString128; // parameter shortTitle (e.g. "Vol")
    Units:TString128; // parameter unit (e.g. "dB")
    // number of discrete steps (0: continuous, 1: toggle, discrete value otherwise
    // (corresponding to max - min, for example: 127 for a min = 0 and a max = 127)
    // see vst3ParameterIntro)
    StepCount:Int32;
    // default normalized value [0,1] (in case of discrete value:
    // defaultNormalizedValue = defDiscreteValue / stepCount)
    DefaultNormalizedValue:TParamValue;
    UnitID:TUnitID;  // id of unit this parameter belongs to (see vst3Units)
    Flags:Int32;
  end;

const
  // The Component should be reloaded
  // The host has to unload completely the plug-in (controller/processor) and reload it.
  // [SDK 3.0.0]
  kReloadComponent = 1 shl 0;
  // Input / Output Bus configuration has changed
  // The plug-in informs the host that either the bus configuration or the bus count has changed.
  // The host has to deactivate the plug-in, asks the plug-in for its wanted new bus configurations,
  // adapts its processing graph and reactivate the plug-in.
  // [SDK 3.0.0]
  kIOChanged = 1 shl 1;
  // Multiple parameter values have changed  (as result of a program change for example)
  // The host invalidates all caches of parameter values and asks the edit controller for the current values.
  // [SDK 3.0.0]
  kParamValuesChanged = 1 shl 2;
  // Latency has changed
  // The plug informs the host that its latency has changed, getLatencySamples should
  // return the new latency after setActive (true) was called
  // The host has to deactivate and reactivate the plug-in, then afterwards the host
  // could ask for the current latency (getLatencySamples)
  // see IAudioProcessor::getLatencySamples
  // [SDK 3.0.0]
  kLatencyChanged = 1 shl 3;
  // Parameter titles, default values or flags (ParameterFlags) have changed
  // The host invalidates all caches of parameter infos and asks the edit controller for the current infos.
  // [SDK 3.0.0]
  kParamTitlesChanged = 1 shl 4;
  // MIDI Controllers and/or Program Changes Assignments have changed
  // The plug-in informs the host that its MIDI-CC mapping has changed
  // (for example after a MIDI learn or new loaded preset)
  // or if the stepCount or UnitID of a ProgramChange parameter has changed.
  // The host has to rebuild the MIDI-CC => parameter mapping (getMidiControllerAssignment)
  // and reread program changes parameters (stepCount and associated unitID)
  // [SDK 3.0.1]
  kMidiCCAssignmentChanged = 1 shl 5;
  // Note Expression has changed (info, count, PhysicalUIMapping, ...)
  // Either the note expression type info, the count of note expressions or the physical UI mapping has changed.
  // The host invalidates all caches of note expression infos and asks the edit controller for the current ones.
  // See INoteExpressionController, NoteExpressionTypeInfo and INoteExpressionPhysicalUIMapping
  // [SDK 3.5.0]
  kNoteExpressionChanged = 1 shl 6;
  // Input / Output bus titles have changed
  // The host invalidates all caches of bus titles and asks the edit controller for the current titles.
  // [SDK 3.5.0]
  kIOTitlesChanged = 1 shl 7;
  // Prefetch support has changed
  // The plug-in informs the host that its PrefetchSupport has changed
  // The host has to deactivate the plug-in, calls IPrefetchableSupport::getPrefetchableSupport
  // and reactivate the plug-in
  // see IPrefetchableSupport
  // [SDK 3.6.1]
  kPrefetchableSupportChanged = 1 shl 8;
  // RoutingInfo has changed
  // The plug-in informs the host that its internal routing
  // (relation of an event-input-channel to an audio-output-bus) has changed
  // The host ask the plug-in for the new routing with IComponent::getRoutingInfo, vst3Routing
  // see IComponent
  // [SDK 3.6.6]
  kRoutingInfoChanged = 1 shl 9;
  // Key switches has changed (info, count)
  // Either the Key switches info, the count of Key switches has changed.
  // The host invalidates all caches of Key switches infos and asks the edit controller
  // (IKeyswitchController) for the current ones.
  // See IKeyswitchController
  // [SDK 3.7.3]
  kKeyswitchChanged = 1 shl 10;
  // Mapping of ParamID has changed
  // The Plug-in informs the host that its parameters ID has changed. This has to be called by the
  // edit controller in the method setComponentState or setState (during projects loading) when the
  // plug-in detects that the given state was associated to an older version of the plug-in, or to a
  // plug-in to replace (for ex. migrating VST2 => VST3), with a different set of parameter IDs, then
  // the host could remap any used parameters like automation by asking the IRemapParamID interface
  // (which extends IEditController).
  // See IRemapParamID
  // [SDK 3.7.11]
  kParamIDMappingChanged = 1 shl 11;

type
  // Host callback interface for an edit controller: Vst::IComponentHandler
  // - [host imp]
  // - [released: 3.0.0]
  // - [mandatory]
  // Allow transfer of parameter editing to component (processor) via host and support automation.
  // Cause the host to react on configuration changes (restartComponent).
  IComponentHandler = interface(FUnknown) [GUID_IComponentHandler]
    // To be called before calling a performEdit (e.g. on mouse-click-down event).
    // This must be called in the UI-Thread context!
    function BeginEdit({in}ID:TParamID):tresult; winapi;
    // Called between beginEdit and endEdit to inform the handler that a given parameter has a new
    // value. This must be called in the UI-Thread context!
    function PerformEdit({in}ID:TParamID;{in}ValueNormalized:TParamValue):tresult; winapi;
    // To be called after calling a performEdit (e.g. on mouse-click-up event).
    // This must be called in the UI-Thread context!
    function EndEdit({in}ID:TParamID):tresult; winapi;
    // Instructs host to restart the component. This must be called in the UI-Thread context!
    // param flags is a combination of TRestartFlags
    function RestartComponent({in}Flags:Int32):tresult; winapi;
  end;

  // Extended host callback interface for an edit controller: Vst::IComponentHandler2
  // - [host imp]
  // - [extends IComponentHandler]
  // - [released: 3.1.0]
  // - [optional]
  // One part handles:
  // - Setting dirty state of the plug-in
  // - Requesting the host to open the editor
  // The other part handles parameter group editing from the plug-in UI. It wraps a set of IComponentHandler::beginEdit /
  // Steinberg::Vst::IComponentHandler::performEdit / Steinberg::Vst::IComponentHandler::endEdit functions (see IComponentHandler)
  // which should use the same timestamp in the host when writing automation.
  // This allows for better synchronizing of multiple parameter changes at once.
  IComponentHandler2 = interface(FUnknown) [GUID_IComponentHandler2]
    // Tells host that the plug-in is dirty (something besides parameters has changed since last save),
    // if true the host should apply a save before quitting.
    function SetDirty({in}state:TBool):tresult; winapi;
    // Tells host that it should open the plug-in editor the next time it's possible.
    // You should use this instead of showing an alert and blocking the program flow (especially on loading projects).
    // Set kViewTypeEditor
    function RequestOpenEditor(name:FIDString{$ifdef FPC}=kViewTypeEditor{$endif}):tresult; winapi;
    // Starts the group editing (call before a IComponentHandler::beginEdit),
    // the host will keep the current timestamp at this call and will use it for all IComponentHandler::beginEdit
    // IComponentHandler::performEdit / IComponentHandler::endEdit calls until a finishGroupEdit ().
    function StartGroupEdit:tresult; winapi;
    // Finishes the group editing started by a startGroupEdit (call after a IComponentHandler::endEdit).
    function FinishGroupEdit:tresult; winapi;
  end;

  // Extended host callback interface for an edit controller: Vst::IComponentHandlerBusActivation
  // - [host imp]
  // - [extends IComponentHandler]
  // - [released: 3.6.8]
  // - [optional]
  // Allows the plug-in to request the host to activate or deactivate a specific bus.
  // If the host accepts this request, it will call later on IComponent::activateBus.
  // This is particularly useful for instruments with more than 1 outputs, where
  // the user could request from the plug-in UI a given output bus activation.
  IComponentHandlerBusActivation = interface(FUnknown) [GUID_IComponentHandlerBusActivation]
    // request the host to activate or deactivate a specific bus.
    function RequestBusActivation({in}&type:TMediaType; {in}dir:TBusDirection;
                                  {in}index:Int32; {in}state:TBool):tresult; winapi;
  end;

const
  kIsSeparator  = 1 shl 0; // Item is a separator
  kIsDisabled   = 1 shl 1; // Item is disabled
  kIsChecked    = 1 shl 2; // Item is checked
  kIsGroupStart = 1 shl 3 or kIsDisabled;  // Item is a group start (like sub folder)
  kIsGroupEnd   = 1 shl 4 or kIsSeparator; // Item is a group end

type
  // IContextMenuItem is an entry element of the context menu.
  IContextMenuItem = record
    Name:TString128; // Name of the item
    Tag:Int32;       // Identifier tag of the item
    Flags:Int32;     // Flags of the item
  end;
  TContextMenuItem = IContextMenuItem;

  IContextMenuTarget = interface;
  PIContextMenuTarget = ^IContextMenuTarget;

  // Context Menu interface: Vst::IContextMenu
  // - [host imp]
  // - [create with IComponentHandler3::createContextMenu(..)]
  // - [released: 3.5.0]
  // - [optional]
  // A context menu is composed of Item (entry). A Item is defined by a name, a tag, a flag
  // and a associated target (called when this item will be selected/executed).
  // With IContextMenu the plug-in can retrieve a Item, add a Item, remove a Item and pop-up the menu.
  IContextMenu = interface(FUnknown) [GUID_IContextMenu]
    // Gets the number of menu items.
    function GetItemCount:Int32; winapi;
    // Gets a menu item and its target (target could be not assigned).
    function GetItem(Index:Int32; var item:TContextMenuItem; target:PIContextMenuTarget):tresult; winapi;
    // Adds a menu item and its target.
    function AddItem(const item:TContextMenuItem; target:IContextMenuTarget):tresult; winapi;
    // Removes a menu item.
    function RemoveItem(const item:TContextMenuItem; target:IContextMenuTarget):tresult; winapi;
    // Pop-ups the menu. Coordinates are relative to the top-left position of the plug-ins view.
    function Popup(x,y:UCoord):tresult; winapi;
  end;

  // Context Menu Item Target interface: Vst::IContextMenuTarget
  // - [host imp]
  // - [plug imp]
  // - [released: 3.5.0]
  // - [optional]
  // A receiver of a menu item should implement this interface, which will be called after the user has selected this menu item.
  IContextMenuTarget = interface(FUnknown) [GUID_IContextMenuTarget]
    // Called when an menu item was executed.
    function ExecuteMenuItem(tag:Int32):tresult; winapi;
  end;

  // Extended host callback interface Vst::IComponentHandler3 for an edit controller.
  // - [host imp]
  // - [extends IComponentHandler]
  // - [released: 3.5.0]
  // - [optional]
  // A plug-in can ask the host to create a context menu for a given exported parameter ID or a generic context menu.
  // The host may pre-fill this context menu with specific items regarding the parameter ID like "Show automation for parameter",
  // "MIDI learn" etc...
  // The plug-in can use the context menu in two ways :
  // - add its own items to the menu via the IContextMenu interface and call IContextMenu::popup(..) to create the pop-up. See the IContextMenuExample.
  // - extract the host menu items and add them to a context menu created by the plug-in.
  // Note: You can and should use this even if you do not add your own items to the menu as this is considered to be a big user value.
  IComponentHandler3 = interface(FUnknown) [GUID_IComponentHandler3]
    // Creates a host context menu for a plug-in:
		// - If paramID is zero, the host may create a generic context menu.
		// - The IPlugView object must be valid.
		// - The return IContextMenu object needs to be released afterwards by the plug-in.
    function CreateContextMenu(PlugView:IPlugView; ParamID:PParamID):IContextMenu {$ifdef DCC}unsafe{$endif}; winapi;
  end;

  // For IProgress
  TProgressType = UInt32;
const
  AsyncStateRestoration = 0; // plug-in state is restored async (in a background Thread)
  UIBackgroundTask      = 1; // a plug-in task triggered by a UI action
  ptAsyncStateRestoration = AsyncStateRestoration;
  ptUIBackgroundTask = UIBackgroundTask;
type
  // Extended host callback interface for an edit controller: Vst::IProgress
  // - [host imp]
  // - [extends IComponentHandler]
  // - [released: 3.7.0]
  // - [optional]
  // Allows the plug-in to request the host to create a progress for some specific tasks which take
  // some time. The host can visualize the progress as read-only UI elements. For example,
  // after loading a project where a plug-in needs to load extra data (e.g. samples)
  // in a background thread, this enables the host to get and visualize the current
  // status of the loading progress and to inform the user when the loading is finished.
  // Note: During the progress, the host can unload the plug-in at any time. Make sure that
  // the plug-in supports this use case.
  IProgress = interface(FUnknown) [GUID_IProgress]
    // Start a new progress of a given type and optional Description. outID is as ID created by the
    // host to identify this newly created progress (for update and finish method)
    function Start({in}&type:TProgressType; {in}OptionalDescription:PWideChar; out OutID:UInt64):tresult; winapi;
    // Update the progress value (normValue between [0, 1]) associated to the given id
    function Update({in}ID:UInt64; {in}NormValue:TParamValue):tresult; winapi;
    // Finish the progress associated to the given id
    function Finish({in}ID:UInt64):tresult; winapi;
  end;

  // Edit controller component interface: Vst::IEditController
  // - [plug imp]
  // - [released: 3.0.0]
  // - [mandatory]
  // The controller part of an effect or instrument with parameter handling (export, definition, conversion...).
  IEditController = interface(IPluginBase) [GUID_IEditController]
    // Receives the component state.
    function SetComponentState({in}state:IBStream):tresult; winapi;
    // Sets the controller state.
    function SetState({in}state:IBStream):tresult; winapi;
    // Gets the controller state.
    function GetState({inout}state:IBStream):tresult; winapi;
    // Returns the number of parameters exported.
    function GetParameterCount:Int32; winapi;
    // Gets for a given index the parameter information.
    function GetParameterInfo({in}ParamIndex:Int32; out info:TParameterInfo):tresult; winapi;
    // Gets for a given paramID and normalized value its associated string representation.
    function GetParamStringByValue({in}id:TParamID; {in}ValueNormalized:TParamValue; {Length=128,out}str:PChar16):tresult; winapi;
    // Gets for a given paramID and string its normalized value.
    function GetParamValueByString({in}id:TParamID; {in}str:PWideChar; out ValueNormalized:TParamValue):tresult; winapi;
    // Returns for a given paramID and a normalized value its plain representation
    // (for example -6 for -6dB - see vst3AutomationIntro).
    function NormalizedParamToPlain({in}id:TParamID; {in}ValueNormalized:TParamValue):TParamValue; winapi;
    // Returns for a given paramID and a plain value its normalized value. (see vst3AutomationIntro)
    function PlainParamToNormalized({in}id:TParamID; {in}PlainValue:TParamValue):TParamValue; winapi;
    // Returns the normalized value of the parameter associated to the paramID.
    function GetParamNormalized({in}id:TParamID):TParamValue; winapi;
    // Sets the normalized value to the parameter associated to the paramID. The controller must never
    // pass this value-change back to the host via the IComponentHandler. It should update the according
    // GUI element(s) only!
    function SetParamNormalized({in}id:TParamID; {in}value:TParamValue):tresult; winapi;
    // Gets from host a handler which allows the Plugin-in to communicate with the host.
    // Note: This is mandatory if the host is using the IEditController!
    function SetComponentHandler({in}handler:IComponentHandler):tresult; winapi;
    // Creates the editor view of the plug-in, currently only "editor" is supported, see ViewType.
    // The life time of the editor view will never exceed the life time of this controller instance.
    function CreateView({in}name:FIDString):IPlugView {$ifdef DCC}unsafe{$endif}; winapi;
  end;

  // Knob Mode Type
  TKnobMode = Int32;
const
  // Knob Modes
  kCircularMode = 0;        // Circular with jump to clicked position
  kRelativCircularMode = 1; // Circular without jump to clicked position
  kLinearMode = 2;          // Linear: depending on vertical movement

type
  // Edit controller component interface extension: Vst::IEditController2
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.1.0]
  // - [optional]
  // Extension to allow the host to inform the plug-in about the host Knob Mode,
  // and to open the plug-in about box or help documentation.
  IEditController2 = interface(FUnknown) [GUID_IEditController2]
    // Host could set the Knob Mode for the plug-in. Return kResultFalse means not supported mode. see KnobModes.
    function SetKnobMode({in}mode:TKnobMode):tresult; winapi;
    // Host could ask to open the plug-in help (could be: opening a PDF document or link to a web page).
    // The host could call it with onlyCheck set to true for testing support of open Help.
    // Return kResultFalse means not supported function.
    function OpenHelp({in}OnlyCheck:TBool):tresult; winapi;
    // Host could ask to open the plug-in about box.
    // The host could call it with onlyCheck set to true for testing support of open AboutBox.
    // Return kResultFalse means not supported function.
    function OpenAboutBox({in}OnlyCheck:TBool):tresult; winapi;
  end;

  // MIDI Mapping interface: Vst::IMidiMapping
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.0.1]
  // - [optional]
  // MIDI controllers are not transmitted directly to a VST component. MIDI as hardware protocol has
  // restrictions that can be avoided in software. Controller data in particular come along with unclear
  // and often ignored semantics. On top of this they can interfere with regular parameter automation and
  // the host is unaware of what happens in the plug-in when passing MIDI controllers directly.
  // So any functionality that is to be controlled by MIDI controllers must be exported as regular parameter.
  // The host will transform incoming MIDI controller data using this interface and transmit them as regular
  // parameter change. This allows the host to automate them in the same way as other parameters.
  // CtrlNumber can be a typical MIDI controller value extended to some others values like pitchbend or
  // aftertouch (see ControllerNumbers).
  // If the mapping has changed, the plug-in must call IComponentHandler::restartComponent (kMidiCCAssignmentChanged)
  // to inform the host about this change.
  IMidiMapping = interface(FUnknown) [GUID_IMidiMapping]
    // Gets an (preferred) associated ParamID for a given Input Event Bus index, channel and MIDI Controller.
    // param[in] busIndex - index of Input Event Bus
    // param[in] channel - channel of the bus
    // param[in] midiControllerNumber - see ControllerNumbers for expected values (could be bigger than 127)
    // param[in] id - return the associated ParamID to the given midiControllerNumber
    function GetMidiControllerAssignment({in}BusIndex:Int32; {in}channel:Int16;
                                         {in}MidiControllerNumber:TCtrlNumber;
                                         out id:TParamID):tresult; winapi;
  end;

  // Parameter Editing from host: Vst::IEditControllerHostEditing
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.5.0]
  // - [optional]
  // If this interface is implemented by the edit controller, and when performing edits from outside
  // the plug-in (host / remote) of a not automatable and not read-only, and not hidden flagged parameter (kind of helper parameter),
  // the host will start with a beginEditFromHost before calling setParamNormalized and end with an endEditFromHost.
  IEditControllerHostEditing = interface(FUnknown) [GUID_IEditControllerHostEditing]
    // Called before a setParamNormalized sequence, a endEditFromHost will be call at the end of the editing action.
    function BeginEditFromHost({in}ParamID:TParamID):tresult; winapi;
    // Called after a beginEditFromHost and a sequence of setParamNormalized.
    function EndEditFromHost({in}ParamID:TParamID):tresult; winapi;
  end;

  // Extended plug-in interface IComponentHandler for an edit controller
  // - [host imp]
  // - [extends IComponentHandler]
  // - [released: 3.7.9]
  // - [optional]
  IComponentHandlerSystemTime = interface(FUnknown) [GUID_IComponentHandlerSystemTime]
    function GetSystemTime(out SysTime:Int64):tresult; winapi;
  end;

  // Queue of changes for a specific parameter: Vst::IParamValueQueue
  // - [host imp]
  // - [released: 3.0.0]
  // - [mandatory]
  // The change queue can be interpreted as segment of an automation curve. For each
  // processing block, a segment with the size of the block is transmitted to the processor.
  // The curve is expressed as sampling points of a linear approximation of
  // the original automation curve. If the original already is a linear curve, it can
  // be transmitted precisely. A non-linear curve has to be converted to a linear
  // approximation by the host. Every point of the value queue defines a linear
  // section of the curve as a straight line from the previous point of a block to
  // the new one. So the plug-in can calculate the value of the curve for any sample
  // position in the block.
  IParamValueQueue = interface(FUnknown) [GUID_IParamValueQueue]
    // Returns its associated ID.
    function GetParameterID:TParamID; winapi;
    // Returns count of points in the queue.
    function GetPointCount:Int32; winapi;
    // Gets the value and offset at a given index.
    function GetPoint(index:Int32; var SampleOffset:Int32; var value:TParamValue):tresult; winapi;
    // Adds a new value at the end of the queue, its index is returned.
    function AddPoint(SampleOffset:Int32; value:TParamValue; var index:Int32):tresult; winapi;
  end;

  // All parameter changes of a processing block: Vst::IParameterChanges
  // - [host imp]
  // - [released: 3.0.0]
  // - [mandatory]
  // This interface is used to transmit any changes to be applied to parameters
  // in the current processing block. A change can be caused by GUI interaction as
  // well as automation. They are transmitted as a list of queues (IParamValueQueue)
  // containing only queues for parameters that actually did change.
  IParameterChanges = interface(FUnknown) [GUID_IParameterChanges]
    // Returns count of Parameter changes in the list.
    function GetParameterCount:Int32; winapi;
    // Returns the queue at a given index.
    function GetParameterData(index:Int32):IParamValueQueue {$ifdef DCC}unsafe{$endif}; winapi;
    // Adds a new parameter queue with a given ID at the end of the list,
    // returns it and its index in the parameter changes list.
    function AddParameterData({const ref ?}id:TParamID; var index:Int32):
      IParamValueQueue {$ifdef DCC}unsafe{$endif}; winapi;
  end;

const
  // Special UnitIDs for UnitInfo
  kRootUnitId     = 0;  // identifier for the top level unit (root)
  kNoParentUnitID = -1; // used for the root unit which does not have a parent.

  // Special ProgramListIDs for UnitInfo
  kNoProgramListID = -1; // no programs are used in the unit.

  // Special programIndex value for IUnitHandler::notifyProgramListChange
  kAllProgramInvalid = -1; // all program information is invalid

type
  // Basic Unit Description.
  // see IUnitInfo
  TUnitInfo = record
    ID:TUnitID; // unit identifier
    ParentUnitID:TUnitID; // identifier of parent unit (kNoParentUnitId: does not apply, this unit is the root)
    Name:TString128; // name, optional for the root component, required otherwise
    ProgramListID:TProgramListID; // id of program list used in unit (kNoProgramListId = no programs used in this unit)
  end;

  // Basic Program List Description.
  // see IUnitInfo
  TProgramListInfo = record
    ID:TProgramListID;  // program list identifier
    Name:TString128;     // name of program list
    ProgramCount:Int32; // number of programs in this list
  end;

  // Host callback for unit support: Vst::IUnitHandler
  // - [host imp]
  // - [extends IComponentHandler]
  // - [released: 3.0.0]
  // - [optional]
  // Host callback interface, used with IUnitInfo.
  // Retrieve via queryInterface from IComponentHandler.
  IUnitHandler = interface(FUnknown) [GUID_IUnitHandler]
    // Notify host when a module is selected in plug-in GUI.
    function NotifyUnitSelection(UnitID:TUnitID):tresult; winapi;
    // Tell host that the plug-in controller changed a program list (rename, load, PitchName changes).
    // param listId is the specified program list ID to inform.
    // param programIndex : when kAllProgramInvalid, all program information is invalid,
    // otherwise only the program of given index.
    function NotifyProgramListChange(ListID:TProgramListID; ProgramIndex:Int32):tresult; winapi;
  end;

  // Host callback for extended unit support: Vst::IUnitHandler2
  // - [host imp]
  // - [extends IUnitHandler]
  // - [released: 3.6.5]
  // - [optional]
  // Host callback interface, used with IUnitInfo.
  // Retrieve via queryInterface from IComponentHandler.
  // The plug-in has the possibility to inform the host with notifyUnitByBusChange that something has
  // changed in the bus - unit assignment, the host then has to recall IUnitInfo::getUnitByBus in order
  // to get the new relations between busses and unit.
  IUnitHandler2 = interface(FUnknown) [GUID_IUnitHandler2]
    // Tell host that assignment Unit-Bus defined by IUnitInfo::getUnitByBus has changed.
    function NotifyUnitByBusChange:tresult; winapi;
  end;

  // Edit controller extension to describe the plug-in structure: Vst::IUnitInfo
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.0.0]
  // - [optional]
  // IUnitInfo describes the internal structure of the plug-in.
  // - The root unit is the component itself, so getUnitCount must return 1 at least.
  // - The root unit id has to be 0 (kRootUnitId).
  // - Each unit can reference one program list - this reference must not change.
  // - Each unit, using a program list, references one program of the list.
  IUnitInfo = interface(FUnknown) [GUID_IUnitInfo]
    // Returns the flat count of units.
    function GetUnitCount:Int32; winapi;
    // Gets UnitInfo for a given index in the flat list of unit.
    function GetUnitInfo(UnitIndex:Int32; var info:TUnitInfo):tresult; winapi;
    // Gets the count of Program List.
    function GetProgramListCount:Int32; winapi;
    // Gets for a given index the Program List Info.
    function GetProgramListInfo(ListIndex:Int32; var info:TProgramListInfo):tresult; winapi;
    // Gets for a given program list ID and program index its program name.
    function GetProgramName(ListID:TProgramListID; ProgramIndex:Int32; {Length=128}name:PChar16):tresult; winapi;
    // Gets for a given program list ID, program index and attributeId the associated attribute value.
    function GetProgramInfo(ListID:TProgramListID; ProgramIndex:Int32; AttributeID:PChar8;
      {Length=128}AttributeValue:PChar16):tresult; winapi;
    // Returns kResultTrue if the given program index of a given program list ID supports PitchNames.
    function HasProgramPitchNames(ListID:TProgramListID; ProgramIndex:Int32):tresult; winapi;
    // Gets the PitchName for a given program list ID, program index and pitch.
    // If PitchNames are changed the plug-in should inform the host with IUnitHandler::notifyProgramListChange.
    function GetProgramPitchName(ListID:TProgramListID; ProgramIndex:Int32; MidiPitch:Int16;
      {Length=128}name:PChar16):tresult; winapi;
    // Gets the current selected unit.
    function GetSelectedUnit:TUnitID; winapi;
    // Sets a new selected unit.
    function SelectUnit(UnitID:TUnitID):tresult; winapi;
    // Gets the according unit if there is an unambiguous relation between a channel or a bus and a unit.
    // This method mainly is intended to find out which unit is related to a given MIDI input channel.
    function GetUnitByBus(&Type:TMediaType; dir:TBusDirection; BusIndex,channel:Int32;
      var UnitID:TUnitID):tresult; winapi;
    // Receives a preset data stream.
    // - If the component supports program list data (IProgramListData), the destination of the data
    //  stream is the program specified by list-Id and program index (first and second parameter)
    // - If the component supports unit data (IUnitData), the destination is the unit specified by the first
    //  parameter - in this case parameter programIndex is < 0).
    function SetUnitProgramData(ListOrUnitID,ProgramIndex:Int32; data:IBStream):tresult; winapi;
  end;

  // Component extension to access program list data: Vst::IProgramListData
  // - [plug imp]
  // - [extends IComponent]
  // - [released: 3.0.0]
  // - [optional]
  // A component can support program list data via this interface or/and
  // unit preset data (IUnitData).
  IProgramListData = interface(FUnknown) [GUID_IProgramListData]
    // Returns kResultTrue if the given Program List ID supports Program Data.
    function ProgramDataSupported(ListID:TProgramListID):tresult; winapi;
    // Gets for a given program list ID and program index the program Data.
    function GetProgramData(ListID:TProgramListID; ProgramIndex:Int32; data:IBStream):tresult; winapi;
    // Sets for a given program list ID and program index a program Data.
    function SetProgramData(ListID:TProgramListID; ProgramIndex:Int32; data:IBStream):tresult; winapi;
  end;

  // Component extension to access unit data: Vst::IUnitData
  // - [plug imp]
  // - [extends IComponent]
  // - [released: 3.0.0]
  // - [optional]
  // A component can support unit preset data via this interface or
  // program list data (IProgramListData).
  IUnitData = interface(FUnknown) [GUID_IUnitData]
    // Returns kResultTrue if the specified unit supports export and import of preset data.
    function UnitDataSupported(UnitID:TUnitID):tresult; winapi;
    // Gets the preset data for the specified unit.
    function GetUnitData(UnitID:TUnitID; data:IBStream):tresult; winapi;
    // Sets the preset data for the specified unit.
    function SetUnitData(UnitID:TUnitID; data:IBStream):tresult; winapi;
  end;

type
  // Note Expression Types
  // NoteExpressionTypeID describes the type of the note expression.
  // VST predefines some types like volume, pan, tuning by defining their ranges and curves.
  // Used by NoteExpressionEvent::typeId and NoteExpressionTypeID::typeId
  // see NoteExpressionTypeInfo
  TNoteExpressionTypeID = UInt32;
  // Note Expression Value
  TNoteExpressionValue = Double;

const
  kVolumeTypeID = 0;     // Volume, plain range [0 = -oo , 0.25 = 0dB, 0.5 = +6dB, 1 = +12dB]: plain = 20 * log (4 * norm)
  kNETypeIDPan = 1;      // Panning (L-R), plain range [0 = left, 0.5 = center, 1 = right]
  // Tuning, plain range [0 = -120.0 (ten octaves down), 0.5 none, 1 = +120.0 (ten octaves up)]
  // plain = 240 * (norm - 0.5) and norm = plain / 240 + 0.5
  // oneOctave is 12.0 / 240.0; oneHalfTune = 1.0 / 240.0;
  kTuningTypeID = 2;
  kVibratoTypeID = 3;    // Vibrato
  kExpressionTypeID = 4; // Expression
  kBrightnessTypeID = 5; // Brightness
  kTextTypeID = 6;       // See NoteExpressionTextEvent
  kPhonemeTypeID = 7;    // TODO:

  kCustomStart = 100000; // start of custom note expression type ids
  kCustomEnd = 200000;   // end of custom note expression type ids
  kInvalidTypeID = $FFFFFFFF; // indicates an invalid note expression type

type
  // Description of a Note Expression Type
  // This structure is part of the NoteExpressionTypeInfo structure,
  // it describes for given NoteExpressionTypeID its default value
  // (for example 0.5 for a kTuningTypeID (kIsBipolar: centered)), its minimum
  // and maximum (for predefined NoteExpressionTypeID the full range is predefined too)
  // and a stepCount when the given NoteExpressionTypeID is limited to discrete values (like on/off state).
  TNoteExpressionValueDescription = record
    DefaultValue:TNoteExpressionValue; // default normalized value [0,1]
    Minimum:TNoteExpressionValue;      // minimum normalized value [0,1]
    Maximum:TNoteExpressionValue;      // maximum normalized value [0,1]
    // number of discrete steps (0: continuous, 1: toggle, discrete value otherwise - see vst3ParameterIntro)
    StepCount:Int32;
  end;

{$if defined(MSWINDOWS) and not (defined(CPU64) or defined(CPU64BITS))}
  {$ifdef FPC} {$push} {$endif}
  {$A4}
{$endif}

  // Note Expression Value event. Used in Event (union)
  // A note expression event affects one single playing note (referring its noteId).
  // This kind of event is send from host to the plug-in like other events
  // (NoteOnEvent, NoteOffEvent,...) in ProcessData during the process call.
  // Note expression events for a specific noteId can only occur after a NoteOnEvent.
  // The host must take care that the event list (IEventList) is properly sorted.
  // Expression events are always absolute normalized values [0.0, 1.0].
  // The predefined types have a predefined mapping of the normalized values (see NoteExpressionTypeIDs)
  TNoteExpressionValueEvent = record
    TypeID:TNoteExpressionTypeID; // see NoteExpressionTypeID
    NoteID:Int32; // associated note identifier to apply the change
    Value:TNoteExpressionValue; // normalized value [0.0, 1.0].
  end;

  // Note Expression Text event. Used in Event (union)
  // A Expression event affects one single playing note.
  TNoteExpressionTextEvent = record
    TypeID:TNoteExpressionTypeID; // see NoteExpressionTypeID (kTextTypeID or kPhoneticTypeID)
    NoteID:Int32;   // associated note identifier to apply the change
    // the number of characters (TChar) between the beginning of text and the terminating
    // null character (without including the terminating null character itself)
    TextLen:UInt32;
    Text:PWideChar; // UTF-16, null terminated
  end;

{$if defined(MSWINDOWS) and not (defined(CPU64) or defined(CPU64BITS))}
  {$ifdef FPC} {$pop} {$else} {$A8} {$endif}
{$endif}

const
  // event is bipolar (centered), otherwise unipolar
  kIsBipolar = 1 shl 0;
  // event occurs only one time for its associated note (at begin of the noteOn)
  kIsOneShot = 1 shl 1;
  // This note expression will apply an absolute change to the sound (not relative (offset))
  kIsAbsolute = 1 shl 2;
  // indicates that the associatedParameterID is valid and could be used
  kAssociatedParameterIDValid = 1 shl 4;

type
  // NoteExpressionTypeInfo is the structure describing a note expression supported by the plug-in.
  // This structure is used by the method INoteExpressionController::getNoteExpressionInfo.
  TNoteExpressionTypeInfo = record
    TypeID:TNoteExpressionTypeID; // unique identifier of this note Expression type
    Title:TString128;      // note Expression type title (e.g. "Volume")
    ShortTitle:TString128; // note Expression type short title (e.g. "Vol")
    Units:TString128;      // note Expression type unit (e.g. "dB")
    // id of unit this NoteExpression belongs to (see vst3Units), in order to sort the note expression,
    // it is possible to use unitId like for parameters. -1 means no unit used.
    UnitID:Int32;
    ValueDesc:TNoteExpressionValueDescription; // value description see NoteExpressionValueDescription
    // optional associated parameter ID (for mapping from note expression to
    // global (using the parameter automation for example) and back).
    // Only used when kAssociatedParameterIDValid is set in flags.
    AssociatedParameterID:TParamID;
    Flags:Int32; // NoteExpressionTypeFlags (see below)
  end;

  // Extended plug-in interface IEditController for note expression event support: Vst::INoteExpressionController
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.5.0]
  // - [optional]
  // With this plug-in interface, the host can retrieve all necessary note expression information supported by the plug-in.
  // Note expression information (NoteExpressionTypeInfo) are specific for given channel and event bus.
  // Note that there is only one NoteExpressionTypeID per given channel of an event bus.
  // The method getNoteExpressionStringByValue allows conversion from a normalized value to a string representation
  // and the getNoteExpressionValueByString method from a string to a normalized value.
  // When the note expression state changes (for example when switching presets) the plug-in needs
  // to inform the host about it via IComponentHandler::restartComponent (kNoteExpressionChanged).
  INoteExpressionController = interface(FUnknown) [GUID_INoteExpressionController]
    // Returns number of supported note change types for event bus index and channel.
    function GetNoteExpressionCount(BusIndex:Int32; channel:Int16):Int32; winapi;
    // Returns note change type info.
    function GetNoteExpressionInfo(BusIndex:Int32; channel:Int16; NoteExpressionIndex:Int32;
      var info:TNoteExpressionTypeInfo):tresult; winapi;
    // Gets a user readable representation of the normalized note change value.
    function GetNoteExpressionStringByValue(BusIndex:Int32; channel:Int16; TypeID:TNoteExpressionTypeID;
      {in}ValueNormalized:TNoteExpressionValue; var str:TString128):tresult; winapi;
    // Converts the user readable representation to the normalized note change value.
    function GetNoteExpressionValueByString(BusIndex:Int32; channel:Int16; TypeID:TNoteExpressionTypeID;
      {in}str:PWideChar; var ValueNormalized:TNoteExpressionValue):tresult; winapi;
  end;

  // KeyswitchTypeID describes the type of a key switch
  // see TKeyswitchInfo
  TKeyswitchTypeID = UInt32;
const
  kNoteOnKeyswitchTypeID    = 0; // press before noteOn is played
  kOnTheFlyKeyswitchTypeID  = 1; // press while noteOn is played
  kOnReleaseKeyswitchTypeID = 2; // press before entering release
  kKeyRangeTypeID           = 3; // key should be maintained pressed for playing

type
  // KeyswitchInfo is the structure describing a key switch
  // This structure is used by the method IKeyswitchController::getKeyswitchInfo.
  // see IKeyswitchController
  TKeyswitchInfo = record
    TypeID:TKeyswitchTypeID; // see TKeyswitchTypeID context
    Title:TString128;         // name of key switch (e.g. "Accentuation")
    ShortTitle:TString128;    // short title (e.g. "Acc")
    KeyswitchMin:Int32;      // associated main key switch min (value between [0, 127])
    KeyswitchMax:Int32;      // associated main key switch max (value between [0, 127])
    // optional remapped key switch (default -1), the plug-in could provide one remapped
    // key for a key switch (allowing better location on the keyboard of the key switches)
    KeyRemapped:Int32;
    UnitID:Int32; // id of unit this key switch belongs to (see vst3Units), -1 means no unit used.
    Flags:Int32;  // not yet used (set to 0)
  end;

  // Extended plug-in interface IEditController for key switches support: Vst::IKeyswitchController
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.5.0]
  // - [optional]
  // When a (instrument) plug-in supports such interface, the host could get from the plug-in the current set
  // of used key switches (megatrig/articulation) for a given channel of a event bus and then automatically use them (like in Cubase 6) to
  // create VST Expression Map (allowing to associated symbol to a given articulation / key switch).
  IKeyswitchController = interface(FUnknown) [GUID_IKeyswitchController]
    // Returns number of supported key switches for event bus index and channel.
    function GetKeyswitchCount(BusIndex:Int32; channel:Int16):Int32 winapi;
    // Returns key switch info.
    function GetKeyswitchInfo(BusIndex:Int32; channel:Int16; KeyswitchIndex:Int32; var info:TKeyswitchInfo):tresult; winapi;
  end;

const
  // Reserved note identifier (noteId) range for a plug-in. Guaranteed not used by the host.
  kNoteIDUserRangeLowerBound = -10000;
  kNoteIDUserRangeUpperBound = -1000;

type
  // Note-on event specific data. Used in Event (union)
  // Pitch uses the twelve-tone equal temperament tuning (12-TET).
  TNoteOnEvent = record
    Channel:Int16;   // channel index in event bus
    Pitch:Int16;     // range [0, 127] = [C-2, G8] with A3=440Hz (12-TET: twelve-tone equal temperament)
    Tuning:Single;   // 1.f = +1 cent, -1.f = -1 cent
    Velocity:Single; // range [0.0, 1.0]
    Length:Int32;    // in sample frames (optional, Note Off has to follow in any case!)
    NoteID:Int32;    // note identifier (if not available then -1)
  end;

  // Note-off event specific data. Used in Event (union)
  TNoteOffEvent = record
    Channel:Int16;   // channel index in event bus
    Pitch:Int16;     // range [0, 127] = [C-2, G8] with A3=440Hz (12-TET)
    Velocity:Single; // range [0.0, 1.0]
    NoteID:Int32;    // associated noteOn identifier (if not available then -1)
    Tuning:Single;   // 1.f = +1 cent, -1.f = -1 cent
  end;

const
  kMidiSysEx = 0; // For TDataEvent

type
  // Data event specific data. Used in Event (union)
  TDataEvent = record
    Size:UInt32;  // size in bytes of the data block bytes
    &Type:UInt32; // type of this data block (only kMidiSysEx)
    Bytes:PUInt8; // pointer to the data block
  end;

  // PolyPressure event specific data. Used in Event (union)
  TPolyPressureEvent = record
    Channel:Int16;   // channel index in event bus
    Pitch:Int16;     // range [0, 127] = [C-2, G8] with A3=440Hz
    Pressure:Single; // range [0.0, 1.0]
    NoteID:Int32;    // event should be applied to the noteId (if not -1)
  end;

  // Chord event specific data. Used in Event (union)
  TChordEvent = record
    Root:Int16;     // range [0, 127] = [C-2, G8] with A3=440Hz
    BassNote:Int16; // range [0, 127] = [C-2, G8] with A3=440Hz
    Mask:Int16;     // root is bit 0
    // the number of characters (TChar) between the beginning of text and the terminating
    // null character (without including the terminating null character itself)
    TextLen:UInt16;
    Text:PWideChar; // UTF-16, null terminated Hosts Chord Name
  end;

  // Scale event specific data. Used in Event (union)
  TScaleEvent = record
    Root:Int16; // range [0, 127] = root Note/Transpose Factor
    Mask:Int16; // Bit 0 =  C,  Bit 1 = C#, ... (0x5ab5 = Major Scale)
    // the number of characters (TChar) between the beginning of text and the terminating
    // null character (without including the terminating null character itself)
    TextLen:UInt16;
    Text:PWideChar; // UTF-16, null terminated, Hosts Scale Name
  end;

  // Legacy MIDI CC Out event specific data. Used in Event (union)
  // - [released: 3.6.12]
  // This kind of event is reserved for generating MIDI CC as output event for kEvent Bus during the process call.
  TLegacyMIDICCOutEvent = record
    ControlNumber:UInt8; // see enum ControllerNumbers [0, 255]
    Channel:Int8; // channel index in event bus [0, 15]
    Value:Int8;   // value of Controller [0, 127]
    Value2:Int8;  // [0, 127] used for pitch bend (kPitchBend) and polyPressure (kCtrlPolyPressure)
  end;

const
  kNoteOnEvent = 0;  // is NoteOnEvent
  kNoteOffEvent = 1; // is NoteOffEvent
  kPolyPressureEvent = 3; // is PolyPressureEvent
  kNoteExpressionValueEvent = 4; // is NoteExpressionValueEvent
  kNoteExpressionTextEvent = 5;  // is NoteExpressionTextEvent
  kChordEvent = 6; // is ChordEvent
  kScaleEvent = 7; // is ScaleEvent
  kLegacyMIDICCOutEvent = 65535;

  kIsLive = 1 shl 0; // indicates that the event is played live (directly from keyboard)
  kUserReserved1 = 1 shl 14; // reserved for user (for internal use)
  kUserReserved2 = 1 shl 15; // reserved for user (for internal use)

type
  // Structure representing a single Event of different types associated to a specific event (kEvent) bus.
  TEvent = record
    BusIndex:Int32; // event bus index
    SampleOffset:Int32; // sample frames related to the current block start sample position
    PPQPosition:TQuarterNotes; // position in project
    Flags:UInt16; // combination of EventFlags
    &Type:UInt16; // a value from EventTypes
    case byte of
      0:(NoteOn:TNoteOnEvent);   // type == kNoteOnEvent
      1:(NoteOff:TNoteOffEvent); // type == kNoteOffEvent
      2:(Data:TDataEvent);       // type == kDataEvent
      3:(PolyPressure:TPolyPressureEvent); // type == kPolyPressureEvent
      4:(NoteExpressionValue:TNoteExpressionValueEvent); // type == kNoteExpressionValueEvent
      5:(NoteExpressionText:TNoteExpressionTextEvent);   // type == kNoteExpressionTextEvent
      6:(Chord:TChordEvent); // type == kChordEvent
      7:(Scale:TScaleEvent); // type == kScaleEvent
      8:(MidiCCOut:TLegacyMIDICCOutEvent); // type == kLegacyMIDICCOutEvent
  end;

  // List of events to process: Vst::IEventList
  // - [host imp]
  // - [released: 3.0.0]
  // - [mandatory]
  // see TProcessData, TEvent
  IEventList = interface(FUnknown) [GUID_IEventList]
    // Returns the count of events.
    function GetEventCount:Int32; winapi;
    // Gets parameter by index.
    function GetEvent(index:Int32; var e:TEvent):tresult; winapi;
    // Adds a new event.
    function AddEvent(const e:TEvent):tresult; winapi;
  end;

const
  kPullDownRate = 1 shl 0;
  kDropRate = 1 shl 1;
  kChordMask=$0fff;    // mask for chordMask
  kReservedMask=$f000; // reserved for future use

type
  // A frame rate describes the number of image (frame) displayed per second.
  // Some examples:
  //  - 23.976 fps     is framesPerSecond: 24 and flags: kPullDownRate
  //  - 24 fps         is framesPerSecond: 24 and flags: 0
  //  - 25 fps         is framesPerSecond: 25 and flags: 0
  //  - 29.97 drop fps is framesPerSecond: 30 and flags: kDropRate|kPullDownRate
  //  - 29.97 fps      is framesPerSecond: 30 and flags: kPullDownRate
  //  - 30 fps         is framesPerSecond: 30 and flags: 0
  //  - 30 drop fps    is framesPerSecond: 30 and flags: kDropRate
  //  - 50 fps         is framesPerSecond: 50 and flags: 0
  //  - 59.94 fps      is framesPerSecond: 60 and flags: kPullDownRate
  //  - 60 fps         is framesPerSecond: 60 and flags: 0
  TFrameRate = record
    FramePerSecond:UInt32; // frame rate
    Flags:UInt32;
  end;

  // Description of a chord.
  // A chord is described with a key note, a root note and the chordMask
  TChord = record
    KeyNote:UInt8;  // key note in chord
    RootNote:UInt8; // lowest note in chord
    // Bitmask of a chord.
    // 1st bit set: minor second; 2nd bit set: major second, and so on.
    //  There is no bit for the keynote (root of the chord) because it is inherently always present.
    //  Examples:
    //  - XXXX 0000 0100 1000 (= 0x0048) -> major chord
    //  - XXXX 0000 0100 0100 (= 0x0044) -> minor chord
    //  - XXXX 0010 0100 0100 (= 0x0244) -> minor chord with minor seventh
    ChordMask:Int16;
  end;

  PProcessContext = ^TProcessContext;
  // Audio processing context.
  // For each processing block the host provides timing information and musical parameters that can
  // change over time. For a host that supports jumps (like cycle) it is possible to split up a
  // processing block into multiple parts in order to provide a correct project time inside of every
  // block, but this behavior is not mandatory. Since the timing will be correct at the beginning of the
  // next block again, a host that is dependent on a fixed processing block size can choose to neglect
  // this problem.
  TProcessContext = record
  public const
    kPlaying=1 shl 1;     // currently playing
    kCycleActive=1 shl 2; // cycle is active
    kRecording=1 shl 3;   // currently recording

    kSystemTimeValid=1 shl 8; // systemTime contains valid information
    kContTimeValid=1 shl 17;  // continousTimeSamples contains valid information

    kProjectTimeMusicValid=1 shl 9; // projectTimeMusic contains valid information
    kBarPositionValid=1 shl 11;     // barPositionMusic contains valid information
    kCycleValid=1 shl 12;           // cycleStartMusic and barPositionMusic contain valid information

    kTempoValid=1 shl 10;    // tempo contains valid information
    kTimeSigValid=1 shl 13;  // timeSigNumerator and timeSigDenominator contain valid information
    kChordValid=1 shl 18;    // chord contains valid information

    kSmpteValid=1 shl 14;    // smpteOffset and frameRate contain valid information
    kClockValid=1 shl 15;    // samplesToNextClock valid
  public
    State:UInt32; // a combination of the values from TStatesAndFlags
    SampleRate:Double;              // current sample rate (always valid)
    ProjectTimeSamples:TSamples;    // project time in samples (always valid)
    SystemTime:Int64;               // system time in nanoseconds (optional)
    ContinousTimeSamples:TSamples;  // project time, without loop (optional)
    ProjectTimeMusic:TQuarterNotes; // musical position in quarter notes (1.0 equals 1 quarter note) (optional)
    BarPositionMusic:TQuarterNotes; // last bar start position, in quarter notes (optional)
    CycleStartMusic:TQuarterNotes;  // cycle start in quarter notes (optional)
    CycleEndMusic:TQuarterNotes;    // cycle end in quarter notes (optional)
    Tempo:Double;             // tempo in BPM (Beats Per Minute) (optional)
    TimeSigNumerator:Int32;   // time signature numerator (e.g. 3 for 3/4) (optional)
    TimeSigDenominator:Int32; // time signature denominator (e.g. 4 for 3/4) (optional)
    Chord:TChord;             // musical info (optional)
    SmpteOffsetSubframes:Int32; // SMPTE (sync) offset in subframes (1/80 of frame) (optional)
    FrameRate:TFrameRate;       // frame rate (optional)
    SampleToNextClock:Int32; // MIDI Clock Resolution (24 Per Quarter Note), can be negative (nearest) (optional)
  end;

  // Processing mode informs the plug-in about the context and at which frequency the process call is called.
  // VST3 defines 3 modes:
  // - kRealtime: each process call is called at a realtime frequency (defined by [numSamples of ProcessData] / samplerate).
  //              The plug-in should always try to process as fast as possible in order to let enough time slice to other plug-ins.
  // - kPrefetch: each process call could be called at a variable frequency (jitter, slower / faster than realtime),
  //              the plug-in should process at the same quality level than realtime, plug-in must not slow down to realtime
  //              (e.g. disk streaming)!
  // The host should avoid to process in kPrefetch mode such sampler based plug-in.
  // - kOffline: each process call could be faster than realtime or slower, higher quality than realtime could be used.
  //             plug-ins using disk streaming should be sure that they have enough time in the process call for streaming,
  //             if needed by slowing down to realtime or slower.
  // Note about Process Modes switching:
  // - Switching between kRealtime and kPrefetch process modes are done in realtime thread without need of calling
  //   IAudioProcessor::setupProcessing, the plug-in should check in process call the member processMode of ProcessData
  //   in order to know in which mode it is processed.
  // - Switching between kRealtime (or kPrefetch) and kOffline requires that the host calls IAudioProcessor::setupProcessing
  //   in order to inform the plug-in about this mode change.
  TProcessMode = Int32;

  TSymbolicSampleSize = Int32; // Symbolic sample size.

const
  kVstAudioEffectClass = 'Audio Module Class';

  kSample32 = 0; // 32-bit precision
  kSample64 = 1; // 64-bit precision

  kRealtime = 0; // realtime processing
  kPrefetch = 1; // prefetch processing
  kOffline  = 2; // offline processing
  // to be returned by getTailSamples when no tail is wanted
  kNoTail = 0;
  // to be returned by getTailSamples when infinite tail is wanted
  kInfiniteTail = kMaxInt32u;

type
  // Audio processing setup.
  TProcessSetup = record
    ProcessMode:TProcessMode;
    SymbolicSampleSize:TSymbolicSampleSize;
    MaxSamplePerBlock:Int32; // maximum number of samples per audio block
    SampleRate:TSampleRate;
  end;

  PAudioBusBuffers = ^TAudioBusBuffers;
  //Processing buffers of an audio bus.
  //This structure contains the processing buffer for each channel of an audio bus.
  //- The number of channels (numChannels) must always match the current bus arrangement.
  //  It could be set to value '0' when the host wants to flush the parameters (when the plug-in is not processed).
  //- The size of the channel buffer array must always match the number of channels. So the host
  //  must always supply an array for the channel buffers, regardless if the
  //  bus is active or not. However, if an audio bus is currently inactive, the actual sample
  //  buffer addresses are safe to be null.
  //- The silence flag is set when every sample of the according buffer has the value '0'. It is
  //  intended to be used as help for optimizations allowing a plug-in to reduce processing activities.
  //  But even if this flag is set for a channel, the channel buffers must still point to valid memory!
  //  This flag is optional. A host is free to support it or not.
  TAudioBusBuffers = record
    NumChannels:Int32;   // number of audio channels in bus
    SilenceFlags:UInt64; // Bitset of silence state per channel
    case Byte of
      0:(ChannelBuffers32:PPSample32); // sample buffers to process with 32-bit precision
      1:(ChannelBuffers64:PPSample64); // sample buffers to process with 64-bit precision
  end;

  // Any data needed in audio processing.
  // The host prepares AudioBusBuffers for each input/output bus,
  // regardless of the bus activation state. Bus buffer indices always match
  // with bus indices used in IComponent::getBusInfo of media type kAudio.
  TProcessData = record
    ProcessMode:TProcessMode; // processing mode - value of TProcessMode
    SymbolicSampleSize:TSymbolicSampleSize; // sample size - value of TSymbolicSampleSize
    NumSamples:Int32; // number of samples to process
    NumInputs:Int32;  // number of audio input busses
    NumOutputs:Int32; // number of audio output busses
    Inputs:PAudioBusBuffers;  // buffers of input busses
    Outputs:PAudioBusBuffers; // buffers of output busses
    InputParameterChanges:IParameterChanges;  // incoming parameter changes for this block
    OutputParameterChanges:IParameterChanges; // outgoing parameter changes for this block (optional)
    InputEvents:IEventList;  // incoming events for this block (optional)
    OutputEvents:IEventList; // outgoing events for this block (optional)
    ProcessContext:PProcessContext; // processing context (optional, but most welcome)
  end;

  // Audio processing interface: Vst::IAudioProcessor
  // - [plug imp]
  // - [extends IComponent]
  // - [released: 3.0.0]
  // - [mandatory]
  // This interface must always be supported by audio processing plug-ins.
  IAudioProcessor = interface(FUnknown) [GUID_IAudioProcessor]
    // Try to set (host => plug-in) a wanted arrangement for inputs and outputs.
    // The host should always deliver the same number of input and output busses than the plug-in
    // needs (see IComponent::getBusCount). The plug-in has 3 possibilities to react on this
    // setBusArrangements call:
    //   1. The plug-in accepts these arrangements, then it should modify, if needed, its busses to match
    //      these new arrangements (later on asked by the host with IComponent::getBusInfo () or
    //      IAudioProcessor::getBusArrangement ()) and then should return kResultTrue.
    //   2. The plug-in does not accept or support these requested arrangements for all
    //      inputs/outputs or just for some or only one bus, but the plug-in can try to adapt its current
    //      arrangements according to the requested ones (requested arrangements for kMain busses should be
    //      handled with more priority than the ones for kAux busses), then it should modify its busses arrangements
    //      and should return kResultFalse.
    //   3. Same than the point 2 above the plug-in does not support these requested arrangements
    //      but the plug-in cannot find corresponding arrangements, the plug-in could keep its current arrangement
    //      or fall back to a default arrangement by modifying its busses arrangements and should return kResultFalse.
    //      param inputs pointer to an array of SpeakerArrangement
    //      param numIns number of SpeakerArrangement in inputs array
    //      param outputs pointer to an array of SpeakerArrangement
    //      param numOuts number of SpeakerArrangement in outputs array
    //      Returns kResultTrue when Arrangements is supported and is the current one, else returns kResultFalse.
    function SetBusArrangements(inputs :PSpeakerArrangement; NumIns :Int32;
                                outputs:PSpeakerArrangement; NumOuts:Int32):tresult; winapi;
    // Gets the bus arrangement for a given direction (input/output) and index.
    // Note: IComponent::getBusInfo () and IAudioProcessor::getBusArrangement () should be always return the same
    // information about the busses arrangements.
    function GetBusArrangements(kBusDir:TBusDirection; index:Int32; var arr:TSpeakerArrangement):tresult; winapi;
    // Asks if a given sample size is supported see SymbolicSampleSizes.
    function CanProcessSampleSize(SymbolicSampleSize:Int32):tresult; winapi;
    // Gets the current Latency in samples.
    // The returned value defines the group delay or the latency of the plug-in. For example, if the plug-in internally needs
    // to look in advance (like compressors) 512 samples then this plug-in should report 512 as latency.
    // If during the use of the plug-in this latency change, the plug-in has to inform the host by
    // using IComponentHandler::restartComponent (kLatencyChanged), this could lead to audio playback interruption
    // because the host has to recompute its internal mixer delay compensation.
    // Note that for player live recording this latency should be zero or small.
    function GetLatencySamples:UInt32; winapi;
    // Called in disable state (setActive not called with true) before setProcessing is called and processing will begin.
    function SetupProcessing(var setup:TProcessSetup):tresult; winapi;
    // Informs the plug-in about the processing state. This will be called before any process calls
    // start with true and after with false.
    // Note that setProcessing (false) may be called after setProcessing (true) without any process calls.
    // Note this function could be called in the UI or in Processing Thread, thats why the plug-in
    // should only light operation (no memory allocation or big setup reconfiguration),
    // this could be used to reset some buffers (like Delay line or Reverb).
    // The host has to be sure that it is called only when the plug-in is enable
    // (setActive (true) was called).
    function SetProcessing(state:TBool):tresult; winapi;
    // The Process call, where all information (parameter changes, event, audio buffer) are passed.
    function Process(var data:TProcessData):tresult; winapi;
    // Gets tail size in samples. For example, if the plug-in is a Reverb plug-in and it knows that
    // the maximum length of the Reverb is 2sec, then it has to return in getTailSamples()
    // (in VST2 it was getGetTailSize ()): 2*sampleRate.
    // This information could be used by host for offline processing, process optimization and
    // downmix (avoiding signal cut (clicks)).
    // It should return:
    //  - kNoTail when no tail
    //  - x * sampleRate when x Sec tail.
    //  - kInfiniteTail when infinite tail.
    function GetTailSamples:UInt32; winapi;
  end;

  // Extended IAudioProcessor interface for a component: Vst::IAudioPresentationLatency
  // - [plug imp]
  // - [extends IAudioProcessor]
  // - [released: 3.1.0]
  // - [optional]
  // Inform the plug-in about how long from the moment of generation/acquiring (from file or from Input)
  // it will take for its input to arrive, and how long it will take for its output to be presented (to output or to speaker).
  // Note for Input Presentation Latency: when reading from file, the first plug-in will have an input presentation latency set to zero.
  // When monitoring audio input from an audio device, the initial input latency is the input latency of the audio device itself.
  // Note for Output Presentation Latency: when writing to a file, the last plug-in will have an output presentation latency set to zero.
  // When the output of this plug-in is connected to an audio device, the initial output latency is the output
  // latency of the audio device itself.
  // A value of zero either means no latency or an unknown latency.
  // Each plug-in adding a latency (returning a none zero value for IAudioProcessor::getLatencySamples) will modify the input
  // presentation latency of the next plug-ins in the mixer routing graph and will modify the output presentation latency
  // of the previous plug-ins.
  IAudioPresentationLatency = interface(FUnknown) [GUID_IAudioPresentationLatency]
    // Informs the plug-in about the Audio Presentation Latency in samples for a given direction (kInput/kOutput) and bus index.
    function SetAudioPresentationLatencySamples(kBusDir:TBusDirection; BusIndex:Int32; LatencyInSamples:UInt32):tresult; winapi;
  end;

const
  kNeedSystemTime           = 1 shl 0;  // 1<<0  kSystemTimeValid
  kNeedContinousTimeSamples = 1 shl 1;  // 1<<1  kContTimeValid
  kNeedProjectTimeMusic     = 1 shl 2;  // 1<<2  kProjectTimeMusicValid
  kNeedBarPositionMusic     = 1 shl 3;  // 1<<3  kBarPositionValid
  kNeedCycleMusic           = 1 shl 4;  // 1<<4  kCycleValid
  kNeedSamplesToNextClock   = 1 shl 5;  // 1<<5  kClockValid
  kNeedTempo                = 1 shl 6;  // 1<<6  kTempoValid
  kNeedTimeSignature        = 1 shl 7;  // 1<<7  kTimeSigValid
  kNeedChord                = 1 shl 8;  // 1<<8  kChordValid
  kNeedFrameRate            = 1 shl 9;  // 1<<9  kSmpteValid
  kNeedTransportState       = 1 shl 10; // 1<<10 kPlaying, kCycleActive, kRecording

type
  // Extended IAudioProcessor interface for a component: Vst::IProcessContextRequirements
  // - [plug imp]
  // - [extends IAudioProcessor]
  // - [released: 3.7.0]
  // - [mandatory]
  // To get accurate process context information (Vst::ProcessContext), it is now required to implement this interface and
  // return the desired bit mask of flags which your audio effect needs. If you do not implement this
  // interface, you may not get any information at all of the process function.
  // The host asks for this information once between initialize and setActive. It cannot be changed afterwards.
  // This gives the host the opportunity to better optimize the audio process graph when it knows which
  // plug-ins need which information.
  // Plug-Ins built with an earlier SDK version (< 3.7) will still get the old information, but the information
  // may not be as accurate as when using this interface.
  IProcessContextRequirements = interface(FUnknown) [GUID_IProcessContextRequirements]
    function GetProcessContextRequirements:UInt32; winapi;
  end;

type
  TDataExchangeQueueID = UInt32;
  TDataExchangeBlockID = UInt32;
  TDataExchangeUserContextID = UInt32;
  PDataExchangeQueueID = ^TDataExchangeQueueID;

const
  InvalidDataExchangeQueueID = kMaxInt32;
  InvalidDataExchangeBlockID = kMaxInt32;

type
  PDataExchangeBlock = ^TDataExchangeBlock;
  TDataExchangeBlock = record
    Data:Pointer; // pointer to the memory buffer
    Size:UInt32;  // size of the memory buffer
    BlockID:TDataExchangeBlockID; // block identifier
  end;

  // Host Data Exchange handler interface: Vst::IDataExchangeHandler
  // - [host imp]
  // - [context interface]
  // - [released: 3.7.9]
  // - [optional]
  //
  // The IDataExchangeHandler implements a direct and thread-safe connection from the realtime
  // audio context of the audio processor to the non-realtime audio context of the edit controller.
  // This should be used when the edit controller needs continuous data from the audio process for
  // visualization or other use-cases. To circumvent the bottleneck on the main thread it is possible
  // to configure the connection in a way that the calls to the edit controller will happen on a
  // background thread.
  //
  // Opening a queue:
  // The main operation for a plug-in is to open a queue via the handler before the plug-in is activated
  // (but it must be connected to the edit controller via the IConnectionPoint when the plug-in is using
  // the recommended separation of edit controller and audio processor). The best place to do this is in
  // the IAudioProcessor::setupProcessing method as this is also the place where the plug-in knows the
  // sample rate and maximum block size which the plug-in may need to calculate the queue block size.
  // When a queue is opened the edit controller gets a notification about it and the controller can
  // decide if it wishes to receive the data on the main thread or the background thread.
  //
  // Sending data:
  // In the IAudioProcessor::process call the plug-in can now lock a block from the handler, fill it and
  // when done free the block via the handler which then sends the block to the edit controller. The edit
  // controller then receives the block either on the main thread or on a background thread depending on
  // the setup of the queue.
  // The host guarantees that all blocks are send before the plug-in is deactivated.
  //
  // Closing a queue:
  // The audio processor must close an opened queue and this has to be done after the processor was
  // deactivated and before it is disconnected from the edit controller (see IConnectionPoint).
  //
  // What to do when the queue is full and no block can be locked?
  // The plug-in needs to be prepared for this situation as constraints in the overall system may cause
  // the queue to get full. If you need to get this information to the controller you can declare a
  // hidden parameter which you set to a special value and send this parameter change in your audio
  // process method.
  IDataExchangeHandler = interface(FUnknown) [GUID_IDataExchangeHandler]
    // open a new queue
    //
    // only allowed to be called from the main thread when the component is not active but
    // initialized and connected (see IConnectionPoint)
    //
    // param processor      the processor who wants to open the queue
    // param blockSize      size of one block
    // param numBlocks      number of blocks in the queue
    // param alignment      data alignment, if zero will use the platform default alignment if any
    // param userContextID  an identifier internal to the processor
    // param outID          on return the ID of the queue
    // return kResultTrue on success
    function OpenQueue(Processor:IAudioProcessor; BlockSize,NumBlocks,Alignment:UInt32;
      UserContextID:TDataExchangeUserContextID; OutID:PDataExchangeQueueID):tresult; winapi;

    // close a queue
    //
    // closes and frees all memory of a previously opened queue
    // if there are locked blocks in the queue, they are freed and made invalid
    //
    // only allowed to be called from the main thread when the component is not active but
    // initialized and connected
    //
    // param queueID  the ID of the queue to close
    // return kResultTrue on success
    function CloseQueue(QueueID:TDataExchangeQueueID):tresult; winapi;

    // lock a block if available
    //
    // only allowed to be called from within the IAudioProcessor::process call
    //
    // param queueID  the ID of the queue
    // param block    on return will contain the data pointer and size of the block
    // return kResultTrue if a free block was found and kOutOfMemory if all blocks are locked
    function LockBlock(QueueID:TDataExchangeQueueID; Block:PDataExchangeBlock):tresult; winapi;

    // free a previously locked block
    // only allowed to be called from within the IAudioProcessor::process call
    // param queueID           the ID of the queue
    // param blockID           the ID of the block
    // param sendToController	 if true the block data will be send to the IEditController otherwise
    //                         it will be discarded
    // return kResultTrue on success
    function FreeBlock(QueueID:TDataExchangeQueueID; BlockID:TDataExchangeBlockID; SendToController:TBool):tresult; winapi;
  end;

  // Data Exchange Receiver interface: Vst::IDataExchangeReceiver
  // - [plug imp]
  // - [released: 3.7.9
  // - [optional]
  // The receiver interface is required to receive data from the realtime audio process via the IDataExchangeHandler.
  IDataExchangeReceiver = interface(FUnknown) [GUID_IDataExchangeReceiver]
    // queue opened notification
    //
    // called on the main thread when the processor has opened a queue
    //
    // param userContextID                 the user context ID of the queue
    // param blockSize                     the size of one block of the queue
    // param dispatchedOnBackgroundThread  if true on output the blocks are dispatched on a
    //                                     background thread [defaults to false in which case the
    //                                     blocks are dispatched on the main thread]
    procedure QueueOpened(UserContextID:TDataExchangeUserContextID; BlockSize:UInt32; var DispatchOnBackgroundThread:TBool); winapi;

    // queue closed notification
    //
    // called on the main thread when the processor has closed a queue
    //
    // param userContextID  the user context ID of the queue
    procedure QueueClosed(UserContextID:TDataExchangeUserContextID); winapi;

    // one or more blocks were received
    //
    // called either on the main thread or a background thread depending on the
    // dispatchOnBackgroundThread value in the queueOpened call.
    //
    // the data of the blocks are only valid inside this call and the blocks only become available
    // to the queue afterwards.
    //
    // param userContextID       the user context ID of the queue
    // param numBlocks           number of blocks
    // param blocks              the blocks
    // param onBackgroundThread  true if the call is done on a background thread
    procedure OnDataExchangeBlocksReceived(UserContextID:TDataExchangeUserContextID; NumBlocks:UInt32;
      Blocks:PDataExchangeBlock; OnBackgroundThread:TBool); winapi;
  end;

type
  TAttrID = PAnsiChar;

  // Attribute list used in IMessage and IStreamAttributes: Vst::IAttributeList
  // - [host imp]
  // - [released: 3.0.0]
  // - [mandatory]
  // An attribute list associates values with a key (id: some predefined keys
  // can be found in presetAttributes).
  IAttributeList = interface(FUnknown) [GUID_IAttributeList]
    // Sets integer value
    function SetInt(id:TAttrID; value:Int64):tresult; winapi;
    // Gets integer value.
    function GetInt(id:TAttrID; var value:Int64):tresult; winapi;
    // Sets float value
    function SetFloat(id:TAttrID; value:Double):tresult; winapi;
    // Gets float value.
    function GetFloat(id:TAttrID; var value:Double):tresult; winapi;
    // Sets string value (UTF16) (should be null-terminated!).
    function SetString(id:TAttrID; str:PChar16):tresult; winapi;
    // Gets string value (UTF16). Note that Size is in Byte, not the string Length!
    // Do not forget to multiply the length by sizeof (TChar)!
    function GetString(id:TAttrID; str:PChar16; SizeInBytes:UInt32):tresult; winapi;
    // Sets binary data.
    function SetBinary(id:TAttrID; data:Pointer; SizeInBytes:UInt32):tresult; winapi;
    // Gets binary data.
    function GetBinary(id:TAttrID; var data:Pointer; var SizeInBytes:UInt32):tresult; winapi;
  end;

  // Meta attributes of a stream: Vst::IStreamAttributes
  // - [host imp]
  // - [extends IBStream]
  // - [released: 3.6.0]
  // - [optional]
  // Interface to access preset meta information from stream, used, for example, in setState in order to inform the plug-in about
  // the current context in which the preset loading occurs (Project context or Preset load (see StateType))
  // or used to get the full file path of the loaded preset (if available).
  IStreamAttributes = interface(FUnknown) [GUID_IStreamAttributes]
    // Gets filename (without file extension) of the stream.
    function GetFileName({Length=128}name:PChar16):tresult; winapi;
    // Gets meta information list.
    function GetAttributes:IAttributeList {$ifdef DCC}unsafe{$endif}; winapi;
  end;

  // Private plug-in message: Vst::IMessage
  // - [host imp]
  // - [create via IHostApplication::createInstance]
  // - [released: 3.0.0]
  // - [mandatory]
  // Messages are sent from a VST controller component to a VST editor component and vice versa.
  IMessage = interface(FUnknown) [GUID_IMessage]
    // Returns the message ID (for example "TextMessage").
    function GetMessageID:FIDString; winapi;
    // Sets a message ID (for example "TextMessage").
    procedure SetMessageID(id:FIDString); winapi;
    // Returns the attribute list associated to the message.
    function GetAttributes:IAttributeList {$ifdef DCC}unsafe{$endif}; winapi;
  end;

  // Connect a component with another one: Vst::IConnectionPoint
  // - [plug imp]
  // - [host imp]
  // - [released: 3.0.0]
  // - [mandatory]
  // This interface is used for the communication of separate components.
  // Note that some hosts will place a proxy object between the components
  // so that they are not directly connected.
  IConnectionPoint = interface(FUnknown) [GUID_IConnectionPoint]
    // Connects this instance with another connection point.
    function Connect(other:IConnectionPoint):tresult; winapi;
    // Disconnects a given connection point from this.
    function Disconnect(other:IConnectionPoint):tresult; winapi;
    // Called when a message has been sent from the connection point to this.
    function Notify(message:IMessage):tresult; winapi;
  end;

type
  // Physical UI Type
  // PhysicalUITypeID describes the type of Physical UI (PUI) which could be associated to a note expression.
  // see PhysicalUIMap
  TPhysicalUITypeID = UInt32;

const
  kPUIXMovement = 0; // absolute X position when touching keys of PUIs. Range [0=left, 0.5=middle, 1=right]
  kPUIYMovement = 1; // absolute Y position when touching keys of PUIs. Range [0=bottom/near, 0.5=center, 1=top/far]
  kPUIPressure  = 2; // pressing a key down on keys of PUIs. Range [0=No Pressure, 1=Full Pressure]
  kPUITypeCount = 3; // count of current defined PUIs
  kInvalidPUITypeID = $FFFFFFFF; // indicates an invalid or not initialized PUI type

type
  PPhysicalUIMap = ^TPhysicalUIMap;
  // PhysicalUIMap describes a mapping of a noteExpression Type to a Physical UI Type.
  // It is used in PhysicalUIMapList.
  // see PhysicalUIMapList
  TPhysicalUIMap = record
    // This represents the physical UI. see TPhysicalUITypeID context, this is set by the caller of getPhysicalUIMapping
    PhysicalUITypeID:TPhysicalUITypeID;
    // This represents the associated noteExpression TypeID to the given physicalUITypeID. This
    // will be filled by the plug-in in the call getPhysicalUIMapping, set it to kInvalidTypeID if
    // no Note Expression is associated to the given PUI.
    NoteExpressionTypeID:TNoteExpressionTypeID;
  end;

  // PhysicalUIMapList describes a list of PhysicalUIMap
  // see INoteExpressionPhysicalUIMapping
  TPhysicalUIMapList = record
    Count:UInt32; // Count of entries in the map array, set by the caller of getPhysicalUIMapping.
    Map:PPhysicalUIMap; // Pointer to a list of PhysicalUIMap containing count entries.
  end;

  // Extended plug-in interface IEditController for note expression event support: Vst::INoteExpressionPhysicalUIMapping
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.6.11]
  // - [optional]
  // With this plug-in interface, the host can retrieve the preferred physical mapping associated to note
  // expression supported by the plug-in.
  // When the mapping changes (for example when switching presets) the plug-in needs
  // to inform the host about it via IComponentHandler::restartComponent (kNoteExpressionChanged).
  INoteExpressionPhysicalUIMapping = interface(FUnknown) [GUID_INoteExpressionPhysicalUIMapping]
    // Fills the list of mapped [physical UI (in) - note expression (out)] for a given bus index and channel.
    function GetPhysicalUIMapping(BusIndex:Int32; Channel:Int16; var list:TPhysicalUIMapList):tresult; winapi;
  end;

type
  // Prefetchable Support Type & Enum, see below
  TPrefetchableSupport = UInt32;

const
  kIsNeverPrefetchable    = 0; // every instance of the plug does not support prefetch processing
  kIsYetPrefetchable      = 1; // in the current state the plug support prefetch processing
  kIsNotYetPrefetchable   = 2; // in the current state the plug does not support prefetch processing
  kNumPrefetchableSupport = 3;

type
  // Indicates that the plug-in could or not support Prefetch (dynamically): Vst::IPrefetchableSupport
  // - [plug imp]
  // - [extends IComponent]
  // - [released: 3.6.5]
  // - [optional]
  // The plug-in should implement this interface if it needs to dynamically change between prefetchable or not.
  // By default (without implementing this interface) the host decides in which mode the plug-in is processed.
  // For more info about the prefetch processing mode check the ProcessModes::kPrefetch documentation.
  IPrefetchableSupport = interface(FUnknown) [GUID_IPrefetchableSupport]
    // retrieve the current prefetch support. Use IComponentHandler::restartComponent
    // (kPrefetchableSupportChanged) to inform the host that this support has changed.
    function GetPrefetchableSupport(var prefetchable:TPrefetchableSupport):tresult; winapi;
  end;

  // Extension for IPlugView to find view parameters (lookup value under mouse support): Vst::IParameterFinder
  // - [plug imp]
  // - [extends IPlugView]
  // - [released: 3.0.2]
  // - [optional]
  // It is highly recommended to implement this interface.
  // A host can implement important functionality when a plug-in supports this interface.
  // For example, all Steinberg hosts require this interface in order to support the "AI Knob".
  IParameterFinder = interface(FUnknown) [GUID_IParameterFinder]
    // Find out which parameter in plug-in view is at given position (relative to plug-in view).
    function FindParameter(xpos,ypos:Int32; var ResultTag:TParamID):tresult; winapi;
  end;

  { TRepresentationInfo }
  // RepresentationInfo is the structure describing a representation
  // This structure is used in the function see IXmlRepresentationController::getXmlRepresentationStream.
  // see IXmlRepresentationController
  TRepresentationInfo = record
  type
    TName = array[0..63] of Char8;
  public
    Vendor: TName; // Vendor name of the associated representation (remote) (eg. "Yamaha").
    Name:   TName; // Representation (remote) Name (eg. "O2").
    Version:TName; // Version of this "Remote" (eg. "1.0").
    Host:   TName; // Optional: used if the representation is for a given host only (eg. "Nuendo").
  end;

  // Extended plug-in interface IEditController for a component: Vst::IXmlRepresentationController
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.5.0]
  // - [optional]
  // A representation based on XML is a way to export, structure, and group plug-ins parameters
  // for a specific remote (hardware or software rack (such as quick controls)).
  // It allows to describe each parameter more precisely (what is the best matching to a knob,
  // different title lengths matching limited remote display,...).
  // - A representation is composed of pages (this means that to see all exported parameters, the user has to navigate through the pages).
  // - A page is composed of cells (for example 8 cells per page).
  // - A cell is composed of layers (for example a cell could have a knob, a display, and a button, which means 3 layers).
  // - A layer is associated to a plug-in parameter using the ParameterID as identifier:
  //    - it could be a knob with a display for title and/or value, this display uses the same parameterId, but it could an another one.
  //    - switch
  //    - link which allows to jump directly to a subpage (another page)
  //    - more... See Vst::LayerType
  // This representation is implemented as XML text following the Document Type Definition (DTD): http://dtd.steinberg.net/VST-Remote-1.1.dtd
  IXmlRepresentationController = interface(FUnknown) [GUID_IXmlRepresentationController]
    // Retrieves a stream containing a XmlRepresentation for a wanted representation info
    function GetXmlRepresentationStream({in}const info:TRepresentationInfo; {out}stream:IBStream):tresult; winapi;
  end;

  // Basic host callback interface: Vst::IHostApplication
  // - [host imp]
  // - [passed as 'context' in to IPluginBase::initialize () ]
  // - [released: 3.0.0]
  // - [mandatory]
  // Basic VST host application interface.
  IHostApplication = interface(FUnknown) [GUID_IHostApplication]
    // Gets host application name.
    function GetName({Length=128}name:PChar16):tresult; winapi;
    // Creates host object (e.g. Vst::IMessage).
    function CreateInstance(const cid:TGuid; const iid:TGuid; out obj):tresult; winapi;
  end;

  // VST 3 to VST 2 Wrapper interface: Vst::IVst3ToVst2Wrapper
  // - [host imp]
  // - [passed as 'context' to IPluginBase::initialize () ]
  // - [released: 3.1.0]
  // - [mandatory]
  // Informs the plug-in that a VST 3 to VST 2 wrapper is used between the plug-in and the real host.
  // Implemented by the VST 2 Wrapper.
  IVst3ToVst2Wrapper = interface(FUnknown) [GUID_IVst3ToVst2Wrapper]
  end;

  // VST 3 to AU Wrapper interface: Vst::IVst3ToAUWrapper
  // - [host imp]
  // - [passed as 'context' to IPluginBase::initialize () ]
  // - [released: 3.1.0]
  // - [mandatory]
  // Informs the plug-in that a VST 3 to AU wrapper is used between the plug-in and the real host.
  // Implemented by the AU Wrapper.
  IVst3ToAUWrapper = interface(FUnknown) [GUID_IVst3ToAUWrapper]
  end;

  // VST 3 to AAX Wrapper interface: Vst::IVst3ToAAXWrapper
  // - [host imp]
  // - [passed as 'context' to IPluginBase::initialize () ]
  // - [released: 3.6.8]
  // - [mandatory]
  // Informs the plug-in that a VST 3 to AAX wrapper is used between the plug-in and the real host.
  // Implemented by the AAX Wrapper.
  IVst3ToAAXWrapper = interface(FUnknown) [GUID_IVst3ToAAXWrapper]
  end;

  // Wrapper MPE Support interface: Vst::IVst3WrapperMPESupport
  // - [host imp]
  // - [passed as 'context' to IPluginBase::initialize () ]
  // - [released: 3.6.12]
  // - [optional]
  // Implemented on wrappers that support MPE to Note Expression translation.
  // By default, MPE input processing is enabled, the masterChannel will be zero, the memberBeginChannel
  // will be one and the memberEndChannel will be 14.
  // As MPE is a subset of the VST3 Note Expression feature, mapping from the three MPE expressions is
  // handled via the INoteExpressionPhysicalUIMapping interface.
  IVst3WrapperMPESupport = interface(FUnknown) [GUID_IVst3WrapperMPESupport]
    // enable or disable MPE processing
    // param state true to enable, false to disable MPE processing
    // return kResultTrue on success
    function EnableMPEInputProcessing(state:TBool):tresult; winapi;
    // setup the MPE processing
    // param masterChannel MPE master channel (zero based)
    // param memberBeginChannel MPE member begin channel (zero based)
    // param memberEndChannel MPE member end channel (zero based)
    // return kResultTrue on success
    function SetMPEInputDeviceSettings(MasterChannel,MemberBeginChannel,MemberEndChannel:Int32):tresult; winapi;
  end;

type
  TAutomationState = Int32;

const
  kNoAutomation = 0;
  kAutoReadState = 1;
  kAutoWriteState = 1 shl 1;
  kAutoReadWriteState = kAutoReadState or kAutoWriteState;

type
  // Extended plug-in interface IEditController: Vst::IAutomationState
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.6.5]
  // - [optional]
  // Hosts can inform the plug-in about its current automation state (Read/Write/Nothing).
  IAutomationState = interface(FUnknown) [GUID_IAutomationState]
    // Sets the current Automation state.
    function SetAutomationState(state:TAutomationState):tresult; winapi;
  end;

  // MIDI Learn interface: Vst::IMidiLearn
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.6.12]
  // - [optional]
  // If this interface is implemented by the edit controller, the host will call this method whenever
  // there is live MIDI-CC input for the plug-in. This way, the plug-in can change its MIDI-CC parameter
  // mapping and inform the host via the IComponentHandler::restartComponent with the
  // kMidiCCAssignmentChanged flag.
  // Use this if you want to implement custom MIDI-Learn functionality in your plug-in.
  IMidiLearn = interface(FUnknown) [GUID_IMidiLearn]
    // Called on live input MIDI-CC change associated to a given bus index and MIDI channel
    function OnLiveMIDIControllerInput(BusIndex:Int32; Channel:Int16; MidiCC:TCtrlNumber):tresult; winapi;
  end;

  // Edit controller component interface extension: Vst::IParameterFunctionName
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.7.0]
  // - [optional]
  // This interface allows the host to get a parameter associated to a specific meaning (a functionName) for a given unit.
  // The host can use this information, for example, for drawing a Gain Reduction meter in its own UI.
  // In order to get the plain value of this parameter, the host should use the IEditController::normalizedParamToPlain.
  // The host can automatically map parameters to dedicated UI controls, such as the wet-dry mix knob or Randomize button.
  IParameterFunctionName = interface(FUnknown) [GUID_IParameterFunctionName]
    // Gets for the given unitID the associated paramID to a function Name.
    // Returns kResultFalse when no found parameter (paramID is set to kNoParamId in this case).
    function GetParameterIDFromFunctionName(UnitID:TUnitID; FuncName:FIDString; var ParamID:TParamID):tresult; winapi;
  end;

  // Host callback interface for an edit controller: Vst::IPlugInterfaceSupport
  // - [host imp]
  // - [released: 3.6.12]
  // - [optional]
  // Allows a plug-in to ask the host if a given plug-in interface is supported/used by the host.
  // It is implemented by the hostContext given when the component is initialized.
  IPlugInterfaceSupport = interface(FUnknown) [GUID_IPlugInterfaceSupport]
    // Returns kResultTrue if the associated interface to the given _iid is supported/used by the host.
    function IsPlugInterfaceSupported(const iid:TGuid):tresult; winapi;
  end;

  IInterAppAudioPresetManager = interface;

  // Inter-App Audio host Interface.
  // - [host imp]
  // - [passed as 'context' to IPluginBase::initialize () ]
  // - [released: 3.6.0]
  // - [optional]
  // Implemented by the InterAppAudio Wrapper.
  IInterAppAudioHost = interface(FUnknown) [GUID_IInterAppAudioHost]
    // get the size of the screen
    // param size size of the screen
    // param scale scale of the screen
    // return kResultTrue on success
    function GetScreenSize(size:PViewRect;scale:PSingle):tresult; winapi;
    // get status of connection
    // return kResultTrue if an Inter-App Audio connection is established
    function ConnectedToHost:tresult; winapi;
    // switch to the host.
    // return kResultTrue on success
    function SwitchToHost:tresult; winapi;
    // send a remote control event to the host
    // param event event type, see AudioUnitRemoteControlEvent in the iOS SDK documentation for possible types
    // return kResultTrue on success
    function SendRemoteControlEvent(event:UInt32):tresult; winapi;
    // ask for the host icon.
    // param icon pointer to a CGImageRef
    // return kResultTrue on success
    function GetHostIcon(icon:PPointer):tresult; winapi;
    // schedule an event from the user interface thread
    // param event the event to schedule
    // return kResultTrue on success
    function ScheduleEventFromUI(var event:TEvent):tresult; winapi;
    // get the preset manager
    // param cid class ID to use by the preset manager
    // return the preset manager. Needs to be released by called.
    function CreatePresetManager(const cid:TGuid):IInterAppAudioPresetManager {$ifdef DCC}unsafe{$endif}; winapi;
    // show the settings view
    // currently includes MIDI settings and Tempo setting
    // return kResultTrue on success
    function ShowSettingsView:tresult; winapi;
  end;

  // Extended plug-in interface IEditController for Inter-App Audio connection state change notifications
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.6.0]
  IInterAppAudioConnectionNotification = interface(FUnknown) [GUID_IInterAppAudioConnectionNotification]
    // called when the Inter-App Audio connection state changes
    // param newState true if an Inter-App Audio connection is established, otherwise false
    procedure OnInterAppAudioConnectionStateChange(NewState:TBool); winapi;
  end;

  // Extended plug-in interface IEditController for Inter-App Audio Preset Management
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.6.0]
  IInterAppAudioPresetManager = interface(FUnknown)
    ['{ADE6FCC4-46C9-4E1D-B3B4-9A80C93FEFDD}']
    // Open the Preset Browser in order to load a preset
    function RunLoadPresetBrowser:tresult; winapi;
    // Open the Preset Browser in order to save a preset
    function RunSavePresetBrowser:tresult; winapi;
    // Load the next available preset
    function LoadNextPreset:tresult; winapi;
    // Load the previous available preset
    function LoadPreviousPreset:tresult; winapi;
  end;

const
  kPluginCompatibilityClass = 'Plugin Compatibility Class';

type
  // optional interface to query the compatibility of the plug-ins classes
  // - [plug imp]
  // - [released: 3.7.5]
  // A plug-in can add a class with this interface to its class factory if it cannot provide a
  // moduleinfo.json file in its plug-in package/bundle where the compatibility is normally part of.
  // If the module contains a moduleinfo.json the host will ignore this class.
  // The class must write into the stream an UTF-8 encoded json description of the compatibility of
  // the other classes in the factory.
  IPluginCompatibility = interface(FUnknown) [GUID_IPluginCompatibility]
    // get the compatibility stream
    // param stream the stream the plug-in must write the UTF8 encoded JSON5 compatibility string.
    // return kResultTrue on success
    function GetCompatibilityJSON(stream:IBStream):tresult; winapi;
  end;

  // Extended IEditController interface for a component.
  // - [plug imp]
  // - [extends IEditController]
  // - [released: 3.7.11]
  // - [optional]
  // When replacing one plug-in with another, the host can ask the new plug-in for remapping paramIDs to
  // new ones.
  IRemapParamID = interface(FUnknown) [GUID_IRemapParamID]
    // Retrieve the appropriate paramID for a specific plug-in UID and paramID (or index for VST 2 plug-ins).
    // The retrieved paramID should match the one it replaces, maintaining the same
    // behavior during automation playback. Called in UI-Thread context.
    // [in] PluginToReplaceUID - TUID of plug-in (processor) that will be replaced
    // [in] OldParamID - paramID (or index for VST 2 plug-ins) to be replaced
    // [out] NewParamID - contains the associated paramID to be used
    // return kResultTrue if a compatible parameter is available (newParamID has the appropriate
    // value, it could be the same than oldParamID), or kResultFalse if no compatible parameter is
    // available (newParamID is undefined)
    function GetCompatibleParamID(const {in}PluginToReplaceUID:TGuid; {in}OldParamID:TParamID; out NewParamID:TParamID):tresult; winapi;
  end;

{$ifdef FPC} {$pop} {$else} {$A+} {$endif}

{ Others }

const
  // OS-independent enumeration of virtual keycodes.

  KEY_BACK = 1;
  KEY_TAB = 2;
  KEY_CLEAR = 3;
  KEY_RETURN = 4;
  KEY_PAUSE = 5;
  KEY_ESCAPE = 6;
  KEY_SPACE = 7;
  KEY_NEXT = 8;
  KEY_END = 9;
  KEY_HOME = 10;
  KEY_LEFT = 11;
  KEY_UP = 12;
  KEY_RIGHT = 13;
  KEY_DOWN = 14;
  KEY_PAGEUP = 15;
  KEY_PAGEDOWN = 16;
  KEY_SELECT = 17;
  KEY_PRINT = 18;
  KEY_ENTER = 19;
  KEY_SNAPSHOT = 20;
  KEY_INSERT = 21;
  KEY_DELETE = 22;
  KEY_HELP = 23;
  KEY_NUMPAD0 = 24;
  KEY_NUMPAD1 = 25;
  KEY_NUMPAD2 = 26;
  KEY_NUMPAD3 = 27;
  KEY_NUMPAD4 = 28;
  KEY_NUMPAD5 = 29;
  KEY_NUMPAD6 = 30;
  KEY_NUMPAD7 = 31;
  KEY_NUMPAD8 = 32;
  KEY_NUMPAD9 = 33;
  KEY_MULTIPLY = 34;
  KEY_ADD = 35;
  KEY_SEPARATOR = 36;
  KEY_SUBTRACT = 37;
  KEY_DECIMAL = 38;
  KEY_DIVIDE = 39;
  KEY_F1 = 40;
  KEY_F2 = 41;
  KEY_F3 = 42;
  KEY_F4 = 43;
  KEY_F5 = 44;
  KEY_F6 = 45;
  KEY_F7 = 46;
  KEY_F8 = 47;
  KEY_F9 = 48;
  KEY_F10 = 49;
  KEY_F11 = 50;
  KEY_F12 = 51;
  KEY_NUMLOCK = 52;
  KEY_SCROLL = 53;
  KEY_SHIFT = 54;
  KEY_CONTROL = 55;
  KEY_ALT = 56;
  KEY_EQUALS = 57;      // only occurs on a Mac
  KEY_CONTEXTMENU = 58; // Windows only

  // multimedia keys

  KEY_MEDIA_PLAY = 59;
  KEY_MEDIA_STOP = 60;
  KEY_MEDIA_PREV = 61;
  KEY_MEDIA_NEXT = 62;
  KEY_VOLUME_UP = 63;
  KEY_VOLUME_DOWN = 64;

  KEY_F13 = 65;
  KEY_F14 = 66;
  KEY_F15 = 67;
  KEY_F16 = 68;
  KEY_F17 = 69;
  KEY_F18 = 70;
  KEY_F19 = 71;
  KEY_F20 = 72;
  KEY_F21 = 73;
  KEY_F22 = 74;
  KEY_F23 = 75;
  KEY_F24 = 76;

  KEY_SUPER = 77; // Win-Key on Windows, Ctrl-Key on macOS

  VKEY_FIRST_CODE = KEY_BACK;
  VKEY_LAST_CODE  = KEY_SUPER;

  // KEY_0 - KEY_9 are the same as ASCII '0' - '9' (0x30 - 0x39) + FIRST_ASCII
  // KEY_A - KEY_Z are the same as ASCII 'A' - 'Z' (0x41 - 0x5A) + FIRST_ASCII
  VKEY_FIRST_ASCII = 128;

  // OS-independent enumeration of virtual modifier-codes

  kShiftKey = 1 shl 0;     // same on Windows and macOS
  kAlternateKey = 1 shl 1; // same on Windows and macOS
  kCommandKey = 1 shl 2;   // windows: ctrl key, macOS: cmd key
  kControlKey = 1 shl 3;   // windows: win key, macOS: ctrl key

type
  // Simple data-struct representing a key-stroke on the keyboard.
  TKeyCode = record
    Character:Char; // The associated character.
    Virt:UInt8;     // The associated virtual key-code.
    Modifier:UInt8; // The associated virtual modifier-code.
  end;

const
  IID_FUnknown:TGuid = GUID_FUnknown;
  IID_IBStream:TGuid = GUID_IBStream;
  IID_ISizeableStream:TGuid = GUID_ISizeableStream;
  IID_IPluginBase:TGuid = GUID_IPluginBase;
  IID_IPluginFactory:TGuid = GUID_IPluginFactory;
  IID_IPluginFactory2:TGuid = GUID_IPluginFactory2;
  IID_IPluginFactory3:TGuid = GUID_IPluginFactory3;
  IID_IStringResult:TGuid = GUID_IStringResult;
  IID_IString:TGuid = GUID_IString;
  IID_IUpdateHandler:TGuid = GUID_IUpdateHandler;
  IID_IDependent:TGuid = GUID_IDependent;
  IID_IPersistent:TGuid = GUID_IPersistent;
  IID_IAttributes:TGuid = GUID_IAttributes;
  IID_IAttributes2:TGuid = GUID_IAttributes2;
  IID_IErrorContext:TGuid = GUID_IErrorContext;
  IID_ICloneable:TGuid = GUID_ICloneable;
  IID_IPlugFrame:TGuid = GUID_IPlugFrame;
  IID_IPlugView:TGuid = GUID_IPlugView;
{$ifdef LINUX}
  IID_IEventHandler:TGuid = GUID_IEventHandler;
  IID_ITimerHandler:TGuid = GUID_ITimerHandler;
  IID_IRunLoop:TGuid = GUID_IRunLoop;
{$endif}
  IID_IPlugViewContentScaleSupport:TGuid = GUID_IPlugViewContentScaleSupport;
  IID_IAttributeList:TGuid = GUID_IAttributeList;
  IID_IStreamAttributes:TGuid = GUID_IStreamAttributes;
  IID_IUnitHandler:TGuid = GUID_IUnitHandler;
  IID_IUnitHandler2:TGuid = GUID_IUnitHandler2;
  IID_IUnitInfo:TGuid = GUID_IUnitInfo;
  IID_IProgramListData:TGuid = GUID_IProgramListData;
  IID_IUnitData:TGuid = GUID_IUnitData;
  IID_IContextMenu:TGuid = GUID_IContextMenu;
  IID_IComponentHandler3:TGuid = GUID_IComponentHandler3;
  IID_IContextMenuTarget:TGuid = GUID_IContextMenuTarget;
  IID_IComponent:TGuid = GUID_IComponent;
  IID_IComponentHandler:TGuid = GUID_IComponentHandler;
  IID_IComponentHandler2:TGuid = GUID_IComponentHandler2;
  IID_IComponentHandlerBusActivation:TGuid = GUID_IComponentHandlerBusActivation;
  IID_IProgress:TGuid = GUID_IProgress;
  IID_IEditController:TGuid = GUID_IEditController;
  IID_IEditController2:TGuid = GUID_IEditController2;
  IID_IMidiMapping:TGuid = GUID_IMidiMapping;
  IID_IEditControllerHostEditing:TGuid = GUID_IEditControllerHostEditing;
  IID_IComponentHandlerSystemTime:TGuid = GUID_IComponentHandlerSystemTime;
  IID_IParamValueQueue:TGuid = GUID_IParamValueQueue;
  IID_IParameterChanges:TGuid = GUID_IParameterChanges;
  IID_INoteExpressionController:TGuid = GUID_INoteExpressionController;
  IID_IKeyswitchController:TGuid = GUID_IKeyswitchController;
  IID_INoteExpressionPhysicalUIMapping:TGuid = GUID_INoteExpressionPhysicalUIMapping;
  IID_IEventList:TGuid = GUID_IEventList;
  IID_IAudioProcessor:TGuid = GUID_IAudioProcessor;
  IID_IAudioPresentationLatency:TGuid = GUID_IAudioPresentationLatency;
  IID_IProcessContextRequirements:TGuid = GUID_IProcessContextRequirements;
  IID_IDataExchangeHandler:TGuid = GUID_IDataExchangeHandler;
  IID_IDataExchangeReceiver:TGuid = GUID_IDataExchangeReceiver;
  IID_IMessage:TGuid = GUID_IMessage;
  IID_IConnectionPoint:TGuid = GUID_IConnectionPoint;
  IID_IPrefetchableSupport:TGuid = GUID_IPrefetchableSupport;
  IID_IParameterFinder:TGuid = GUID_IParameterFinder;
  IID_IXmlRepresentationController:TGuid = GUID_IXmlRepresentationController;
  IID_IHostApplication:TGuid = GUID_IHostApplication;
  IID_IVst3ToVst2Wrapper:TGuid = GUID_IVst3ToVst2Wrapper;
  IID_IVst3ToAUWrapper:TGuid = GUID_IVst3ToAUWrapper;
  IID_IVst3ToAAXWrapper:TGuid = GUID_IVst3ToAAXWrapper;
  IID_IVst3WrapperMPESupport:TGuid = GUID_IVst3WrapperMPESupport;
  IID_IAutomationState:TGuid = GUID_IAutomationState;
  IID_IMidiLearn:TGuid = GUID_IMidiLearn;
  IID_IParameterFunctionName:TGuid = GUID_IParameterFunctionName;
  IID_IPlugInterfaceSupport:TGuid = GUID_IPlugInterfaceSupport;
  IID_IInterAppAudioHost:TGuid = GUID_IInterAppAudioHost;
  IID_IInterAppAudioConnectionNotification:TGuid = GUID_IInterAppAudioConnectionNotification;
  IID_IInterAppAudioPresetManager:TGuid = GUID_IInterAppAudioPresetManager;
  IID_IPluginCompatibility:TGuid = GUID_IPluginCompatibility;
  IID_IRemapParamID:TGuid = GUID_IRemapParamID;

type
  // Predefined Preset Attributes
  TPresetAttributes = record
  public const
    kPlugInName         = 'PlugInName';     // plug-in name
    kPlugInCategory     = 'PlugInCategory'; // eg. "Fx|Dynamics", "Instrument", "Instrument|Synth"

    kInstrument         = 'MusicalInstrument'; // eg. instrument group (like 'Piano' or 'Piano|A. Piano')
    kStyle              = 'MusicalStyle';      // eg. 'Pop', 'Jazz', 'Classic'
    kCharacte           = 'MusicalCharacter';  // eg. instrument nature (like 'Soft' 'Dry' 'Acoustic')

    kStateType          = 'StateType'; // Type of the given state see StateType : Project / Default Preset or Normal Preset
    kFilePathStringType = 'FilePathString'; // Full file path string (if available) where the preset comes from (be sure to use a bigger string when asking for it (with 1024 characters))
    kName               = 'Name';     // name of the preset
    kFileName           = 'FileName'; // filename of the preset (including extension)
  end;

  // Predefined StateType used for Key kStateType
  TStateType = record
  public const
    kProject = 'Project'; // the state is restored from a project loading or it is saved in a project
    kDefault = 'Default'; // the state is restored from a preset (marked as default) or the host wants to store a default state of the plug-in
  end;

  // Predefined Musical Instrument
  TMusicalInstrument = record
  public const
    kAccordion          = 'Accordion';
    kAccordionAccordion = 'Accordion|Accordion';
    kAccordionHarmonica = 'Accordion|Harmonica';
    kAccordionOther     = 'Accordion|Other';

    kBass          = 'Bass';
    kBassABass     = 'Bass|A. Bass';
    kBassEBass     = 'Bass|E. Bass';
    kBassSynthBass = 'Bass|Synth Bass';
    kBassOther     = 'Bass|Other';

    kBrass           = 'Brass';
    kBrassFrenchHorn = 'Brass|French Horn';
    kBrassTrumpet    = 'Brass|Trumpet';
    kBrassTrombone   = 'Brass|Trombone';
    kBrassTuba       = 'Brass|Tuba';
    kBrassSection    = 'Brass|Section';
    kBrassSynth      = 'Brass|Synth';
    kBrassOther      = 'Brass|Other';

    kChromaticPerc           = 'Chromatic Perc';
    kChromaticPercBell       = 'Chromatic Perc|Bell';
    kChromaticPercMallett    = 'Chromatic Perc|Mallett';
    kChromaticPercWood       = 'Chromatic Perc|Wood';
    kChromaticPercPercussion = 'Chromatic Perc|Percussion';
    kChromaticPercTimpani    = 'Chromatic Perc|Timpani';
    kChromaticPercOther      = 'Chromatic Perc|Other';

    kDrumPerc           = 'Drum&Perc';
    kDrumPercDrumsetGM  = 'Drum&Perc|Drumset GM';
    kDrumPercDrumset    = 'Drum&Perc|Drumset';
    kDrumPercDrumMenues = 'Drum&Perc|Drum Menues';
    kDrumPercBeats      = 'Drum&Perc|Beats';
    kDrumPercPercussion = 'Drum&Perc|Percussion';
    kDrumPercKickDrum   = 'Drum&Perc|Kick Drum';
    kDrumPercSnareDrum  = 'Drum&Perc|Snare Drum';
    kDrumPercToms       = 'Drum&Perc|Toms';
    kDrumPercHiHats     = 'Drum&Perc|HiHats';
    kDrumPercCymbals    = 'Drum&Perc|Cymbals';
    kDrumPercOther      = 'Drum&Perc|Other';

    kEthnic         = 'Ethnic';
    kEthnicAsian    = 'Ethnic|Asian';
    kEthnicAfrican  = 'Ethnic|African';
    kEthnicEuropean = 'Ethnic|European';
    kEthnicLatin    = 'Ethnic|Latin';
    kEthnicAmerican = 'Ethnic|American';
    kEthnicAlien    = 'Ethnic|Alien';
    kEthnicOther    = 'Ethnic|Other';

    kGuitar        = 'Guitar/Plucked';
    kGuitarAGuitar = 'Guitar/Plucked|A. Guitar';
    kGuitarEGuitar = 'Guitar/Plucked|E. Guitar';
    kGuitarHarp    = 'Guitar/Plucked|Harp';
    kGuitarEthnic  = 'Guitar/Plucked|Ethnic';
    kGuitarOther   = 'Guitar/Plucked|Other';

    kKeyboard            = 'Keyboard';
    kKeyboardClavi       = 'Keyboard|Clavi';
    kKeyboardEPiano      = 'Keyboard|E. Piano';
    kKeyboardHarpsichord = 'Keyboard|Harpsichord';
    kKeyboardOther       = 'Keyboard|Other';

    kMusicalFX           = 'Musical FX';
    kMusicalFXHitsStabs  = 'Musical FX|Hits&Stabs';
    kMusicalFXMotion     = 'Musical FX|Motion';
    kMusicalFXSweeps     = 'Musical FX|Sweeps';
    kMusicalFXBeepsBlips = 'Musical FX|Beeps&Blips';
    kMusicalFXScratches  = 'Musical FX|Scratches';
    kMusicalFXOther      = 'Musical FX|Other';

    kOrgan         = 'Organ';
    kOrganElectric = 'Organ|Electric';
    kOrganPipe     = 'Organ|Pipe';
    kOrganOther    = 'Organ|Other';

    kPiano       = 'Piano';
    kPianoAPiano = 'Piano|A. Piano';
    kPianoEGrand = 'Piano|E. Grand';
    kPianoOther  = 'Piano|Other';

    kSoundFX           = 'Sound FX';
    kSoundFXNature     = 'Sound FX|Nature';
    kSoundFXMechanical = 'Sound FX|Mechanical';
    kSoundFXSynthetic  = 'Sound FX|Synthetic';
    kSoundFXOther      = 'Sound FX|Other';

    kStrings        = 'Strings';
    kStringsViolin  = 'Strings|Violin';
    kStringsViola   = 'Strings|Viola';
    kStringsCello   = 'Strings|Cello';
    kStringsBass    = 'Strings|Bass';
    kStringsSection = 'Strings|Section';
    kStringsSynth   = 'Strings|Synth';
    kStringsOther   = 'Strings|Other';

    kSynthLead         = 'Synth Lead';
    kSynthLeadAnalog   = 'Synth Lead|Analog';
    kSynthLeadDigital  = 'Synth Lead|Digital';
    kSynthLeadArpeggio = 'Synth Lead|Arpeggio';
    kSynthLeadOther    = 'Synth Lead|Other';

    kSynthPad           = 'Synth Pad';
    kSynthPadSynthChoir = 'Synth Pad|Synth Choir';
    kSynthPadAnalog     = 'Synth Pad|Analog';
    kSynthPadDigital    = 'Synth Pad|Digital';
    kSynthPadMotion     = 'Synth Pad|Motion';
    kSynthPadOther      = 'Synth Pad|Other';

    kSynthComp        = 'Synth Comp';
    kSynthCompAnalog  = 'Synth Comp|Analog';
    kSynthCompDigital = 'Synth Comp|Digital';
    kSynthCompOther   = 'Synth Comp|Other';

    kVocal          = 'Vocal';
    kVocalLeadVocal = 'Vocal|Lead Vocal';
    kVocalAdlibs    = 'Vocal|Adlibs';
    kVocalChoir     = 'Vocal|Choir';
    kVocalSolo      = 'Vocal|Solo';
    kVocalFX        = 'Vocal|FX';
    kVocalSpoken    = 'Vocal|Spoken';
    kVocalOther     = 'Vocal|Other';

    kWoodwinds          = 'Woodwinds';
    kWoodwindsEthnic    = 'Woodwinds|Ethnic';
    kWoodwindsFlute     = 'Woodwinds|Flute';
    kWoodwindsOboe      = 'Woodwinds|Oboe';
    kWoodwindsEnglHorn  = 'Woodwinds|Engl. Horn';
    kWoodwindsClarinet  = 'Woodwinds|Clarinet';
    kWoodwindsSaxophone = 'Woodwinds|Saxophone';
    kWoodwindsBassoon   = 'Woodwinds|Bassoon';
    kWoodwindsOther     = 'Woodwinds|Other';
  end;

  // Predefined Musical Style
  TMusicalStyle = record
  public const
    kAlternativeIndie            = 'Alternative/Indie';
    kAlternativeIndieGothRock    = 'Alternative/Indie|Goth Rock';
    kAlternativeIndieGrunge      = 'Alternative/Indie|Grunge';
    kAlternativeIndieNewWave     = 'Alternative/Indie|New Wave';
    kAlternativeIndiePunk        = 'Alternative/Indie|Punk';
    kAlternativeIndieCollegeRock = 'Alternative/Indie|College Rock';
    kAlternativeIndieDarkWave    = 'Alternative/Indie|Dark Wave';
    kAlternativeIndieHardcore    = 'Alternative/Indie|Hardcore';

    kAmbientChillOut                 = 'Ambient/ChillOut';
    kAmbientChillOutNewAgeMeditation = 'Ambient/ChillOut|New Age/Meditation';
    kAmbientChillOutDarkAmbient      = 'Ambient/ChillOut|Dark Ambient';
    kAmbientChillOutDowntempo        = 'Ambient/ChillOut|Downtempo';
    kAmbientChillOutLounge           = 'Ambient/ChillOut|Lounge';

    kBlues              = 'Blues';
    kBluesAcousticBlues = 'Blues|Acoustic Blues';
    kBluesCountryBlues  = 'Blues|Country Blues';
    kBluesElectricBlues = 'Blues|Electric Blues';
    kBluesChicagoBlues  = 'Blues|Chicago Blues';

    kClassical                  = 'Classical';
    kClassicalBaroque           = 'Classical|Baroque';
    kClassicalChamberMusic      = 'Classical|Chamber Music';
    kClassicalMedieval          = 'Classical|Medieval';
    kClassicalModernComposition = 'Classical|Modern Composition';
    kClassicalOpera             = 'Classical|Opera';
    kClassicalGregorian         = 'Classical|Gregorian';
    kClassicalRenaissance       = 'Classical|Renaissance';
    kClassicalClassic           = 'Classical|Classic';
    kClassicalRomantic          = 'Classical|Romantic';
    kClassicalSoundtrack        = 'Classical|Soundtrack';

    kCountry                  = 'Country';
    kCountryCountryWestern    = 'Country|Country/Western';
    kCountryHonkyTonk         = 'Country|Honky Tonk';
    kCountryUrbanCowboy       = 'Country|Urban Cowboy';
    kCountryBluegrass         = 'Country|Bluegrass';
    kCountryAmericana         = 'Country|Americana';
    kCountrySquaredance       = 'Country|Squaredance';
    kCountryNorthAmericanFolk = 'Country|North American Folk';

    kElectronicaDance                    = 'Electronica/Dance';
    kElectronicaDanceMinimal             = 'Electronica/Dance|Minimal';
    kElectronicaDanceClassicHouse        = 'Electronica/Dance|Classic House';
    kElectronicaDanceElektroHouse        = 'Electronica/Dance|Elektro House';
    kElectronicaDanceFunkyHouse          = 'Electronica/Dance|Funky House';
    kElectronicaDanceIndustrial          = 'Electronica/Dance|Industrial';
    kElectronicaDanceElectronicBodyMusic = 'Electronica/Dance|Electronic Body Music';
    kElectronicaDanceTripHop             = 'Electronica/Dance|Trip Hop';
    kElectronicaDanceTechno              = 'Electronica/Dance|Techno';
    kElectronicaDanceDrumNBassJungle     = 'Electronica/Dance|Drum''n''Bass/Jungle'; // in pascal use ''
    kElectronicaDanceElektro             = 'Electronica/Dance|Elektro';
    kElectronicaDanceTrance              = 'Electronica/Dance|Trance';
    kElectronicaDanceDub                 = 'Electronica/Dance|Dub';
    kElectronicaDanceBigBeats            = 'Electronica/Dance|Big Beats';

    kExperimental                   = 'Experimental';
    kExperimentalNewMusic           = 'Experimental|New Music';
    kExperimentalFreeImprovisation  = 'Experimental|Free Improvisation';
    kExperimentalElectronicArtMusic = 'Experimental|Electronic Art Music';
    kExperimentalNoise              = 'Experimental|Noise';

    kJazz                    = 'Jazz';
    kJazzNewOrleansJazz      = 'Jazz|New Orleans Jazz';
    kJazzTraditionalJazz     = 'Jazz|Traditional Jazz';
    kJazzOldtimeJazzDixiland = 'Jazz|Oldtime Jazz/Dixiland';
    kJazzFusion              = 'Jazz|Fusion';
    kJazzAvantgarde          = 'Jazz|Avantgarde';
    kJazzLatinJazz           = 'Jazz|Latin Jazz';
    kJazzFreeJazz            = 'Jazz|Free Jazz';
    kJazzRagtime             = 'Jazz|Ragtime';

    kPop           = 'Pop';
    kPopBritpop    = 'Pop|Britpop';
    kPopRock       = 'Pop|Pop/Rock';
    kPopTeenPop    = 'Pop|Teen Pop';
    kPopChartDance = 'Pop|Chart Dance';
    sPop           = 'Pop|80''s Pop';
    kPopDancehall  = 'Pop|Dancehall';
    kPopDisco      = 'Pop|Disco';

    kRockMetal                 = 'Rock/Metal';
    kRockMetalBluesRock        = 'Rock/Metal|Blues Rock';
    kRockMetalClassicRock      = 'Rock/Metal|Classic Rock';
    kRockMetalHardRock         = 'Rock/Metal|Hard Rock';
    kRockMetalRockRoll         = 'Rock/Metal|Rock &amp; Roll';
    kRockMetalSingerSongwriter = 'Rock/Metal|Singer/Songwriter';
    kRockMetalHeavyMetal       = 'Rock/Metal|Heavy Metal';
    kRockMetalDeathBlackMetal  = 'Rock/Metal|Death/Black Metal';
    kRockMetalNuMetal          = 'Rock/Metal|NuMetal';
    kRockMetalReggae           = 'Rock/Metal|Reggae';
    kRockMetalBallad           = 'Rock/Metal|Ballad';
    kRockMetalAlternativeRock  = 'Rock/Metal|Alternative Rock';
    kRockMetalRockabilly       = 'Rock/Metal|Rockabilly';
    kRockMetalThrashMetal      = 'Rock/Metal|Thrash Metal';
    kRockMetalProgressiveRock  = 'Rock/Metal|Progressive Rock';

    kUrbanHipHopRB                = 'Urban (Hip-Hop / R&B)';
    kUrbanHipHopRBClassic         = 'Urban (Hip-Hop / R&B)|Classic R&B';
    kUrbanHipHopRBModern          = 'Urban (Hip-Hop / R&B)|Modern R&B';
    kUrbanHipHopRBPop             = 'Urban (Hip-Hop / R&B)|R&B Pop';
    kUrbanHipHopRBWestCoastHipHop = 'Urban (Hip-Hop / R&B)|WestCoast Hip-Hop';
    kUrbanHipHopRBEastCoastHipHop = 'Urban (Hip-Hop / R&B)|EastCoast Hip-Hop';
    kUrbanHipHopRBRapHipHop       = 'Urban (Hip-Hop / R&B)|Rap/Hip Hop';
    kUrbanHipHopRBSoul            = 'Urban (Hip-Hop / R&B)|Soul';
    kUrbanHipHopRBFunk            = 'Urban (Hip-Hop / R&B)|Funk';

    kWorldEthnic              = 'World/Ethnic';
    kWorldEthnicAfrica        = 'World/Ethnic|Africa';
    kWorldEthnicAsia          = 'World/Ethnic|Asia';
    kWorldEthnicCeltic        = 'World/Ethnic|Celtic';
    kWorldEthnicEurope        = 'World/Ethnic|Europe';
    kWorldEthnicKlezmer       = 'World/Ethnic|Klezmer';
    kWorldEthnicScandinavia   = 'World/Ethnic|Scandinavia';
    kWorldEthnicEasternEurope = 'World/Ethnic|Eastern Europe';
    kWorldEthnicIndiaOriental = 'World/Ethnic|India/Oriental';
    kWorldEthnicNorthAmerica  = 'World/Ethnic|North America';
    kWorldEthnicSouthAmerica  = 'World/Ethnic|South America';
    kWorldEthnicAustralia     = 'World/Ethnic|Australia';
  end;

  // Predefined Musical Character
  TMusicalCharacter = record // Like namespace, e.g. TMusicalCharacter.kMono
  public const
    //----TYPE------------------------------------

    kMono = 'Mono'; // Conflict with the same identifier below (TSpeakerArrangement)
    kPoly = 'Poly';

    kSplit = 'Split';
    kLayer = 'Layer';

    kGlide     = 'Glide';
    kGlissando = 'Glissando';

    kMajor = 'Major';
    kMinor = 'Minor';

    kSingle   = 'Single';
    kEnsemble = 'Ensemble';

    kAcoustic = 'Acoustic';
    kElectric = 'Electric';

    kAnalog  = 'Analog';
    kDigital = 'Digital';

    kVintage = 'Vintage';
    kModern  = 'Modern';

    kOld = 'Old';
    kNew = 'New';

    //----TONE------------------------------------

    kClean     = 'Clean';
    kDistorted = 'Distorted';

    kDry       = 'Dry';
    kProcessed = 'Processed';

    kHarmonic  = 'Harmonic';
    kDissonant = 'Dissonant';

    kClear = 'Clear';
    kNoisy = 'Noisy';

    kThin = 'Thin';
    kRich = 'Rich';

    kDark   = 'Dark';
    kBright = 'Bright';

    kCold = 'Cold';
    kWarm = 'Warm';

    kMetallic = 'Metallic';
    kWooden   = 'Wooden';

    kGlass   = 'Glass';
    kPlastic = 'Plastic';

    //----ENVELOPE------------------------------------
    kPercussive = 'Percussive';
    kSoft       = 'Soft';

    kFast = 'Fast';
    kSlow = 'Slow';

    kShort = 'Short';
    kLong  = 'Long';

    kAttack  = 'Attack';
    kRelease = 'Release';

    kDecay   = 'Decay';
    kSustain = 'Sustain';

    kFastAttack = 'Fast Attack';
    kSlowAttack = 'Slow Attack';

    kShortRelease = 'Short Release';
    kLongRelease  = 'Long Release';

    kStatic = 'Static';
    kMoving = 'Moving';

    kLoop    = 'Loop';
    kOneShot = 'One Shot';
  end;

  TVstPlugType = record
  public const
    kFx                   = 'Fx';            // others type (not categorized)
    kFxAnalyzer           = 'Fx|Analyzer';   // Scope, FFT-Display, Loudness Processing...
    kFxBass               = 'Fx|Bass';       // Tools dedicated to Bass Guitar
    kFxChannelStrip       = 'Fx|Channel Strip'; // Tools dedicated to Channel Strip
    kFxDelay              = 'Fx|Delay';      // Delay, Multi-tap Delay, Ping-Pong Delay...
    kFxDistortion         = 'Fx|Distortion'; // Amp Simulator, Sub-Harmonic, SoftClipper...
    kFxDrums              = 'Fx|Drums';      // Tools dedicated to Drums...
    kFxDynamics           = 'Fx|Dynamics';   // Compressor, Expander, Gate, Limiter, Maximizer, Tape Simulator, EnvelopeShaper...
    kFxEQ                 = 'Fx|EQ';         // Equalization, Graphical EQ...
    kFxFilter             = 'Fx|Filter';     // WahWah, ToneBooster, Specific Filter,...
    kFxGenerator          = 'Fx|Generator';  // Tone Generator, Noise Generator...
    kFxGuitar             = 'Fx|Guitar';     // Tools dedicated to Guitar
    kFxInstrument         = 'Fx|Instrument'; // Fx which could be loaded as Instrument too
    kFxInstrumentExternal = 'Fx|Instrument|External'; // Fx which could be loaded as Instrument too and is external (wrapped Hardware)
    kFxMastering          = 'Fx|Mastering';   // Dither, Noise Shaping,...
    kFxMicrophone         = 'Fx|Microphone';  // Tools dedicated to Microphone
    kFxModulation         = 'Fx|Modulation';  // Phaser, Flanger, Chorus, Tremolo, Vibrato, AutoPan, Rotary, Cloner...
    kFxNetwork            = 'Fx|Network';     // using Network
    kFxPitchShift         = 'Fx|Pitch Shift'; // Pitch Processing, Pitch Correction, Vocal Tuning...
    kFxRestoration        = 'Fx|Restoration'; // Denoiser, Declicker,...
    kFxReverb             = 'Fx|Reverb';      // Reverberation, Room Simulation, Convolution Reverb...
    kFxSpatial            = 'Fx|Spatial';     // MonoToStereo, StereoEnhancer,...
    kFxSurround           = 'Fx|Surround';    // dedicated to surround processing: LFE Splitter, Bass Manager...
    kFxTools              = 'Fx|Tools';       // Volume, Mixer, Tuner...
    kFxVovals             = 'Fx|Vocals';      // Tools dedicated to Vocals

    kInstrument             = 'Instrument';          // Effect used as instrument (sound generator), not as insert
    kInstrumentDrum         = 'Instrument|Drum';     // Instrument for Drum sounds
    kInstrumentExternal     = 'Instrument|External'; // External Instrument (wrapped Hardware)
    kInstrumentPiano        = 'Instrument|Piano';    // Instrument for Piano sounds
    kInstrumentSampler      = 'Instrument|Sampler';  // Instrument based on Samples
    kInstrumentSynth        = 'Instrument|Synth';    // Instrument based on Synthesis
    kInstrumentSynthSampler = 'Instrument|Synth|Sampler'; // Instrument based on Synthesis and Samples

    kAmbisonics         = 'Ambisonics'; // used for Ambisonics channel (FX or Panner/Mixconverter/Up-Mixer/Down-Mixer when combined with other category)
    kAnalyzer           = 'Analyzer';   // Meter, Scope, FFT-Display, not selectable as insert plug-in
    kNoOfflineProcess   = 'NoOfflineProcess'; // will be NOT used for plug-in offline processing (will work as normal insert plug-in)
    kOnlyARA            = 'OnlyARA'; // used for plug-ins that require ARA to operate (will not work as normal insert plug-in)
    kOnlyOfflineProcess = 'OnlyOfflineProcess'; // used for plug-in offline processing  (will not work as normal insert plug-in)
    kOnlyRealTime       = 'OnlyRT'; // indicates that it supports only realtime process call, no processing faster than realtime
    kSpatial            = 'Spatial';    // used for SurroundPanner
    kSpatialFx          = 'Spatial|Fx'; // used for SurroundPanner and as insert effect
    kUpDownMix          = 'Up-Downmix'; // used for Mixconverter/Up-Mixer/Down-Mixer

    kMono     = 'Mono';     // used for Mono only plug-in [optional]
    kStereo   = 'Stereo';   // used for Stereo only plug-in [optional]
    kSurround = 'Surround'; // used for Surround only plug-in [optional]
  end;

const
  // Defines for XML representation Tags and Attributes

  TAG_ROOTXML = 'vstXML';

  TAG_COMMENT = 'comment';
  TAG_CELL_ = 'cell';
  TAG_CELLGROUP = 'cellGroup';
  TAG_CELLGROUPTEMPLATE = 'cellGroupTemplate';
  TAG_CURVE = 'curve';
  TAG_CURVETEMPLATE = 'curveTemplate';
  TAG_DATE = 'date';
  TAG_LAYER = 'layer';
  TAG_NAME = 'name';
  TAG_ORIGINATOR = 'originator';
  TAG_PAGE = 'page';
  TAG_PAGETEMPLATE = 'pageTemplate';
  TAG_PLUGIN = 'plugin';
  TAG_VALUE = 'value';
  TAG_VALUEDISPLAY = 'valueDisplay';
  TAG_VALUELIST = 'valueList';
  TAG_REPRESENTATION = 'representation';
  TAG_SEGMENT = 'segment';
  TAG_SEGMENTLIST = 'segmentList';
  TAG_TITLEDISPLAY = 'titleDisplay';

  ATTR_CATEGORY = 'category';
  ATTR_CLASSID = 'classID';
  ATTR_ENDPOINT = 'endPoint';
  ATTR_INDEX = 'index';
  ATTR_FLAGS = 'flags';
  ATTR_FUNCTION = 'function';
  ATTR_HOST = 'host';
  ATTR_LEDSTYLE = 'ledStyle';
  ATTR_LENGTH = 'length';
  ATTR_LINKEDTO = 'linkedTo';
  ATTR_NAME = 'name';
  ATTR_ORDER = 'order';
  ATTR_PAGE = 'page';
  ATTR_PARAMID = 'parameterID';
  ATTR_STARTPOINT = 'startPoint';
  ATTR_STYLE = 'style';
  ATTR_SWITCHSTYLE = 'switchStyle';
  ATTR_TEMPLATE = 'template';
  ATTR_TURNSPERFULLRANGE = 'turnsPerFullRange';
  ATTR_TYPE = 'type';
  ATTR_UNITID = 'unitID';
  ATTR_VARIABLES = 'variables';
  ATTR_VENDOR = 'vendor';
  ATTR_VERSION = 'version';

  // Defines some predefined Representation Remote Names

  GENERIC_0 = 'Generic';
  GENERIC_4_CELLS = 'Generic 4 Cells';
  GENERIC_8_CELLS = 'Generic 8 Cells';
  GENERIC_12_CELLS = 'Generic 12 Cells';
  GENERIC_24_CELLS = 'Generic 24 Cells';
  GENERIC_N_CELLS = 'Generic %d Cells';
  QUICK_CONTROL_8_CELLS = 'Quick Controls 8 Cells';

type
  // Layer Types used in a VST XML Representation
  TLayerType = record
  public const
    kKnob = 0;        // a knob (encoder or not)
    kPressedKnob = 1; // a knob which is used by pressing and turning
    kSwitchKnob = 2;  // knob could be pressed to simulate a switch
    kSwitch = 3;      // a "on/off" button
    kLED = 4;         // LED like VU-meter or display around a knob
    kLink = 5;        // indicates that this layer is a folder linked to an another INode (page)
    kDisplay = 6;     // only for text display (not really a control)
    kFader = 7;       // a fader
    kEndOfLayerType = 8;
    // FIDString variant of the LayerType
    LayerTypeFIDString:array[0..7] of AnsiString=(
      'knob',
      'pressedKnob',
      'switchKnob',
      'switch',
      'LED',
      'link',
      'display',
      'fader'
    );
  end;

  // Curve Types used in a VST XML Representation
  TCurveType = record
  public const
    kSegment = 'segment';
    kValueList = 'valueList';
  end;

  // Attributes used to defined a Layer in a VST XML Representation
  TAttributes = record
  public const
    kStyle = ATTR_STYLE; // string attribute : See AttributesStyle for available string value
    kLEDStyle = ATTR_LEDSTYLE; // string attribute : See AttributesStyle for available string value
    kSwitchStyle = ATTR_SWITCHSTYLE; // string attribute : See AttributesStyle for available string value
    kKnobTurnsPerFullRange = ATTR_TURNSPERFULLRANGE; // float attribute
    kFunction = ATTR_FUNCTION; // string attribute : See AttributesFunction for available string value
    kFlags = ATTR_FLAGS; // string attribute : See AttributesFlags for available string value
  end;

  // Attributes Function used to defined the function of a Layer in a VST XML Representation
  TAttributesFunction = record
  // Global Style
  public const
    kPanPosCenterXFunc = 'PanPosCenterX'; // Gravity point X-axis (L-R) (for stereo: middle between left and right)
    kPanPosCenterYFunc = 'PanPosCenterY'; // Gravity point Y-axis (Front-Rear)
    kPanPosFrontLeftXFunc = 'PanPosFrontLeftX'; // Left channel Position in X-axis
    kPanPosFrontLeftYFunc = 'PanPosFrontLeftY'; // Left channel Position in Y-axis
    kPanPosFrontRightXFunc = 'PanPosFrontRightX'; // Right channel Position in X-axis
    kPanPosFrontRightYFunc = 'PanPosFrontRightY'; // Right channel Position in Y-axis
    kPanRotationFunc = 'PanRotation'; // Rotation around the Center (gravity point)
    kPanLawFunc = 'PanLaw'; // Panning Law
    kPanMirrorModeFunc = 'PanMirrorMode'; // Panning Mirror Mode
    kPanLfeGainFunc = 'PanLfeGain'; // Panning LFE Gain
    kGainReductionFunc = 'GainReduction'; // Gain Reduction for compressor
    kSoloFunc = 'Solo'; // Solo
    kMuteFunc = 'Mute'; // Mute
    kVolumeFunc = 'Volume'; // Volume
  end;

  // Attributes Style associated a specific Layer Type in a VST XML Representation
  TAttributesStyle = record
  public const
    // Global Style

    kInverseStyle = 'inverse'; // the associated layer should use the inverse value of parameter (1 - x).

    // LED Style

    kLEDWrapLeftStyle  = 'wrapLeft';  // |======>----- (the default one if not specified)
    kLEDWrapRightStyle = 'wrapRight'; // -------<====|
    kLEDSpreadStyle    = 'spread';    // ---<==|==>---
    kLEDBoostCutStyle  = 'boostCut';  // ------|===>--
    kLEDSingleDotStyle = 'singleDot'; // --------|----

    // Switch Style

    kSwitchPushStyle = 'push'; // Apply only when pressed, unpressed will reset the value to min.
    // Push will increment the value. When the max is reached it will restart with min.
    // The default one if not specified (with 2 states values it is a OnOff switch).
    kSwitchPushIncLoopedStyle = 'pushIncLooped';
    // Push will decrement the value. When the min is reached it will restart with max.
    kSwitchPushDecLoopedStyle = 'pushDecLooped';
    kSwitchPushIncStyle = 'pushInc'; // Increment after each press (delta depends of the curve).
    kSwitchPushDecStyle = 'pushDec'; // Decrement after each press (delta depends of the curve).
    // Each push-release will change the value between min and max.
    // A timeout between push and release could be used to simulate a push style (if timeout is reached).
    kSwitchLatchStyle = 'latch';
  end;

  // Attributes Flags defining a Layer in a VST XML Representation
  TAttributesFlags = record
  public const
    // the associated layer marked as hideable allows a remote to hide or
    // make it not usable a parameter when the associated value is inactive
    kHideableFlag = 'hideable';
  end;

  // Used for IParameterFunctionName
  TFunctionNameType = record
  public const
    kCompGainReduction = 'Comp:GainReduction';
    kCompGainReductionMax = 'Comp:GainReductionMax';
    kCompGainReductionPeakHold = 'Comp:GainReductionPeakHold';
    kCompResetGainReductionMax = 'Comp:ResetGainReductionMax';

    // Useful for live situation where low
    // latency is required:
    // 0 means LowLatency disable,
    // 1 means LowLatency enable
    kLowLatencyMode = 'LowLatencyMode';
    // Allowing to mix the original (Dry) Signal with the processed one (Wet):
    // 0.0 means Dry Signal only,
    // 0.5 means 50% Dry Signal + 50% Wet Signal,
    // 1.0 means Wet Signal only
    kDryWetMix = 'DryWetMix';
    // Allow to assign some randomized values to some
    // parameters in a controlled way
    kRandomize = 'Randomize';

    // Panner Type

    kPanPosCenterX = 'PanPosCenterX'; // Gravity point X-axis [0, 1]=>[L-R] (for stereo: middle between left and right)
    kPanPosCenterY = 'PanPosCenterY'; // Gravity point Y-axis [0, 1]=>[Front-Rear]
    kPanPosCenterZ = 'PanPosCenterZ'; // Gravity point Z-axis [0, 1]=>[Bottom-Top]
  end;

implementation

uses
  SysUtils{$ifdef DCC}, AnsiStrings{$endif};

{ TPFactoryInfo }

constructor TPFactoryInfo.Create(const _Vendor,_Url,_Email:AnsiString; _Flags:Int32);
begin
  {$ifdef DCC}AnsiStrings.{$endif}StrPLCopy(Vendor,_Vendor,kVendorSize);
  {$ifdef DCC}AnsiStrings.{$endif}StrPLCopy(Url,_Url,kURLSize);
  {$ifdef DCC}AnsiStrings.{$endif}StrPLCopy(Email,_Email,kEmailSize);
  Flags:=_Flags;
end;

{ TPClassInfo2 }

constructor TPClassInfo2.Create(const _CID:TGuid; _Cardinality:Int32; _ClassFlags:UInt32;
  const _Category,_SubCategories,_Name,_Vendor,_Version,_SdkVersion:AnsiString);
begin
  CID:=_CID;
  Cardinality:=_Cardinality;
  ClassFlags:=_ClassFlags;
  {$ifdef DCC}AnsiStrings.{$endif}StrPLCopy(Category,_Category,kCategorySize);
  {$ifdef DCC}AnsiStrings.{$endif}StrPLCopy(SubCategories,_SubCategories,kSubCategoriesSize);
  {$ifdef DCC}AnsiStrings.{$endif}StrPLCopy(Name,_Name,kNameSize);
  {$ifdef DCC}AnsiStrings.{$endif}StrPLCopy(Vendor,_Vendor,kVendorSize);
  {$ifdef DCC}AnsiStrings.{$endif}StrPLCopy(Version,_Version,kVersionSize);
  {$ifdef DCC}AnsiStrings.{$endif}StrPLCopy(SdkVersion,_SdkVersion,kVersionSize);
end;

{ PClassInfoW }

constructor PClassInfoW.FromInfo2(const ci2:TPClassInfo2);
begin
  CID:=ci2.CID;
  Cardinality:=ci2.Cardinality;
  ClassFlags:=ci2.ClassFlags;
  {$ifdef DCC}AnsiStrings.{$endif}StrLCopy(Category,ci2.Category,kCategorySize);
  {$ifdef DCC}AnsiStrings.{$endif}StrLCopy(SubCategories,ci2.SubCategories,kSubCategoriesSize);
  StrPLCopy(Name,UnicodeString(ci2.Name),kNameSize);
  StrPLCopy(Vendor,UnicodeString(ci2.Vendor),kVendorSize);
  StrPLCopy(Version,UnicodeString(ci2.Version),kVersionSize);
  StrPLCopy(SdkVersion,UnicodeString(ci2.SdkVersion),kVersionSize);
end;

{ TViewRect }

constructor TViewRect.Create(AWidth,AHeight:Int32);
begin
  Left:=0;
  Top:=0;
  Right:=AWidth;
  Bottom:=AHeight;
end;

function TViewRect.GetWidth:Int32;
begin
  Result:=Right-Left;
end;

function TViewRect.GetHeight:Int32;
begin
  Result:=Bottom-Top;
end;

end.
