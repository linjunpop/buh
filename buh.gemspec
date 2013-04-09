# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','buh','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'buh'
  s.version = Buh::VERSION
  s.author = 'Jun Lin'
  s.email = 'linjunpop@gmail.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
# Add your other files here if you make them
  s.files = %w(
bin/buh
lib/buh/version.rb
lib/buh.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','buh.rdoc']
  s.rdoc_options << '--title' << 'buh' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'buh'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.5.6')
  s.add_runtime_dependency('rugged', '~> 0.17.0.b7')
end
