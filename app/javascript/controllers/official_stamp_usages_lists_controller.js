import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    const normalColumns = [
      {"data": "employee_name"},
      {"data": "clerk_code"},
      {"data": "task_id"},
      {"data": "belong_company_name"},
      {"data": "belong_department_name"},
      {"data": "stamp_to_place"},
      {"data": "application_class"},
      {"data": "stamp_comment"},
      {"data": "status"},
      {"data": "item_action", bSortable: false}
    ];

    $('#official-stamp-usages-lists-datatable').dataTable({
      "processing": true,
      "serverSide": true,
      "autoWidth": false,
      "ajax": $('#official-stamp-usages-lists-datatable').data('source'),
      "pagingType": "full_numbers",
      "columns": normalColumns,
      stateSave: true,
      stateSaveCallback: function(settings, data) {
          localStorage.setItem('DataTables_official-stamp-usages-lists', JSON.stringify(data));
        },
      stateLoadCallback: function(settings) {
        return JSON.parse(localStorage.getItem('DataTables_official-stamp-usages-lists'));
        }
    });
  }

  disconnect() {
    $('#official-stamp-usages-lists-datatable').DataTable().destroy();
  }
}
