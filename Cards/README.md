# Description

These are custom cards for *Space Empires: Imperium*. The SVG and PNG faces
match the v0.1 playtest manifest in `../cards.tex`.

Run `ruby generate_cards.rb` from any directory to rebuild all SVG and PNG
faces. This requires `rsvg-convert`. The quantity printed on each face is the
number of copies placed in the 42-card deck.

After rendering the PNG faces, run `ruby generate_sheets.rb` to rebuild the
five 790x1090 print sheets. This step requires ImageMagick.

# Fonts

To see the intended graphics of each card you should install the "Stop" font. If that font is not installed on your system then the title of each card will use your system's default font.

# BGG

For more about Imperium, please see https://boardgamegeek.com/boardgame/3661/imperium-empires-conflict-worlds-balance
