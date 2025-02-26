require "pdf/master/version"
require "prawn"

module Pdf
  module Master
    class Signature
      def self.add_signature(pdf_path, signature_image_path, x, y)
        output_path = "signed_#{File.basename(pdf_path)}"

        Prawn::Document.generate(output_path, template: pdf_path) do |pdf|
          pdf.image signature_image_path, at: [x, y], width: 100
        end

        puts "✅ Signature added to #{output_path}"
      end
    end

    class Stamp
      def self.add_stamp(pdf_path, text, x, y)
        output_path = "stamped_#{File.basename(pdf_path)}"

        Prawn::Document.generate(output_path, template: pdf_path) do |pdf|
          pdf.draw_text text, at: [x, y], size: 20, style: :bold
        end

        puts "✅ Stamp added to #{output_path}"
      end
    end
  end
end
