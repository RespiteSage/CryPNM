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
  end
end