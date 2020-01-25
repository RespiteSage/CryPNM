require "bit_array"
require "string_scanner"

module PNM
  class PBMImage
    getter height : Int32
    getter width : Int32
    private getter bit_canvas : Array(BitArray)

    def initialize(@width, @height)
      @bit_canvas = Array(BitArray).new(height) { BitArray.new width }
    end

    def self.from_ascii(ascii)
      scanner = StringScanner.new ascii
      scanner.scan(/P1\s+/)
      width = scanner.scan(/\S+/).not_nil!.to_i
      scanner.skip(/\s+/)
      height = scanner.scan(/\S+/).not_nil!.to_i
      scanner.skip(/\s+/)

      image = PBMImage.new(width, height)

      height.times do |row|
        width.times do |column|
          field = scanner.scan(/\S+/)
          
          # bits default to zero, so only set if one
          if field.not_nil!.to_i == 1
            image[column, row] = 1
          end

          unless scanner.eos?
            scanner.skip(/\s+/)
          end
        end
      end
      image
    end

    def ascii_magic_number
      "P1"
    end

    def binary_magic_number
      "P4".bytes
    end

    def []=(column, row, value)
      bit_canvas[row][column] = !value.zero?
    end

    def [](column, row)
      bit_canvas[row][column]
    end

    def to_ascii
      String.build(capacity: 15 + 2 * width * height) do |builder|
        builder << "#{ascii_magic_number}\n"
        builder << "#{width} #{height}\n"

        builder << bit_canvas.join("\n") do |row|
          row.join(" ") do |bit|
            bit ? 1 : 0
          end
        end
      end
    end
  end
end