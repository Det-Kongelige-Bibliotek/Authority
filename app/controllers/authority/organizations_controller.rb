require_dependency "authority/application_controller"

module Authority
  class OrganizationsController < ApplicationController
        before_filter do
          if params['modal'].present?
            self.class.layout  'modal' if params['modal'].present?
            logger.debug("modal is present ")
          else
            self.class.layout  'application'
          end
        end
       before_action :set_layout, only: [:show]
       before_action :set_organization, only: [:show, :edit, :update, :destroy]

        def index
          @organizations = Authority::Organization.all
        end

        def show
        end

        def edit
        end

        def update
          respond_to do |format|
            if @organization.update(person_params)
              format.html { redirect_to @organization }
            else
              format.html { render :new }
            end
          end
        end

        def new
          @organization = Organization.new
        end

        def create
          @organization = Organization.new(organization_params)

          respond_to do |format|
            if @organization.save
              format.html { redirect_to @organization }
              format.json  {render json: {id: @organization.id, name: @organization._name.force_encoding("UTF-8") } }
            else
              format.html { render :new }
              format.json { render json: @organization.errors, status: :unprocessable_entity }
            end
          end
        end

        def destroy
          @organization.destroy
          respond_to do |format|
            format.html { redirect_to organizations_url }
          end
        end

        def viaf
          reader = RDF::Reader.open(params[:url])
          stats = reader.each_statement.to_a

          unless stats.select {|s| s.predicate == 'http://schema.org/name' }.empty?
            org_name = stats.select {|s| s.predicate == 'http://schema.org/name' }.first.object.value
          end
          unless stats.select { |s| s.predicate == 'http://schema.org/alternateName' }.empty?
            alternate_name = stats.select { |s| s.predicate == 'http://schema.org/alternateName' }.first.object.value
          end
          unless stats.map {|s| s if s.predicate == 'http://schema.org/sameAs' and s.object.value.include? 'http://isni.org/isni/'}.all? &:nil?
          isni_uri = stats.map {|s| s if s.predicate == 'http://schema.org/sameAs' and
              s.object.value.include? 'http://isni.org/isni/'}.compact.first.object.value
          end

          json_file = {:org_name => org_name, :alternate_name => alternate_name, :isni_uri => isni_uri}
          render json: json_file.to_json
        end

        private

        def set_organization
          @organization = ActiveFedora::Base.where(id: URI.unescape(params[:id])).first
        end

        def organization_params
          params.require(:organization).permit( :_name, :description, :department,
          :address, :globbal_location_number, alternate_names: [],
          email: [], contact_point: [], telephone: [])
        end

  end
end
