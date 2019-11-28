# frozen_string_literal: true

class Company::ContractsMapsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page_layout_data, if: -> { request.format.html? }

  def show
    prepare_meta_tags title: t(".title")
    @hide_app_footer = true

    @all_cities = Bi::NewMapInfo.all_cities
    @city = params[:city].presence || '上海市'
    @client = params[:client].presence


    @all_tracestates = Bi::NewMapInfo.all_tracestates
    @tracestate = params[:tracestate].presence || '跟踪中'
    @query_text = params[:query_text].presence

    map_infos = Bi::NewMapInfo.where.not(coordinate: nil).includes(:rels)
    map_infos = map_infos.where(tracestate: @tracestate) unless @tracestate == '所有'
    map_infos = map_infos.where(company: @city) unless @city == '所有'
    map_infos = map_infos.where("developercompanyname LIKE ?", "%#{@client}%") if @client.present?
    map_infos = map_infos.where("developercompanyname LIKE ? OR marketinfoname LIKE ?", "%#{@query_text}%", "%#{@query_text}%") if @query_text.present?

    @valid_map_infos = map_infos.reject {|m| !m.coordinate.include?(',')}

    total_cos = @valid_map_infos.collect(&:coordinate)
    @valid_map_point = @valid_map_infos.collect do |m|
      { title: m.marketinfoname,
        lat: m.coordinate.split(',')[1].to_f,
        lng: m.coordinate.split(',')[0].to_f,
        owner: m.maindeptnamedet,
        developer_company: m.developercompanyname,
        project_code: m.id,
        trace_state: m.tracestate,
        scale_area: m.scalearea,
        province: m.province,
        city: m.company,
        project_type: m.projecttype,
        big_stage: m.bigstage,
        contracts: m.rels.collect { |r| { docname: r.docname, url: r.address } } }
    end

    lat_total_cos = total_cos.collect { |c| c.split(',')[1].to_f }
    lng_total_cos = total_cos.collect { |c| c.split(',')[0].to_f }
    @avg_lat = lat_total_cos.sum / lat_total_cos.size.to_f
    @avg_lng = lng_total_cos.sum / lng_total_cos.size.to_f
  end

  protected

    def set_page_layout_data
      @_sidebar_name = "company"
    end
end
