require_dependency "authority/application_controller"

module Authority
  class OrganizationsController < ApplicationController

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
            if @organization.update(organization_params)
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
            else
              format.html { render :new }
            end
          end
        end

        def destroy
          @organization.destroy
          respond_to do |format|
            format.html { redirect_to organizations_url }
          end
        end

        private

        def organization_params
          params.require(:organization).permit( :_name, :description,
                                          :address, email: [])
        end

        def set_organization
          @organization = ActiveFedora::Base.where(id: URI.unescape(params[:id])).first
        end

  end
end
