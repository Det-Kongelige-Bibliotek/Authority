module Authority
  class Engine < ::Rails::Engine
    isolate_namespace Authority

    require 'hydra'
  end
end
