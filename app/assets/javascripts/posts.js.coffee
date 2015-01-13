# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#post_content').autosize()
  $('#post_parent_id').select2(width: '100%', allowClear: true)
  prettyPrint()
  preview()
  initDropzone()
  initMousetrap()

initDropzone = ->
  $('.js_post_content_group').dropzone
    url: '/attachments.json'
    paramName: 'attachment[file]'
    previewsContainer: false
    params:
      authenticity_token: $('meta[name=csrf-token]').prop('content')
    drop: ->
      NProgress.start()
    success: (file, json) ->
      text = if json.is_image
        "[![](#{json.path})](#{json.path})"
      else
        "[#{json.name}](#{json.path})"
      insert(text)
      preview()
    complete: ->
      NProgress.done()

initMousetrap = ->
  Mousetrap.bind 'e', ->
    Turbolinks.visit $('.js_edit_post').prop('href')

  Mousetrap.bindGlobal 'mod+s', (e) ->
    if /post_title|post_content/.test(e.target.id)
      e.preventDefault()
      $('.js_submit_post').click()

preview = _.throttle(->
  return unless $('#post_title, #post_content').length
  params =
    post:
      title: $('#post_title').val()
      content: $('#post_content').val()
  $.post '/posts/preview.json', params, (json) ->
    $('.js_preview_title').html(json.title)
    $('.js_preview_content').html(json.content)
    $('.js_preview_count').html(json.count)
    prettyPrint()
, 1000)

insert = (text, mode= 'after') ->
  $('#post_content').selection('insert', {text: text, mode: mode}).trigger('autosize.resize')
  preview()

$(document).on 'keyup', '#post_title, #post_content', preview

$(document).on 'change', '.js_post_template', ->
  id = $(this).val()
  if id
    $.get "/posts/#{id}.md", (data) ->
      if data
        $('#post_content').val(data)

$(document).on 'click', '.js_insert_link', (e) ->
  e.preventDefault()
  url = prompt('URL')
  if url
    NProgress.start()
    params =
      url: url
    $.ajax
      url: '/links'
      method: 'POST'
      data: params
      success: (json) ->
        insert("[#{json.title}](#{json.url})")
      complete: ->
        NProgress.done()

$(document).on 'click', '.js_insert_table', (e) ->
  e.preventDefault()
  insert([
    ' | '
    '--- | --- '
    ' | '
    ' | '
    ''
  ].join('\n'))

$(document).on 'click', '.js_insert_quote', (e) ->
  e.preventDefault()
  insert('> ', 'before')

