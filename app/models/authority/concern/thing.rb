module Authority
  module Concern
    module Thing
      extend ActiveSupport::Concern
      included do
        property :same_as, predicate: ::RDF::Vocab::SCHEMA.sameAs, multiple: true
        property :description, predicate: ::RDF::Vocab::SCHEMA.description, multiple: false
        property :image, predicate: ::RDF::Vocab::SCHEMA.image
        property :_name, predicate: ::RDF::Vocab::SCHEMA.name, multiple: false do |index|
          index.as :stored_searchable
        end
        property :alternate_names, predicate: ::RDF::Vocab::SCHEMA.alternateName, multiple: true
      end
    end
  end
end