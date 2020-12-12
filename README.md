# NimRDI
A lazy way to implement RDI in Nim By Moriarty@RedCore

# How to use
## Compile rdi.nim with following command:
  ```nim c -d:release --app:lib --nomain -o:"reflective_dll.x64.dll" rdi.nim```
## Test the compiled dll with following command:
  ```inject.x64.exe Moriarty [target pid]```
## PS: make sure your nim version is >= 1.4
# Credits
## [ReflectiveDLLInjection](https://github.com/stephenfewer/ReflectiveDLLInjection)
## [ImprovedReflectiveDLLInjection](https://github.com/dismantl/ImprovedReflectiveDLLInjection)
