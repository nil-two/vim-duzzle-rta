@echo off

if "%1%" == "" (
    set EXPERIMENT=_
) else (
    set EXPERIMENT=%1
)
vim -u NONE -i NONE -NnS share\vim\init.vim -W log\vim.log
