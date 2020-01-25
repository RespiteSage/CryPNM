require "./spec_helper"

describe PBMImage do
  describe ".new" do
    it "sets image dimensions" do
      image = PBMImage.new(10,25)

      image.width.should eq 10
      image.height.should eq 25
    end
  end

  describe "#ascii_magic_number" do
    it "returns P1" do
      image = PBMImage.new(1,1)

      image.ascii_magic_number.should eq "P1"
    end
  end

  describe "#binary_magic_number" do
    it "returns ASCII binary for P4" do
      image = PBMImage.new(1,1)

      image.binary_magic_number.should eq "P4".bytes
    end
  end

  describe "#[x, y]" do
    it "can be used to set and access individual pixels" do
      image = PBMImage.new(3,2)

      image[0,0] = 1
      image[0,1] = 0
      image[1,0] = 0
      image[1,1] = 1
      image[2,0] = 0
      image[2,1] = 0

      image[0,0].should eq ONE_BIT
      image[0,1].should eq ZERO_BIT
      image[1,0].should eq ZERO_BIT
      image[1,1].should eq ONE_BIT
      image[2,0].should eq ZERO_BIT
      image[2,1].should eq ZERO_BIT
    end
  end
end
