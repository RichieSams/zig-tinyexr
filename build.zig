const std = @import("std");

pub fn build(b: *std.Build) void {
    const upstream = b.dependency("tinyexr", .{});
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const linkage = b.option(std.builtin.LinkMode, "linkage", "Link mode") orelse .static;

    const miniz = b.addLibrary(.{
        .name = "miniz",
        .linkage = .static,
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
    });
    miniz.root_module.addIncludePath(upstream.path("deps/miniz"));
    miniz.root_module.addCSourceFiles(.{
        .root = upstream.path("deps/miniz"),
        .files = &.{
            "miniz.c",
        },
        .flags = &.{"-std=c11"},
    });
    miniz.installHeader(upstream.path("deps/miniz/miniz.h"), "miniz.h");

    const tinyexr = b.addLibrary(.{
        .name = "tinyexr",
        .linkage = linkage,
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libcpp = true,
        }),
    });
    tinyexr.root_module.addIncludePath(upstream.path("."));
    tinyexr.root_module.addCSourceFiles(.{
        .root = upstream.path("."),
        .files = &.{"tinyexr.cc"},
        .flags = &.{"-std=c++11"},
    });
    tinyexr.linkLibrary(miniz);
    tinyexr.installHeader(upstream.path("tinyexr.h"), "tinyexr.h");

    b.installArtifact(tinyexr);
}
