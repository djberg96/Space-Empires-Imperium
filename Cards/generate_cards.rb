#!/usr/bin/env ruby
# frozen_string_literal: true

# Generates the SVG card faces used by the v0.1 playtest deck. The full rules
# manifest in ../cards.tex remains authoritative; card faces are concise aids.

Card = Data.define(:file, :title, :phase, :count, :lines)

CARDS = [
  Card.new("A_Call_To_Arms", "A CALL TO ARMS", "SPACE COMBAT", 2, [
    "At the start of round 2,", "ships from one adjacent", "system may join this battle.",
    "You must have one original", "combat ship surviving.", "Bases cannot move."
  ]),
  Card.new("Close_The_Range", "CLOSE THE RANGE", "SPACE COMBAT", 2, [
    "The first firing round is", "at Close Range. Resolve beams", "before short-range missiles,",
    "using their normal penalties."
  ]),
  Card.new("Commandos", "COMMANDOS", "PLANETARY", 2, [
    "Land up to 3 Infantry from", "one friendly surface in an", "adjacent system.",
    "No Transport is required.", "They fire in ground round 1."
  ]),
  Card.new("Confused_Fighting", "CONFUSED FIGHTING", "SPACE COMBAT", 1, [
    "Skip Range Control. Each ship", "treats range as optimal for its", "weapon; Mixed remains -1.",
    "Beams fire before missiles.", "Affects both sides. Reshuffle", "after this Combat Phase."
  ]),
  Card.new("Direct_Hit", "DIRECT HIT", "SPACE COMBAT", 2, [
    "After rolling, change one", "of your attack dice to", "a natural 1.", "Draw one card."
  ]),
  Card.new("Economic_Boom", "ECONOMIC BOOM", "LOGISTICS", 2, [
    "Each connected friendly", "Outpost produces +1 RU", "this turn.",
    "Imperium: instead cancel", "a Depression result."
  ]),
  Card.new("Electronic_Warfare", "ELECTRONIC WARFARE", "SPACE COMBAT", 2, [
    "After groups are revealed,", "choose up to 3 enemy groups.",
    "They fire one class later", "in the first firing round."
  ]),
  Card.new("Escape_Plan", "ESCAPE PLAN", "COMBAT", 1, [
    "Before a firing round, retreat", "all your ships to the same legal", "system without enemy fire.",
    "From a friendly World, adjust", "Glory 1 in the opponent's favor."
  ]),
  Card.new("Flank_Speed", "FLANK SPEED", "REACTION", 2, [
    "One reacting stack may make", "+3 jumps, to a maximum of 6.",
    "Refuelling and interception", "still apply."
  ]),
  Card.new("Intel", "INTEL", "ANY TIME", 2, [
    "Look at your opponent's hand.", "Choose one card and discard it.",
    "May not be played in combat."
  ]),
  Card.new("Logistics", "LOGISTICS", "LOGISTICS", 2, [
    "Before maintenance, gain 5 RU.", "Treat one friendly stack as",
    "supplied for maintenance and", "movement this Game Turn."
  ]),
  Card.new("Mass_Drivers", "MASS DRIVERS", "BOMBARDMENT", 2, [
    "Before normal bombardment,", "make one bonus Attack 7", "against the surface.",
    "Apply surface Defense.", "A hit removes 1 Militia."
  ]),
  Card.new("Minefield", "MINEFIELD", "SPACE COMBAT", 2, [
    "At a friendly World or Outpost,", "randomly choose 2 enemy ships.",
    "After reactions, make a Missile", "Attack 5 against each ship.", "Point Defense applies. Each hit", "causes 1 damage."
  ]),
  Card.new("Overrun", "OVERRUN", "AFTER COMBAT", 1, [
    "After eliminating or driving off", "every enemy ship, one victorious", "stack may make one jump.",
    "Resolve a new battle at once.", "Fleet Trains cannot join."
  ]),
  Card.new("Queued_Up", "QUEUED UP", "REACTION", 2, [
    "Move up to 3 reacting stacks", "instead of 1. Each uses its", "normal Reaction Allowance."
  ]),
  Card.new("Reckless_Attack", "RECKLESS ATTACK", "COMBAT", 2, [
    "Each firing ship may gain", "+2 Attack for its shot.", "Enemy attacks against that ship",
    "gain +1 Attack until the", "end of the firing round."
  ]),
  Card.new("Resistance", "RESISTANCE", "GROUND COMBAT", 2, [
    "For ground rounds 1 and 2,", "permanent defenders gain", "+1 Attack and +1 Defense.",
    "Militia gain +1 Attack only."
  ]),
  Card.new("Sabotage", "SABOTAGE", "AFTER PRODUCTION", 1, [
    "Choose an eligible enemy ship", "group at a frontier Outpost.",
    "On a d10 roll of 1-7, its owner", "allocates 1 hit to that group.", "Then reshuffle the deck."
  ]),
  Card.new("Snafu", "SNAFU", "ENEMY TURN", 2, [
    "Choose a system containing", "an enemy Outpost. Stacks that", "begin normal movement there",
    "may make no more than", "2 jumps in that phase."
  ]),
  Card.new("Standoff", "STANDOFF", "SPACE COMBAT", 2, [
    "If both sides survive round 1,", "combat ends. Attacker retreats", "all ships, then defender.",
    "No retreat fire occurs."
  ]),
  Card.new("Supply_Run", "SUPPLY RUN", "MOVEMENT", 2, [
    "One stack ignores its supply", "movement penalty and need not", "refuel for its first 3 jumps.",
    "Enemy ships still stop it."
  ]),
  Card.new("Surprise", "SURPRISE", "SPACE COMBAT", 2, [
    "Choose Long or Close Range", "for each of rounds 1 and 2.", "Skip Range Control before round 2.",
    "Range-card conflict: defender", "chooses round 1; attacker round 2."
  ]),
  Card.new("Tactics", "TACTICS", "SPACE COMBAT", 2, [
    "Tactics +1 for Range Control", "and firing ties this battle.", "Once per firing round, reroll one", "of your attack dice.",
    "The new result is final."
  ])
].freeze

