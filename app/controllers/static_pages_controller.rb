class StaticPagesController < ApplicationController
  before_action :load_resouces_data, only: :home

  def home
    search_params = params[:search] || {}
    @search = Search.new search_params

    data = Player.search(body: player_query_dsl(params[:search]))
    @players = data.hits.map{|hit| hit["_source"]}
  end

  private
  def load_resouces_data
    @nations = Nation.pluck :name, :id
    @clubs = Club.pluck :name, :id
    @continents = Nation.continents.to_a
    @positions = Player.positions.to_a
  end

  def player_query_dsl search_params
    query = base_query_dsl
    filter = query[:query][:bool][:filter]

    if search_params.nil?
      query[:query][:bool][:must] << {match_all: {}}
    else
      if search_params[:player_name].present?
        query[:query][:bool][:must] << {
          multi_match: {
            query: search_params[:player_name],
            fields: ["name.analyzed", "full_name.analyzed"],
          }
        }
      end

      filter << {term: {nation_id: search_params[:nations]}} if search_params[:nations].present?
      filter << {term: {continent_id: search_params[:continents]}} if search_params[:continents].present?
      filter << {term: {position_id: search_params[:positions]}} if search_params[:positions].present?

      filter << {terms: {club_ids: Array(search_params[:clubs])}} if search_params[:clubs].present?
    end

    query
  end

  def base_query_dsl
    {
      query: {
        bool: {
          must: [],
          filter: [],
          should: [],
        }
      },
      size: 10000, from: 0,
      highlight: {},
    }
  end
end
