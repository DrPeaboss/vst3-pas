# vst3-pas

The Object Pascal(FPC and Delphi) bindings of VST 3 API. Current version is 3.8.0 (2025/10/20).

Original API is at <https://github.com/steinbergmedia/vst3_pluginterfaces>

VST is a trademark of Steinberg Media Technologies GmbH, registered in Europe and other countries.

## Usage

- Support Free Pascal 3.2.2 and above.

- Should support Delphi 10.x and above(untested).

### FPC&Lazarus

Use Lazarus to open the `vst3pas.lpk` in `package`, and click `Add to project`.

Add compiler directive `{$Interfaces CORBA}` in files which need the interfaces in VST3.

Please use Lazarus 3.0 and up, older versions have bugs with modifier `winapi`.

### Delphi

Add `source` to compiler search path, or copy file `vst3intf.pas` to your project directory.

Use `[unsafe]` in some places and must use `unsafe` when returning an interface.

Delphi IDE have some bugs like older Lazarus, I hope it would be fixed.

## Examples

See `examples` directory, now only support Windows.

In theory, FPC and Lazarus versions can easily support Linux and macOS with some adapt.

## License

MIT License
