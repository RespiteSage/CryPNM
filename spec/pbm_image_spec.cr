require "./spec_helper"

describe PBMImage do
  describe ".new" do
    it "sets image dimensions" do
      image = PBMImage.new(10,25)

      image.width.should eq 10
      image.height.should eq 25
    end
  end

  describe ".ASCII_MAGIC_NUMBER" do
    it "equals P1" do
      PBMImage::ASCII_MAGIC_NUMBER.should eq "P1"
    end
  end

  describe ".BINARY_MAGIC_NUMBER" do
    it "returns ASCII binary for P4" do
      PBMImage::BINARY_MAGIC_NUMBER.should eq "P4".bytes
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

  describe "#to_ascii" do
    it "correctly serializes a simple image" do
      image = PBMImage.new(2,2)

      image[0,0] = 1
      image[0,1] = 0
      image[1,0] = 0
      image[1,1] = 1

      expected_ascii = <<-EXPECTED
                          P1
                          2 2
                          1 0
                          0 1
                          EXPECTED
      
      image.to_ascii.should eq expected_ascii
    end
  end

  describe ".from_ascii" do
    it "correctly serializes a simple image" do
      ascii = <<-ASCII
                 P1
                 2 2
                 1 0
                 0 1
                 ASCII
      
      image = PBMImage.from_ascii ascii

      image[0,0].should eq ONE_BIT
      image[0,1].should eq ZERO_BIT
      image[1,0].should eq ZERO_BIT
      image[1,1].should eq ONE_BIT
    end
  end
end
