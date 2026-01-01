# tinyexr

This is [tinyexr](https://github.com/syoyo/tinyexr), packaged for [Zig](https://ziglang.org/).

## Installation

First, update your `build.zig.zon`:

```bash
# Initialize a `zig build` project if you haven't already
zig init
zig fetch --save git+https://github.com/RichieSams/zig-tinyexr.git#v1.0.12
```

You can then import `tinyexr` in your `build.zig` with:

```zig
const tinyexr_dependency = b.dependency("tinyexr", .{
    .target = target,
    .optimize = optimize,
    .linkage = linkage,
});
your_exe.linkLibrary(tinyexr_dependency.artifact("tinyexr"));
```
