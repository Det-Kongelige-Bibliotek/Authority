module Authority
  class Person < ActiveFedora::Base
    include ::Authority::Concern::Thing

    property :family_name, predicate: ::RDF::Vocab::SCHEMA.familyName, multiple: false
    property :given_name, predicate: ::RDF::Vocab::SCHEMA.givenName, multiple: false
    property :additional_name, predicate: ::RDF::Vocab::SCHEMA.additionalName, multiple: false
    property :address, predicate: ::RDF::Vocab::SCHEMA.address, multiple: false
    property :gender, predicate: ::RDF::Vocab::SCHEMA.gender, multiple: false
    property :job_title, predicate: ::RDF::Vocab::SCHEMA.jobTitle, multiple: false
    property :email, predicate: ::RDF::Vocab::SCHEMA.email, multiple: false
    property :birth_date, predicate: ::RDF::Vocab::SCHEMA.birthDate, multiple: false
    property :death_date, predicate: ::RDF::Vocab::SCHEMA.deathDate, multiple: false

  end
end
