# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

insertTextAtCaret = (element, text) ->
  pos = element[0].selectionStart
  val = element.val()
  element.val(val.substring(0, pos) + text + val.substring(pos))
  newpos = pos + text.length
  element[0].setSelectionRange(newpos, newpos)

# FIXME: setSelectionRange fails on Firefox
# if target element is not visible. So we have to enable
# the target tab during the manipulation of caret
#
insertToWriterPanel = (string) ->
  textarea = $("#article_content")
  insertTextAtCaret(textarea, string)
  $('ul.tabs').tabs('select_tab', 'write')

setupRenderPreviewButton = (selector) ->
  $(selector).on 'click', (e) ->
    previewArea = $(".preview_area")
    title = $('#article_title').val()
    content = $('#article_content').val()
    $. ajax
      async:     true
      type:      "POST"
      url:       rootPath + "articles/preview"
      dataType:  "html"
      headers: {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')}
      data:
        article:
          title: title
          content: content
      success: (html, status, xhr) ->
        previewArea.empty()
        previewArea.append(html)

getPhotoList = (images_url, on_success_func) ->
  $.ajax
    url: images_url
    type: "GET"
    dataType: "html"
    success: (html, status, xhr) ->
      on_success_func(html)

countMarkedPhotos = (count_div, inserter_div) ->
  count = $(count_div).find('.marked').length
  s = if count > 1 then "s" else ""
  if count > 0
    $(inserter_div).children().show("slide")
    $("#{inserter_div} > .message").html "#{count} photo#{s} marked"
  else
    $(inserter_div).children().hide("slide")

clearMarkedPhotos = (photo_div, inserter_div) ->
  $(photo_div).find('.marked').removeClass('marked')
  $(photo_div).find('i.scale-transition').addClass('scale-out')
  countMarkedPhotos(photo_div, inserter_div)

insertMarkedPhotos = (photo_div) ->
  $(photo_div).find('.thumb-box').each (index) ->
    if $(this).children('.marked').length > 0
      photo = $(this).children('img')[0]
      insertToWriterPanel "![](#{photo.src}){:width=\"300px\" class=\"photo\"}\n"

insertPhotosInTab = (images_url) ->
  $('#photos').html(
    """
    <div class="preloader-wrapper big active">
      <div class="spinner-layer spinner-blue-only">
        <div class="circle-clipper left">
          <div class="circle"></div>
        </div>
      <div>
    <div>
    """)

  getPhotoList images_url, (photo_entries) ->
    $('#photos').html photo_entries

    $('div.thumb-box').on 'click', (ev) ->
      $(this).find('img').toggleClass('marked')
      $(this).children('i').toggleClass('scale-out')
      countMarkedPhotos("#photos", "#photo_inserter")
      ev.preventDefault()

    $('#photo_inserter .remove').on 'click', (ev) ->
      clearMarkedPhotos("#photos", "#photo_inserter")
      ev.preventDefault()

    $('#photo_inserter .share').on 'click', (ev) ->
      insertMarkedPhotos("#photos")
      clearMarkedPhotos("#photos", "#photo_inserter")
      ev.preventDefault()

    $('.async-pagination a').on 'click', (ev) ->
      insertPhotosInTab($(this).attr("href"))
      return false

$(document).on "turbolinks:load", ->
  $('select').material_select()
  $('.modal').modal();

  setupRenderPreviewButton('#preview-tab')

  $('#photo_inserter').children().hide()

  insertPhotosInTab(rootPath + "images")

  $('#submit_photo').on 'click', (ev) ->
    insertPhotosInTab(rootPath + "images")