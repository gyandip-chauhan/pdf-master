require "spec_helper"

RSpec.describe Pdf::Master do
  let(:pdf_path) { "spec/test_files/invoice_1.pdf" }
  let(:signature_path) { "spec/test_files/signature.png" }
  let(:output_signature) { "spec/test_files/signed_invoice_1.pdf" }
  let(:output_stamp) { "spec/test_files/stamped_invoice_1.pdf" }

  before do
    FileUtils.cp(pdf_path, output_signature) if File.exist?(pdf_path)
    FileUtils.cp(pdf_path, output_stamp) if File.exist?(pdf_path)
  end

  it "adds a signature to the PDF" do
    expect { Pdf::Master::Signature.add_signature(output_signature, signature_path, 100, 100) }.not_to raise_error
    expect(File.exist?(output_signature)).to be true
  end

  it "adds a stamp to the PDF" do
    expect { Pdf::Master::Stamp.add_stamp(output_stamp, "CONFIDENTIAL", 150, 200) }.not_to raise_error
    expect(File.exist?(output_stamp)).to be true
  end
end