def escape_xml(text)
  text.gsub("&", "&amp;").gsub("<", "&lt;").gsub(">", "&gt;").gsub("'", "&apos;")
end

def title_size(title)
  return 17 if title.length >= 18
  return 19 if title.length >= 15
  return 21 if title.length >= 13

  28
end

def phase_size(phase)
  phase.length >= 15 ? 10 : 13
end

CARDS.each do |card|
  first_y = 215 - ((card.lines.length - 1) * 12)
  body = card.lines.each_with_index.map do |line, index|
    %(<tspan x="125" y="#{first_y + (index * 24)}">#{escape_xml(line)}</tspan>)
  end.join("\n        ")

  svg = <<~SVG
    <svg width="250" height="350" viewBox="0 0 250 350" xmlns="http://www.w3.org/2000/svg">
      <title>#{escape_xml(card.title)}</title>
      <rect width="250" height="350" fill="black" stroke="white" stroke-width="15"/>
      <text x="125" y="53" fill="white" font-size="#{title_size(card.title)}"
            font-family="stop, sans-serif" text-anchor="middle">#{escape_xml(card.title)}</text>
      <rect x="55" y="70" rx="8" ry="5" width="140" height="24" fill="#a40000"/>
      <text x="125" y="87" fill="white" font-size="#{phase_size(card.phase)}" font-family="sans-serif"
            text-anchor="middle">#{escape_xml(card.phase)}</text>
      <text x="222" y="111" fill="white" font-size="12" font-family="sans-serif"
            text-anchor="end">x#{card.count}</text>
      <rect x="20" y="120" width="210" height="210" fill="#dedede" stroke="white" stroke-width="3"/>
      <text fill="black" font-size="14" font-family="serif" text-anchor="middle">
        #{body}
      </text>
    </svg>
  SVG

  File.write(File.join(__dir__, "#{card.file}.svg"), svg)
  png = File.join(__dir__, "#{card.file}.png")
  svg_path = File.join(__dir__, "#{card.file}.svg")
  abort "Failed to render #{png}" unless system("rsvg-convert", "-w", "250", "-h", "350", svg_path, "-o", png)
end

warn "Generated #{CARDS.length} SVG and PNG card faces (#{CARDS.sum(&:count)} cards)."
