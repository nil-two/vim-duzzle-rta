vim-duzzle-rta
==============

Files to do vim-duzzle RTA.

Usage
-----

First, edit `conf/config.json` as necessary.
`livesplit_enable` is the flag whether control LiveSplit from Vim (Default: false).
`livesplit_address` is the adress of LiveSplit's receiver port (Default: localhost:16834).

Next, load `share/livesplit/vim-duzzle-layout.lsl` and `share/livesplit/vim-duzzle-split.lss` from LiveSplit as necessary.

Then, Execute `startvim` (If you are using Windows, Execute `startvim.bat` instead).
It starts Vim, download vim-duzzle, execute DuzzleStart.
And, if `livesplit_enable` is true, LiveSplit's starts timer when you enter Room1.

Files
-----

```
.
|-- startvim (Script to start Vim and vim-duzzle)
|-- startvim.bat (Same as startvim. For Windows)
|-- log (Directory to output logs)
|-- conf
|   `-- config.json (Configuration for startvim)
`-- share
    |-- livesplit
    |   |-- vim-duzzle-split.lss (Split file for LiveSplit)
    |   `-- vim-duzzle-layout.lsl (Layout file for LiveSplit)
    `-- vim
        `-- init.vim (Initialization script for startvim)
```

License
-------

MIT License

Author
------

nil2 <nil2@nil2.org>
