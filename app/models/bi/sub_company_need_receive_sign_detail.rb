# frozen_string_literal: true

module Bi
  class SubCompanyNeedReceiveSignDetail < BiLocalTimeRecord
    self.table_name = "SUB_COMPANY_NEED_RECEIVE_SIGN_DETAIL"

    def self.all_month_names
      order(date: :asc).pluck(:date).collect { |d| d.to_s(:month_and_year) }.uniq
    end
  end
end