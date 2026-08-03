#!/usr/bin/env ruby
# frozen_string_literal: true

# Builds five 3x3 print sheets from the generated PNG card faces. Requires
# ImageMagick's `magick` executable.

require "fileutils"

COUNTS = {
  "A_Call_To_Arms" => 2,
  "Close_The_Range" => 2,
  "Commandos" => 2,
  "Confused_Fighting" => 1,
  "Direct_Hit" => 2,
  "Economic_Boom" => 2,
  "Electronic_Warfare" => 2,
  "Escape_Plan" => 1,
  "Flank_Speed" => 2,
  "Intel" => 2,
  "Logistics" => 2,
  "Mass_Drivers" => 2,
  "Minefield" => 2,
  "Overrun" => 1,
  "Queued_Up" => 2,
  "Reckless_Attack" => 2,
  "Resistance" => 2,
  "Sabotage" => 1,
  "Snafu" => 2,
  "Standoff" => 2,
  "Supply_Run" => 2,
  "Surprise" => 2,
  "Tactics" => 2
}.freeze

cards = COUNTS.flat_map do |name, count|
  Array.new(count, File.join(__dir__, "#{name}.png"))
end

abort "Expected 42 cards, found #{cards.length}" unless cards.length == 42

sheet_dir = File.join(__dir__, "Sheets")
FileUtils.mkdir_p(sheet_dir)

cards.each_slice(9).with_index(1) do |sheet_cards, sheet_number|
  command = ["magick", "-size", "790x1090", "canvas:white"]
  sheet_cards.each_with_index do |card, slot|
    x = 10 + ((slot % 3) * 260)
    y = 10 + ((slot / 3) * 360)
    command.concat([card, "-geometry", "+#{x}+#{y}", "-composite"])
  end
  output = File.join(sheet_dir, "imperium_cards_sheet_#{sheet_number}.png")
  command << output
  abort "Failed to generate #{output}" unless system(*command)
end

warn "Generated 5 print sheets for #{cards.length} cards."
