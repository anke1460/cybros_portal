module Bi
  class BasePolicy < ApplicationPolicy
    def show?
      user.report_maintainer? && user.departments.pluck(:company_name).uniq == ['上海天华建筑设计有限公司']
    end

    def export?
      show?
    end
  end
end
