# seventy-one

A dual-drive, double-sided 1571 disk copier for the Commodore 64, written in
[durexForth](https://github.com/jkotlinski/durexforth).

## Background

The 1571 drive is well-supported on the C128, but double-sided copying on a
stock C64 has historically been an underserved use case. Existing C64 disk
utilities tend to support dual-drive 1541 or 1581 configurations, or treat the
1571 as a single-sided 1541. The **seventy-one** tool fills that gap.

## Target Hardware

The primary development target is the [Commodore 64 Ultimate (C64U)](https://c64u.org/dokuwiki/)
with the following drive configuration:

| Device | Role                        | Format |
|--------|-----------------------------|--------|
| 8      | Boot drive (tool disk)      | d64    |
| 9      | Source drive (virtual 1571) | d71    |
| 11     | Destination (physical 1571) | floppy |

The drive numbers are configurable. This is just the author's preferred setup.

The physical 1571 is initialized in double-sided mode by sending `U0>M1` to its
command channel at startup. Burst mode is not used, so the copier runs at the
standard IEC bus speed. It will be slower than a native C128 copy, but fully
functional.

## Usage

```forth
include seventy-one
9 11 copy-71
```

This copies all 70 tracks (35 per side) from device 9 to device 11, printing
basic track/sector progress as it goes.  Note:
- No graphical interface for now
- No copy-protection cracks
— standard double-sided disks only

## Project Structure

```
seventy-one/
├── README.md
├── LICENSE
├── docs/
│   ├── design.md
│   └── 1571-dos-reference.md
├── src/
│   ├── iec-utils.fs    \ low-level IEC/drive helpers
│   ├── drive71.fs      \ 1571 geometry & drive commands
│   ├── ui.fs           \ track/sector progress display
│   └── copy71.fs       \ top-level copy-71 word
├── dist/
│   └── seventy-one.d64
└── tools/
    └── build.sh        \ assembles d64 from sources
```

## Status

Early development. Core goals for the initial release:

- [x] Project setup
- [ ] Drive initialization (`init-drives`)
- [ ] Sector geometry table (`track>spt`)
- [ ] Block read/write via CBM DOS buffer commands
- [ ] Track/sector progress display
- [ ] End-to-end `copy-71` word

## License

MIT: see [LICENSE](LICENSE).
