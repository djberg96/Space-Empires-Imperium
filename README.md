# Space Empires: Imperium

A non-commercial two-player mashup of GDW's *Imperium* and GMT's *Space
Empires: 4X* with *Close Encounters*. It uses the Traveller setting and
point-to-point map of the former with the ship groups, hull-damage combat,
fighters, and ground units of the latter. Its fleet system restores
*Imperium*'s beam/missile and range contest on top of the newer counters and
d10 combat engine. A custom shared deck adds operational surprises.

The current rules are a version 0.1 playtest draft. They include a complete
opening scenario, campaign rules, a card manifest adapted to the new combat
engine, an illustrated Game Turn 1 example, and a player aid. See
`DESIGN_NOTES.md` for the design assumptions and the first-playtest checklist.

## Build the rulebook

Install a LaTeX distribution, then run:

```sh
latexmk -pdf -jobname=Space_Empires_Imperium main.tex
```

Or use `pdflatex` twice so the table of contents is populated:

```sh
pdflatex -jobname=Space_Empires_Imperium main.tex
pdflatex -jobname=Space_Empires_Imperium main.tex
```

The source is split by major rules section and assembled by `main.tex`.

## Required games

The design assumes access to the original *Imperium* map, *Space Empires: 4X*,
and the *Close Encounters* expansion. Source rule PDFs and reference images are
kept in `Documents/` and `Images/` for this personal design project.
