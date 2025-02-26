require "pdf/master/version"
require "prawn"
require "combine_pdf"
require "fileutils"

module Pdf
  module Master
    class Signature
      def self.add_signature(pdf_path, signature_image_path, x, y)
        FileUtils.mkdir_p("public/uploads")  # Ensure the directory exists

        output_path = "public/uploads/signed_#{File.basename(pdf_path)}"
        temp_pdf = "public/uploads/temp_signature.pdf"

        # Create overlay PDF with the signature
        Prawn::Document.generate(temp_pdf, page_size: "A4") do |pdf|
          pdf.image signature_image_path, at: [x, y], width: 100
        end

        # Merge the signature with the original PDF
        original_pdf = CombinePDF.load(pdf_path)
        overlay_pdf = CombinePDF.load(temp_pdf)
        original_pdf.pages.first << overlay_pdf.pages.first  # Only add to first page

        original_pdf.save(output_path)
        File.delete(temp_pdf) if File.exist?(temp_pdf)

        output_path
      end
    end

    class Stamp
      def self.add_stamp(pdf_path, text, x, y)
        FileUtils.mkdir_p("public/uploads")  # Ensure the directory exists

        output_path = "public/uploads/stamped_#{File.basename(pdf_path)}"
        temp_pdf = "public/uploads/temp_stamp.pdf"

        # Create overlay PDF with the stamp text
        Prawn::Document.generate(temp_pdf, page_size: "A4") do |pdf|
          pdf.draw_text text, at: [x, y], size: 20, style: :bold
        end

        # Merge the stamp with the original PDF
        original_pdf = CombinePDF.load(pdf_path)
        overlay_pdf = CombinePDF.load(temp_pdf)
        original_pdf.pages.first << overlay_pdf.pages.first  # Only add to first page

        original_pdf.save(output_path)
        File.delete(temp_pdf) if File.exist?(temp_pdf)

        output_path
      end
    end
  end
end
