# frozen_string_literal: true

class Report::YearlySubsidiaryWorkloadingsController < Report::BaseController
  before_action :authenticate_user!
  before_action :set_page_layout_data, if: -> { request.format.html? }
  before_action :set_breadcrumbs, only: %i[show], if: -> { request.format.html? }

  def show
    authorize Bi::WorkHoursCountOrg
    @all_company_names = policy_scope(Bi::WorkHoursCountOrg).distinct.pluck(:orgname)


    all_month_names = policy_scope(Bi::WorkHoursCountOrg).all_month_names
    beginning_of_month = Date.parse(all_month_names.first).beginning_of_month
    end_of_month = Date.parse(all_month_names.last).end_of_month
    data = policy_scope(Bi::WorkHoursCountOrg).where(date: beginning_of_month..end_of_month, orgname: @selected_company_name)
    @dates = data.collect { |d| d.date.to_s(:month_and_year) }
    @day_rate = data.collect { |d| ((d.date_real / d.date_need.to_f) * 100).round(2) rescue 0 }
    @day_rate_ref = params[:day_rate_ref] || 90
    @planning_day_rate = data.collect { |d| ((d.blue_print_real / d.blue_print_need.to_f) * 100).round(2) rescue 0 }
    @planning_day_rate_ref = params[:planning_day_rate_ref] || 95
    @building_day_rate = data.collect { |d| ((d.construction_real / d.construction_need.to_f) * 100).round(2) rescue 0 }
    @building_day_rate_ref = params[:building_day_rate_ref] || 80
  end

  private

    def set_breadcrumbs
      current_company = current_user.user_company_names.first
      @selected_company_name = if current_user.roles.pluck(:report_view_all).any? || current_user.admin?
        params[:company_name]&.strip || current_company
      else
        current_company
      end
      @_breadcrumbs = [
      { text: t("layouts.sidebar.application.header"),
        link: root_path },
      { text: t("layouts.sidebar.operation.header"),
        link: report_operation_path },
      { text: t("layouts.sidebar.operation.yearly_subsidiary_workloading", company: @selected_company_name),
        link: report_yearly_subsidiary_workloading_path }]
    end


    def set_page_layout_data
      @_sidebar_name = "operation"
    end
end
