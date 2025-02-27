require "spec_helper"
require "fileutils"
require "combine_pdf"
require "prawn"

RSpec.describe Pdf::Master::Signature, type: :service do
  let(:pdf_path) { "spec/fixtures/sample.pdf" }
  let(:signature_image_path) { "spec/fixtures/signature.png" }
  let(:output_dir) { "public/uploads" }

  before do
    FileUtils.mkdir_p(output_dir)
    Prawn::Document.generate(pdf_path) { |pdf| pdf.text "Test PDF" }

    unless File.exist?(signature_image_path)
      FileUtils.cp("spec/support/signature.png", signature_image_path)
    end
  end

  after { cleanup_files }

  describe ".add_signature" do
    it "adds a signature to the specified PDF page" do
      output_path = described_class.add_signature(pdf_path, signature_image_path, 100, 100, 1)

      expect_output_pdf(output_path)
    end

    it "handles predefined positions correctly" do
      output_path = described_class.add_signature(pdf_path, signature_image_path, nil, nil, 1, "top_right")

      expect_output_pdf(output_path)
    end

    it "returns nil for an invalid page number" do
      expect(described_class.add_signature(pdf_path, signature_image_path, 100, 100, 5)).to be_nil
    end
  end
end

RSpec.describe Pdf::Master::Stamp, type: :service do
  let(:pdf_path) { "spec/fixtures/sample.pdf" }
  let(:output_dir) { "public/uploads" }
  let(:stamp_text) { "CONFIDENTIAL" }

  before do
    FileUtils.mkdir_p(output_dir)
    Prawn::Document.generate(pdf_path) { |pdf| pdf.text "Test PDF" }
  end

  after { cleanup_files }

  describe ".add_stamp" do
    it "adds a stamp text to the specified PDF page" do
      output_path = described_class.add_stamp(pdf_path, stamp_text, 100, 100, 1)

      expect_output_pdf(output_path)
    end

    it "handles predefined positions correctly" do
      output_path = described_class.add_stamp(pdf_path, stamp_text, nil, nil, 1, "center")

      expect_output_pdf(output_path)
    end

    it "returns nil for an invalid page number" do
      expect(described_class.add_stamp(pdf_path, stamp_text, 100, 100, 5)).to be_nil
    end
  end
end

def cleanup_files
  FileUtils.rm_f(Dir.glob("public/uploads/*"))
  FileUtils.rm_f("spec/fixtures/sample.pdf")
end

def expect_output_pdf(output_path)
  expect(output_path).to be_a(String)
  expect(File).to exist(output_path)

  pdf = CombinePDF.load(output_path)
  expect(pdf.pages.count).to eq(1)
end
