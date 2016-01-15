module Authority
  class Place < ActiveFedora::Base
    include ::Authority::Concern::Thing

    property :address, predicate: ::RDF::Vocab::SCHEMA.address, multiple: false
    property :geo, predicate: ::RDF::Vocab::SCHEMA.geo, multiple: false
  end
end
