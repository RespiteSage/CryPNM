require "bit_array"

module PNM
  class PBMImage
    getter height : Int32
    getter width : Int32
    private getter bit_canvas : Array(BitArray)

    def initialize(@width, @height)
      @bit_canvas = Array(BitArray).new(height) { BitArray.new width }
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

    def ascii_serialize
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