# frozen_string_literal: true

module Personal
  class ProofOfEmploymentApply < ApplicationRecord
    belongs_to :user
    has_one_attached :attachment

    include AttachmentValidate
    include Personal::CommonValidate
    validates :contract_belong_company, :contract_belong_company_code,
      presence: true
  end
end
