module Authority
  class Organization < ::ActiveFedora::Base
    include ::Authority::Concern::Thing

    property :address, predicate: ::RDF::Vocab::SCHEMA.address, multiple: false
    property :contact_point, predicate: ::RDF::Vocab::SCHEMA.contactPoint, multiple: true
    property :department, predicate: ::RDF::Vocab::SCHEMA.department, multiple: false
    property :email, predicate: ::RDF::Vocab::SCHEMA.email, multiple: true do |index|
      index.as :stored_searchable
    end
    property :globbal_location_number, predicate: ::RDF::Vocab::SCHEMA.globalLocationNumber, multiple: false
    property :telephone, predicate: ::RDF::Vocab::SCHEMA.telephone, multiple: true
  end
end