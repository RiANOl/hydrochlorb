lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'hydrochlorb'

Gem::Specification.new do |spec|
  spec.name          = 'hydrochlorb'
  spec.version       = Hydrochlorb.version
  spec.authors       = ['Rianol Jou']
  spec.email         = ['rianol.jou@gmail.com']
  spec.summary       = 'Provide a similar way to config HCL (HashiCorp Configuration Language) in ruby.'
  spec.description   = <<-EOF
    #{spec.summary} And featuring all programming features (variables, iterators, functions, regexp, etc) in ruby.
  EOF

  spec.files         = Dir['bin/*', '**/*.rb']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.bindir        = 'bin'
  spec.require_paths = ['lib']

  spec.homepage      = 'https://github.com/RiANOl/hydrochlorb'
  spec.license       = 'MIT'

  spec.add_development_dependency 'bundler', '>= 2.0.2'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '>= 3.8.0'
end
