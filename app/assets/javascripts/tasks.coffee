class @DateSetter
  constructor: (id) ->
    that = @
    $(id).html('')
    $(id).datetimepicker({inline: true, format: 'YYYY-MM-DD'})
    $(id).on('dp.change', (e) ->
      that.set_date_task(e.date.format('YYYY-MM-DD'))
    )

  set_date_task: (date)->
    $.ajax({
      url: "/tasks.js?date=#{date}", type: "GET", 
      success: (resp) ->
        html_resp = $.parseHTML(resp)
        tbody = $(html_resp).find('#tasks-t-body')
        $('#tasks-t-body').replaceWith(tbody)
        $('#taks-caption').html("Tasks for #{date}")
        LocalTime.run()
    })
    #console.log date