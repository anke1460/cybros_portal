import { Controller } from "stimulus"

let departmentRealReceivesChart;
let departmentNeedReceivesChart;
let departmentRealReceivesStaffChart;
let departmentNeedReceivesStaffChart;

export default class extends Controller {
  connect() {
    departmentRealReceivesChart = echarts.init(document.getElementById('department-real-receives-chart'));

    const realXAxisData = JSON.parse(this.data.get("real_x_axis"));
    const realReceives = JSON.parse(this.data.get("real_receives"));

    departmentNeedReceivesChart = echarts.init(document.getElementById('department-need-receives-chart'));

    const needXAxisData = JSON.parse(this.data.get("need_x_axis"));
    const needLongAccountReceives = JSON.parse(this.data.get("need_long_account_receives"));
    const needShortAccountReceives = JSON.parse(this.data.get("need_short_account_receives"));
    const needShouldReceives = JSON.parse(this.data.get("need_should_receives"));

    const real_option = {
        title: {
          text: '本年累计实收款'
        },
        legend: {
            data: ['本年累计实收款（万元）'],
            align: 'left'
        },
        grid: {
          left: 70,
          right: 110,
          top: 60,
          bottom: 125
        },
        toolbox: {
          feature: {
            dataView: {},
            saveAsImage: {
                pixelRatio: 2
            }
          }
        },
        tooltip: {},
        xAxis: {
          data: realXAxisData,
          silent: true,
          axisLabel: {
            interval: 0,
            rotate: -40
          },
          splitLine: {
              show: false
          }
        },
        yAxis: {
          axisLabel: {
            show: true,
            interval: 'auto',
            formatter: '{value}万'
          }
        },
        series: [{
          name: '本年累计实收款（万元）',
          type: 'bar',
          data: realReceives,
          color: '#738496',
          label: {
            normal: {
              show: true,
              position: 'top',
              color: '#171717'
            }
          }
        }]
    };

    const need_option = {
        title: {
          text: '应收款（财务+业务）'
        },
        legend: {
            data: ['超长帐龄','扣除超长帐龄以外的财务应收','业务应收款'],
            align: 'left'
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross'
          }
        },
        grid: {
          left: 70,
          right: 110,
          top: 50,
          bottom: 90
        },
        toolbox: {
          feature: {
            dataView: {},
            saveAsImage: {
                pixelRatio: 2
            }
          }
        },
        xAxis: {
          data: needXAxisData,
          silent: true,
          axisLabel: {
            interval: 0,
            rotate: -40
          },
          splitLine: {
              show: false
          }
        },
        yAxis: [{
          type: 'value',
          position: 'left',
          axisLabel: {
            formatter: '{value}万'
          }
        }],
        series: [{
          name: '超长帐龄',
          type: 'bar',
          stack: '应收',
          data: needLongAccountReceives,
          itemStyle: {
            color: '#FA9291'
          },
          label: {
            normal: {
              show: true,
              position: 'insideTop'
            }
          }
        },{
          name: '扣除超长帐龄以外的财务应收',
          type: 'bar',
          stack: '应收',
          data: needShortAccountReceives,
          itemStyle: {
            color: '#A1D189'
          },
          label: {
            normal: {
              show: true,
              position: 'insideTop'
            }
          }
        },{
          name: '业务应收款',
          type: 'bar',
          stack: '应收',
          data: needShouldReceives,
          itemStyle: {
            color: '#738496'
          },
          barMaxWidth: 38,
          label: {
            normal: {
              show: true,
              position: 'top'
            }
          }
        }]
    };

    function drill_down_real_receives_on_click(params) {
      if (params.componentType === 'series') {
        if (params.seriesType === 'bar') {
          const series_company = realXAxisData[params.dataIndex];
          const month_name = $('#month_name').val();
          let url;
          url = "/report/subsidiary_department_receive";

          if (url.indexOf('?') > -1) {
            url += '&company_name=' + encodeURIComponent(series_company) + '&month_name=' + encodeURIComponent(month_name);
          } else {
            url += '?company_name=' + encodeURIComponent(series_company) + '&month_name=' + encodeURIComponent(month_name);
          }

          window.location.href = url;
        }
      }
    }

    departmentRealReceivesChart.on('click', drill_down_real_receives_on_click);
    departmentRealReceivesChart.setOption(real_option, false);
    departmentNeedReceivesChart.setOption(need_option, false);

    setTimeout(() => {
      departmentRealReceivesChart.resize();
      departmentNeedReceivesChart.resize();
    }, 200);
  }

  layout() {
    departmentRealReceivesChart.resize();
    departmentNeedReceivesChart.resize();
  }

  disconnect() {
    departmentRealReceivesChart.dispose();
    departmentNeedReceivesChart.dispose();
  }
}
