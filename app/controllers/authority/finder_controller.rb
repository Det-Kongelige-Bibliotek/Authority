module Authority
  class FinderController < ApplicationController
    def search
      result = map_result(Finder.all_things(params[:q],params[:model]))
      render json:  result
    end

    def get_obj
      result = map_result(Finder.obj(URI.unescape(params[:id])))
      if result.empty?
        render :nothing => true, :status => '404'
      else
        render json: result[0]
      end
    end

    def search_by_same_as_uri
      result = map_result(Finder.search_by_same_as_uri(params[:uri]))
      if result.empty?
        render :nothing => true, :status => '404'
      else
        render json: result[0]
      end
    end

    private

    def map_result(result)
      result = result.map {|doc| { :val => doc['display_value_ssm'].try(:first),:id => doc['id']} }
    end
  end
end