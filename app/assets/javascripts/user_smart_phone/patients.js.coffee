class gon.Patients

  show: ->
    chartoptions = {
      chart: {
        renderTo: 'chart',
        marginRight: 30,
        marginLeft: 50,
        marginBottom: 50,
        height: 200,
        backgroundColor:
          linearGradient: [0, 0, 500, 500],
          stops: [[0, 'rgb(255, 255, 255)'],[1, 'rgb(200, 200, 255)']]
      },
      title: {
        text: "阿澄度推移"
      },
      xAxis: {
        title: false,
        categories: gon.datedata.slice(gon.datedata.length / 2, gon.datedata.length - 1)
        allowDecimals: false
      },
      yAxis: [{
        title: false,
        labels:{
          formatter: ()->
            return ((@).value + "%")
        }
        allowDecimals: false,
        max: 100,
        min: 0
      }],
      tooltip: {
        formatter: ()->
          return '<b>' + (@).series.name + '</b><br/>' + (@).x + ': ' + (@).y + "%"
      },
      legend: {
        borderWidth: 0,
        layout: 'vertical',
        align: 'center',
        verticalAlign: 'bottom'
      },
      series: [{
        name: "阿澄度",
        color: '#ff9114',
        type: 'line',
        data: gon.leveldata.slice(gon.leveldata.length / 2, gon.leveldata.length - 1)
      }]
    }

    chart = new Highcharts.Chart(chartoptions)

gon.patients_show = ->
  @patients = new @Patients
  @patients.show()
