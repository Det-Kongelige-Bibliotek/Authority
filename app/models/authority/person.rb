module Authority
  class Person < ActiveFedora::Base
    include ::Authority::Concern::Thing
  end
end
