module Authority
  class Engine < ::Rails::Engine
    isolate_namespace Authority

    config.autoload_paths += %W(
      #{config.root}/app/models/concern
    )
  end
end
