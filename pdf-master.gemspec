
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pdf/master/version"

Gem::Specification.new do |spec|
  spec.name          = "pdf-master"
  spec.version       = Pdf::Master::VERSION
  spec.authors       = ["Gyandipsinh Chauhan"]
  spec.email         = ["gyandip3395@gmail.com"]

  spec.summary       = "A Ruby gem for embedding signatures and stamps into PDFs using Prawn and MiniMagick."
  spec.description   = "PdfMaster simplifies the process of adding electronic signatures and stamps to PDFs in Ruby on Rails applications. It leverages Prawn for PDF manipulation and MiniMagick for handling signature images. Ideal for applications requiring document signing, approvals, or annotations."
  spec.homepage      = "https://github.com/gyandip-chauhan/pdf-master"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/gyandip-chauhan/pdf-master"
    spec.metadata["changelog_uri"] = "https://github.com/gyandip-chauhan/pdf-master/blob/main/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = Dir["lib/**/*", "bin/*", "LICENSE.txt", "README.md"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  
  spec.add_dependency "prawn" # For PDF generation
  spec.add_dependency "prawn-templates" # For working with existing PDFs
  spec.add_dependency "mini_magick" # For handling signature images
end
