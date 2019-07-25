# frozen_string_literal: true

class Report::PredictContractsController < Report::BaseController
  before_action :authenticate_user!, unless: -> { params[:in_iframe].present? }
  before_action :set_page_layout_data, if: -> { request.format.html? && params[:in_iframe].blank? }
  before_action :set_breadcrumbs, only: %i[show], if: -> { request.format.html? && params[:in_iframe].blank? }
  after_action :cors_set_access_control_headers, if: -> { params[:in_iframe].present? }

  def show
    last_available_date = Bi::TrackContract.last_available_date

    data = policy_scope(Bi::TrackContract).where(date: last_available_date)
      .select("businessdeptcode, SUM(contractconvert) contractconvert, SUM(convertrealamount) convertrealamount")
      .group(:businessdeptcode)

    all_business_ltd_codes = data.collect(&:businessdeptcode)
    only_have_data_dept = (Bi::ShReportDeptOrder.all_deptcodes_in_order & all_business_ltd_codes)

    @company_short_names = only_have_data_dept.collect do |c|
      long_name = Bi::PkCodeName.company_long_names.fetch(c, c)
      Bi::StaffCount.company_short_names.fetch(long_name, long_name)
    end

    @contract_convert = only_have_data_dept.collect do |dept_code|
      d = data.find { |t| t.businessdeptcode == dept_code }
      (d.contractconvert / 10000.to_f).round(2)
    end
    @convert_real_amount = only_have_data_dept.collect do |dept_code|
      d = data.find { |t| t.businessdeptcode == dept_code }
      (d.convertrealamount / 10000.to_f).round(2)
    end
    @contract_convert_totals = @contract_convert.zip(@convert_real_amount).map { |d| d[0] + d[1] }
  end

  private

  def set_breadcrumbs
    @_breadcrumbs = [
    { text: t("layouts.sidebar.application.header"),
      link: root_path },
    { text: t("layouts.sidebar.report.header"),
      link: report_root_path },
    { text: t("layouts.sidebar.report.predict_contract"),
      link: report_predict_contract_path }]
  end


  def set_page_layout_data
    @_sidebar_name = "report"
  end
end
