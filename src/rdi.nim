{.optimization:none.}
{.compile("ReflectiveLoader.c", "-DWIN_X64").}
#[coded by Moriarty@RedCore
    compile this with following nim command:
        nim c -d:release --app:lib --nomain -o:"reflective_dll.x64.dll" rdi.nim
    test the compiled dll with following command:
        inject.x64.exe Moriarty <target pid>
    PS: make sure your nim version is >= 1.4
]#
const DLL_PROCESS_ATTACH = 1
const DLL_QUERY_HMODULE = 6

var hAppInstance:int64;

proc MessageBox(hwnd:int64, lpText:cstring, lpCap:cstring, uType:uint64):uint64 {.fastcall, dynlib:"user32", importc:"MessageBoxA".}
proc sprintf_s(buffer:cstring, bufferCount:csize_t,format:cstring):cint {.header:"<stdio.h>", varargs.}
proc NimMain(){.cdecl, importc.}

proc MyFunction(lpUserdata:cstring, nUserdataLen:int64):bool {.fastcall, exportc, dynlib.} = 
    var str = cast[cstring](alloc0(32 + nUserdataLen));
    discard sprintf_s(str, (32 + nUserdataLen).csize_t, "Hello from %s!", lpUserdata)
    discard MessageBox(0, str, "Message", 0)
    dealloc(str)
    return true

proc DllMain(hinst: int64, reason: int64, lpreserved: int64): bool {.
        nimcall, exportc, dynlib.} =
    NimMain()
    case reason
    of DLL_PROCESS_ATTACH:
        discard MessageBox(0, "Hello, World!", "Message", 0)
    of DLL_QUERY_HMODULE:
        if lpreserved != 0:
            var hinst = cast[ptr int64](lpreserved)
            hinst[] = hAppInstance
    else:
        discard
    return true

