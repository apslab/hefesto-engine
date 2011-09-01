# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{hefesto}
  s.version = "0.2.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["AP System"]
  s.date = %q{2011-09-01}
  s.description = %q{Adminsitracion de Compras}
  s.email = %q{info@ap-sys.com.ar}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "app/controllers/empresas_controller.rb",
    "app/controllers/hefesto/facturanotacreditos_controller.rb",
    "app/controllers/hefesto/facturarecibos_controller.rb",
    "app/controllers/hefesto/facturas_controller.rb",
    "app/controllers/hefesto/notacreditos_controller.rb",
    "app/controllers/hefesto/recibos_controller.rb",
    "app/controllers/suppliers_controller.rb",
    "app/helpers/empresas_helper.rb",
    "app/helpers/hefesto/facturadetalles_helper.rb",
    "app/helpers/hefesto/facturanotacreditos_helper.rb",
    "app/helpers/hefesto/facturarecibos_helper.rb",
    "app/helpers/hefesto/facturas_helper.rb",
    "app/helpers/hefesto/notacreditos_helper.rb",
    "app/helpers/hefesto/recibos_helper.rb",
    "app/helpers/suppliers_helper.rb",
    "app/models/hefesto/comprobante.rb",
    "app/models/hefesto/detalle.rb",
    "app/models/hefesto/factura.rb",
    "app/models/hefesto/facturanotacredito.rb",
    "app/models/hefesto/facturarecibo.rb",
    "app/models/hefesto/notacredito.rb",
    "app/models/hefesto/recibo.rb",
    "app/models/supplier.rb",
    "app/stylesheets/application.sass",
    "app/stylesheets/apslabs-ie.sass",
    "app/stylesheets/apslabs.sass",
    "app/stylesheets/jquery.tipsy.sass",
    "app/stylesheets/partials/_base.sass",
    "app/stylesheets/partials/_jquery-ui.sass",
    "app/stylesheets/partials/_mixins-ie.sass",
    "app/stylesheets/partials/_mixins.sass",
    "app/stylesheets/partials/_style-ie.sass",
    "app/stylesheets/partials/_style.sass",
    "app/stylesheets/partials/attrtastic/_attrtastic_changes.sass",
    "app/stylesheets/partials/formtastic/_formtastic.sass",
    "app/stylesheets/partials/formtastic/_formtastic_changes.sass",
    "app/stylesheets/uniform.aristo.sass",
    "app/views/hefesto/facturadetalles/edit.html.erb",
    "app/views/hefesto/facturadetalles/new.html.erb",
    "app/views/hefesto/facturanotacreditos/_form.html.erb",
    "app/views/hefesto/facturanotacreditos/edit.html.erb",
    "app/views/hefesto/facturanotacreditos/index.html.erb",
    "app/views/hefesto/facturanotacreditos/new.html.erb",
    "app/views/hefesto/facturanotacreditos/show.html.erb",
    "app/views/hefesto/facturarecibos/_form.html.erb",
    "app/views/hefesto/facturarecibos/edit.html.erb",
    "app/views/hefesto/facturarecibos/index.html.erb",
    "app/views/hefesto/facturarecibos/new.html.erb",
    "app/views/hefesto/facturarecibos/show.html.erb",
    "app/views/hefesto/facturas/_detalle_fields.html.erb",
    "app/views/hefesto/facturas/_filtros.html.erb",
    "app/views/hefesto/facturas/_form.html.erb",
    "app/views/hefesto/facturas/edit.html.erb",
    "app/views/hefesto/facturas/index.html.erb",
    "app/views/hefesto/facturas/new.html.erb",
    "app/views/hefesto/facturas/show.html.erb",
    "app/views/hefesto/notacreditos/_detalle_fields.html.erb",
    "app/views/hefesto/notacreditos/_form.html.erb",
    "app/views/hefesto/notacreditos/edit.html.erb",
    "app/views/hefesto/notacreditos/index.html.erb",
    "app/views/hefesto/notacreditos/new.html.erb",
    "app/views/hefesto/notacreditos/show.html.erb",
    "app/views/hefesto/recibos/_detalle_fields.html.erb",
    "app/views/hefesto/recibos/_filtros.html.erb",
    "app/views/hefesto/recibos/_form.html.erb",
    "app/views/hefesto/recibos/edit.html.erb",
    "app/views/hefesto/recibos/index.html.erb",
    "app/views/hefesto/recibos/new.html.erb",
    "app/views/hefesto/recibos/show.html.erb",
    "app/views/suppliers/_filtros.html.erb",
    "app/views/suppliers/_form.html.erb",
    "app/views/suppliers/_sidebar.html.erb",
    "app/views/suppliers/cuentacorriente.html.erb",
    "app/views/suppliers/edit.html.erb",
    "app/views/suppliers/index.html.haml",
    "app/views/suppliers/new.html.erb",
    "app/views/suppliers/show.html.erb",
    "config/routes.rb",
    "hefesto.gemspec",
    "lib/hefesto.rb",
    "lib/hefesto/engine.rb",
    "spec/hefesto_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/apslabs/hefesto-engine}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.0}
  s.summary = %q{Proyecto Compras}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.0"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.0"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

