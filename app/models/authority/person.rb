module Authority
  class Person < ActiveFedora::Base
    include ::Authority::Concern::Thing

    property :family_name, predicate: ::RDF::Vocab::SCHEMA.familyName, multiple: false do |index|
      index.as :stored_searchable
    end
    property :given_name, predicate: ::RDF::Vocab::SCHEMA.givenName, multiple: false do |index|
      index.as :stored_searchable
    end

    property :additional_name, predicate: ::RDF::Vocab::SCHEMA.additionalName, multiple: false do |index|
      index.as :stored_searchable
    end
    property :address, predicate: ::RDF::Vocab::SCHEMA.address, multiple: false
    property :gender, predicate: ::RDF::Vocab::SCHEMA.gender, multiple: false
    property :job_title, predicate: ::RDF::Vocab::SCHEMA.jobTitle, multiple: false
    property :email, predicate: ::RDF::Vocab::SCHEMA.email, multiple: false do |index|
      index.as :stored_searchable
    end
    property :birth_date, predicate: ::RDF::Vocab::SCHEMA.birthDate, multiple: false
    property :death_date, predicate: ::RDF::Vocab::SCHEMA.deathDate, multiple: false

    before_save :set_thing_name

    # (before save) Set the construct the _name from family, additional and given name
    def set_thing_name
      self.set_name = full_name
    end

    def display_value
      value = (full_name.present?) ? full_name : ''
      value += ', ' if birth_date.present? || death_date.present?
      value += self.display_date if self.display_date.present?
      value
    end

    # Create the full name of a person
    def full_name
      full = []
      full << given_name unless given_name.empty?
      full << additional_name unless additional_name.empty?
      full << family_name unless family_name.empty?
      full.join(" ")
    end

    def display_date
      self.date_range(start_date: birth_date, end_date: death_date)
    end

  end
end
