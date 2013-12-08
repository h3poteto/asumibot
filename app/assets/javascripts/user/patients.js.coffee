$ ->
  chartoptions = {
    chart: {
      renderTo: 'chart',
      marginRight: 80,
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
      categories: gon.datedata
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
      align: 'right',       
      verticalAlign: 'top'
    },
    series: [{
      name: "阿澄度",      
      color: '#ff9114',      
      type: 'line',      
      data: gon.leveldata
    }]
  }

  chart = new Highcharts.Chart(chartoptions)
        
      