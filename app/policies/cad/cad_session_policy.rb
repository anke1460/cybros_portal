# frozen_string_literal: true

module Cad
  class CadSessionPolicy < ApplicationPolicy
    def index?
      return false unless user.present?
      user.roles.pluck(:cad_session).any? || user.admin?
    end

    def report_sessions?
      index?
    end

    def report_operations?
      index?
    end

    def report_all?
      index?
    end
  end
end
