# frozen_string_literal: true

module Personal
  class PublicRentalHousingDatatable < ApplicationDatatable
    def_delegator :@view, :person_public_rental_housing_path
    def_delegator :@view, :view_attachment_person_public_rental_housing_path
    def_delegator :@view, :start_approve_person_public_rental_housing_path

    def initialize(params, opts = {})
      @public_rental_housing_applies = opts[:public_rental_housing_applies]
      super
    end

    def view_columns
      @view_columns ||= {
        employee_name: { source: 'Personal::PublicRentalHousingApply.employee_name', cond: :like, searchable: true, orderable: true },
        clerk_code: { source: 'Personal::PublicRentalHousingApply.clerk_code', cond: :like, searchable: true, orderable: true },
        task_id: { source: 'Personal::PublicRentalHousingApply.begin_task_id', cond: :string_eq, searchable: true, orderable: true },
        belong_company_name: { source: 'Personal::PublicRentalHousingApply.belong_company_name', cond: :like, searchable: true, orderable: true },
        belong_department_name: { source: 'Personal::PublicRentalHousingApply.belong_department_name', cond: :like, searchable: true, orderable: true },
        contract_belong_company: { source: 'Personal::PublicRentalHousingApply.contract_belong_company', cond: :like, searchable: true, orderable: true },
        stamp_to_place: { source: 'Personal::PublicRentalHousingApply.stamp_to_place', cond: :like, searchable: true, orderable: true },
        stamp_comment: { source: 'Personal::PublicRentalHousingApply.stamp_comment', cond: :like, searchable: true, orderable: true },
        item_action: { source: nil, searchable: false, orderable: false }
      }
    end

    def data
      records.map do |r|
        r_delete = link_to I18n.t('person.public_rental_housings.index.actions.delete'), person_public_rental_housing_path(r),
          method: :delete, data: { confirm: '你确定要删除吗？' }
        r_start_approve = link_to I18n.t('person.public_rental_housings.index.actions.start_approve'), start_approve_person_public_rental_housing_path(r),
          class: 'btn btn-primary', method: :patch, data: { disable_with: '处理中' }
        see_attachment = if r.attachment.attached?
          link_to I18n.t('person.public_rental_housings.new.attachment'), view_attachment_person_public_rental_housing_path(r), remote: true
        end
        { employee_name: r.employee_name,
          clerk_code: r.clerk_code,
          task_id: (r.begin_task_id.present? ? link_to(I18n.t('person.public_rental_housings.index.actions.look_workflow'), person_public_rental_housing_path(id: r.id, begin_task_id: r.begin_task_id)) : ''),
          belong_company_name: r.belong_company_name,
          belong_department_name: r.belong_department_name,
          contract_belong_company: r.contract_belong_company,
          stamp_to_place: Personal::PublicRentalHousingApply.sh_stamp_place.key(r.stamp_to_place),
          stamp_comment: "#{r.stamp_comment}#{see_attachment}".html_safe,
          item_action: "#{r_delete}#{r_start_approve}".html_safe
        }
      end
    end

    def get_raw_records
      @public_rental_housing_applies
    end
  end
end
