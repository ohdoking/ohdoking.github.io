#!/usr/bin/env ruby
# frozen_string_literal: true

POST_GLOB = "_posts/*.{md,markdown}"

def truncate_description(text, max_length = 170)
  return text if text.length <= max_length

  shortened = text[0...max_length]
  shortened = shortened.sub(/\s+\S*\z/, "")
  "#{shortened}..."
end

def extract_description(body)
  match = body.match(/^## What I Wanted to Clarify\s*\n+(.+?)(?:\n\s*\n|\n## )/m)
  paragraph =
    if match
      match[1]
    else
      body
        .lines
        .drop_while { |line| line.start_with?(">") || line.strip.empty? }
        .take_while { |line| !line.start_with?("## ") }
        .join
    end

  text = paragraph.gsub(/\s+/, " ").strip
  text = text.gsub(/[“”]/, '"').gsub(/[‘’]/, "'")
  truncate_description(text)
end

Dir.glob(POST_GLOB).sort.each do |path|
  content = File.read(path)
  next unless content.include?("origin: notion")

  match = content.match(/\A---\n(?<front_matter>.*?)\n---\n(?<body>.*)\z/m)
  next unless match

  front_matter = match[:front_matter]
  next if front_matter.match?(/^description:/)

  description = extract_description(match[:body])
  next if description.empty?

  updated_front_matter = "#{front_matter}\ndescription: #{description.inspect}"
  updated_content = +"---\n"
  updated_content << updated_front_matter
  updated_content << "\n---\n"
  updated_content << match[:body]

  File.write(path, updated_content)
end
