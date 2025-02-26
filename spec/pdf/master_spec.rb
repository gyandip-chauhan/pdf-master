require "spec_helper"
require "fileutils"
require "prawn"

RSpec.describe Pdf::Master do
  let(:pdf_path) { "spec/test_files/sample.pdf" }
  let(:signature_path) { "spec/test_files/signature.png" }
  let(:output_dir) { "spec/test_files/output" }

  before(:each) do
    FileUtils.mkdir_p(output_dir)
    FileUtils.mkdir_p("public/uploads")

    # Generate a sample PDF for testing before each test
    Prawn::Document.generate(pdf_path) do |pdf|
      pdf.text "This is a test PDF"
    end
  end

  after(:each) do
    FileUtils.rm_rf(Dir["#{output_dir}/*"])
    FileUtils.rm_rf(Dir["public/uploads/*"])
  end

  describe Pdf::Master::Signature do
    it "adds a signature to the PDF" do
      result_path = Pdf::Master::Signature.add_signature(pdf_path, signature_path, 50, 100)

      expect(File.exist?(result_path)).to be true
      expect(File.size(result_path)).to be > File.size(pdf_path)
    end
  end

  describe Pdf::Master::Stamp do
    it "adds a stamp to the PDF" do
      result_path = Pdf::Master::Stamp.add_stamp(pdf_path, "APPROVED", 150, 200)

      expect(File.exist?(result_path)).to be true
      expect(File.size(result_path)).to be > File.size(pdf_path)
    end
  end
end
