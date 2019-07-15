class Report::ProjectMilestoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page_layout_data, if: -> { request.format.html? }
  before_action :set_breadcrumbs, only: %i[show], if: -> { request.format.html? }

  def show
    @number_in_row = (params[:number_in_row] || 7).to_i

    @person_count_by_department = Bi::ShRefreshRate.person_count_by_department
    @person_by_department_in_sh = Bi::ShRefreshRate.person_by_department_in_sh
    @departments = @person_by_department_in_sh.keys
  end

  private

  def set_breadcrumbs
    @_breadcrumbs = [
    { text: t("layouts.sidebar.application.header"),
      link: root_path },
    { text: t("layouts.sidebar.report.header"),
      link: report_root_path },
    { text: t("layouts.sidebar.report.project_milestore"),
      link: report_project_milestore_path }]
  end


  def set_page_layout_data
    @_sidebar_name = "report"
  end
end