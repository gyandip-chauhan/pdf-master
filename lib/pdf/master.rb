module Pdf
  module Master
    class BasePdfModifier
      UPLOADS_DIR = "public/uploads".freeze

      def self.ensure_directory
        FileUtils.mkdir_p(UPLOADS_DIR)
      end

      def self.calculate_position(position, width, height)
        positions = {
          "top_right"    => [width - 110, height - 50],
          "top_left"     => [10, height - 50],
          "center"       => [(width / 2) - 50, height / 2],
          "bottom_right" => [width - 110, 50],
          "bottom_left"  => [10, 50]
        }
        positions[position] || [0, 0]
      end

      def self.generate_overlay_pdf(temp_pdf, &block)
        Prawn::Document.generate(temp_pdf, page_size: "A4", &block)
      end

      def self.merge_and_save(original_pdf, target_page, temp_pdf, output_path)
        overlay_pdf = CombinePDF.load(temp_pdf)
        target_page << overlay_pdf.pages.first
        original_pdf.save(output_path)
        File.delete(temp_pdf) if File.exist?(temp_pdf)
      end
    end

    class Signature < BasePdfModifier
      def self.add_signature(pdf_path, signature_image_path, x, y, page = 1, position = nil)
        return nil unless File.exist?(pdf_path) && File.exist?(signature_image_path)

        ensure_directory
        output_path = "#{UPLOADS_DIR}/signed_#{File.basename(pdf_path)}"
        temp_pdf = "#{UPLOADS_DIR}/temp_signature.pdf"

        original_pdf = CombinePDF.load(pdf_path)
        return nil unless page.between?(1, original_pdf.pages.count)

        target_page = original_pdf.pages[page - 1]
        x, y = calculate_position(position, target_page.mediabox[2], target_page.mediabox[3]) if position

        generate_overlay_pdf(temp_pdf) { |pdf| pdf.image signature_image_path, at: [x, y], width: 100 }
        merge_and_save(original_pdf, target_page, temp_pdf, output_path)

        output_path
      end
    end

    class Stamp < BasePdfModifier
      def self.add_stamp(pdf_path, text, x, y, page = 1, position = nil)
        return nil unless File.exist?(pdf_path) && text.is_a?(String)

        ensure_directory
        output_path = "#{UPLOADS_DIR}/stamped_#{File.basename(pdf_path)}"
        temp_pdf = "#{UPLOADS_DIR}/temp_stamp.pdf"

        original_pdf = CombinePDF.load(pdf_path)
        return nil unless page.between?(1, original_pdf.pages.count)

        target_page = original_pdf.pages[page - 1]
        x, y = calculate_position(position, target_page.mediabox[2], target_page.mediabox[3]) if position

        generate_overlay_pdf(temp_pdf) { |pdf| pdf.draw_text text, at: [x, y], size: 20, style: :bold }
        merge_and_save(original_pdf, target_page, temp_pdf, output_path)

        output_path
      end
    end
  end
end
