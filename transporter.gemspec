Gem::Specification.new do |s|
  s.name    = "transporter"
  s.version = "0.1"
  s.date    = "2009-08-10"

  s.description = "Deliver packages in multiple ways simultaneously (email, jabber, campfire, irc, etc.)"
  s.summary     = "Easily send messages using multiple communication channels"
  s.homepage    = "http://github.com/foca/Transporter"

  s.authors = ["Nicolás Sanguinetti"]
  s.email   = "contacto@nicolassanguinetti.info"

  s.require_paths     = ["lib"]
  s.rubyforge_project = "transporter"
  s.has_rdoc          = true
  s.rubygems_version  = "1.3.1"

  s.add_dependency "ninja"

  if s.respond_to?(:add_development_dependency)
    s.add_development_dependency "sr-mg"
    s.add_development_dependency "contest"
    s.add_development_dependency "redgreen"
  end

  s.files = %w[
.gitignore
LICENSE
README.rdoc
Rakefile
transporter.gemspec
lib/transporter.rb
lib/transporter/package.rb
lib/transporter/service.rb
lib/transporter/service/validations.rb
test/test_helper.rb
test/test_transporter.rb
]
end
