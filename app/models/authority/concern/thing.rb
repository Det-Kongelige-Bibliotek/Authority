module Authority
  module Concern
    module Thing
      extend ActiveSupport::Concern
      included do
        property :same_as, predicate: ::RDF::Vocab::SCHEMA.sameAs, multiple: true
        property :description, predicate: ::RDF::Vocab::SCHEMA.description, multiple: false
        property :image, predicate: ::RDF::Vocab::SCHEMA.image, multiple: false
        property :_name, predicate: ::RDF::Vocab::SCHEMA.name, multiple: false do |index|
          index.as :stored_searchable
        end
        property :alternate_names, predicate: ::RDF::Vocab::SCHEMA.alternateName, multiple: true
      end

      def same_as_uri=(uris)
        self.same_as = []
        uris.each do |uri|
          self.same_as += [::RDF::URI.new(uri)] if uri.present?
        end
      end

      def same_as_uri
        result = []
        self.same_as.each do |s|
          result << s.to_term.value unless s.nil?
        end
        result
      end

      def date_range(dates={})
        date = ""
        date += "#{dates[:start_date]}-" if dates[:start_date].present?
        if  dates[:end_date].present? then
          if  dates[:start_date].present? then
            date += "#{dates[:end_date]}"
          else
            date += "-" + "#{dates[:end_date]}"
          end
        end
        date
      end

      def display_value
        value = ''
        value += _name if _name.present?
        if alternate_names.present? then
          value += ", "
          value += alternate_names.join(", ")
        end
        value
      end
    end
  end
end