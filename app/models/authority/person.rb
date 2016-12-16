module Authority
  class Person < ActiveFedora::Base
    include Hydra::AccessControls::Permissions
    include ::Authority::Concern::Thing


    property :additional_name, predicate: ::RDF::Vocab::SCHEMA.additionalName, multiple: false do |index|
      index.as :stored_searchable
    end
    property :address, predicate: ::RDF::Vocab::SCHEMA.address, multiple: false
    property :affiliation, predicate: ::RDF::Vocab::SCHEMA.affiliation, multiple: false # Organization
    property :alumni_of, predicate: ::RDF::Vocab::SCHEMA.alumniOf, multiple: false # Organization or EducationalOrganization
    property :award, predicate: ::RDF::Vocab::SCHEMA.award, multiple: false
    property :birth_date, predicate: ::RDF::Vocab::SCHEMA.birthDate, multiple: false
    property :birth_place, predicate: ::RDF::Vocab::SCHEMA.birthPlace, multiple: false
    property :children, predicate: ::RDF::Vocab::SCHEMA.children, multiple: false # Person
    property :death_date, predicate: ::RDF::Vocab::SCHEMA.deathDate, multiple: false
    property :death_place, predicate: ::RDF::Vocab::SCHEMA.deathPlace, multiple: false
    property :email, predicate: ::RDF::Vocab::SCHEMA.email, multiple: true do |index|
      index.as :stored_searchable
    end
    property :family_name, predicate: ::RDF::Vocab::SCHEMA.familyName, multiple: false do |index|
      index.as :stored_searchable
    end
    property :gender, predicate: ::RDF::Vocab::SCHEMA.gender, multiple: false
    property :given_name, predicate: ::RDF::Vocab::SCHEMA.givenName, multiple: false do |index|
      index.as :stored_searchable
    end
    property :honorific_prefix, predicate: ::RDF::Vocab::SCHEMA.honorificPrefix, multiple: false
    property :honorific_suffix, predicate: ::RDF::Vocab::SCHEMA.honorificSuffix, multiple: false
    property :job_title, predicate: ::RDF::Vocab::SCHEMA.jobTitle, multiple: false
    property :member_of, predicate: ::RDF::Vocab::SCHEMA.memberOf, multiple: false # ProgramMembership or Organization
    property :nationality, predicate: ::RDF::Vocab::SCHEMA.nationality, multiple: false # Country
    property :_parent, predicate: ::RDF::Vocab::SCHEMA.parent, multiple: false # Person
    property :performer_in, predicate: ::RDF::Vocab::SCHEMA.performerIn, multiple: false # Event
    property :related_to, predicate: ::RDF::Vocab::SCHEMA.relatedTo, multiple: false # Person
    property :sibling, predicate: ::RDF::Vocab::SCHEMA.sibling, multiple: false # Person
    property :spouse, predicate: ::RDF::Vocab::SCHEMA.spouse, multiple: false # Person
    property :works_for, predicate: ::RDF::Vocab::SCHEMA.worksFor, multiple: false # Organization

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
      full << family_name + ", "unless family_name.blank?
      full << given_name unless given_name.blank?
      full << additional_name unless additional_name.blank?
      full.join(" ")
    end

    def display_date
      self.date_range(start_date: birth_date, end_date: death_date)
    end

    # TODO: Look into removing this
    def self.find_or_create_person(forename,surname)
      logger.warn "find_or_create_person is deprecated. User find_or_create instead"
      person = Person.where(:given_name => forename, :family_name => surname).first
      if person.nil?
        person = Person.create(:given_name => forename, :family_name => surname )
      end
      person
    end

  end
end
