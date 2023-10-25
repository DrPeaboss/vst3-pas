# vst3-pas

The Object Pascal(FPC and Delphi) bindings of VST 3 API.

Original API is at <https://github.com/steinbergmedia/vst3_pluginterfaces>

VST is a trademark of Steinberg Media Technologies GmbH, registered in Europe and other countries.

## Usage

- Support Free Pascal 3.2.2 and trunk(3.3.1).

- Support Delphi 11, and should support at least 10.x series versions(untested).

### FPC&Lazarus

Use Lazarus to open the `vst3pas.lpk` in `package`, and click `Add to project`.

Add compiler directive `{$Interfaces CORBA}` in all files.

Please use at least Lazarus 3.0RC2, or the trunk(3.99), older versions have some bugs, see issue [#40368](https://gitlab.com/freepascal.org/lazarus/lazarus/-/issues/40368) and [#40369](https://gitlab.com/freepascal.org/lazarus/lazarus/-/issues/40369).

### Delphi

Add `source` to compiler search path, or copy file `vst3intf.pas` to your project directory.

Use `[unsafe]` in some places and must use `unsafe` when returning an interface.

Delphi IDE have some bugs like older Lazarus, I hope it would be fixed.

## Examples

See `examples` directory, now only support Windows.

In theory, FPC and Lazarus versions can easily support Linux and macOS, if you can help to support them and test, please make a PR.

## License

The original VST 3 SDK has a dual license, as a port of VST 3 API, it is licensed under GPLv3.
