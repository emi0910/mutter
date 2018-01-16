# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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

$(document).on "turbolinks:load", ->
  $('select').material_select()
  setupRenderPreviewButton('#preview-tab')