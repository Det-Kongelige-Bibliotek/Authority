module Authority
  class Organization < ::ActiveFedora::Base
    include ::Authority::Concern::Thing
  end
end