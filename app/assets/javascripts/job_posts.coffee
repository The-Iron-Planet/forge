# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/





(($) ->
  'use strict'
  $.fn.paperCollapse = (options) ->
    settings = $.extend({}, $.fn.paperCollapse.defaults, options)
    $(this).find('.collapse-card__heading').add(settings.closeHandler).click ->
      if $(this).closest('.collapse-card').hasClass('active')
        settings.onHide.call this
        $(this).closest('.collapse-card').removeClass 'active'
        $(this).closest('.collapse-card').find('.collapse-card__body').slideUp settings.animationDuration, settings.onHideComplete
      else
        settings.onShow.call this
        $(this).closest('.collapse-card').addClass 'active'
        $(this).closest('.collapse-card').find('.collapse-card__body').slideDown settings.animationDuration, settings.onShowComplete
      return
    this

  $.fn.paperCollapse.defaults =
    animationDuration: 400
    easing: 'swing'
    closeHandler: '.collapse-card__close_handler'
    onShow: ->
    onHide: ->
    onShowComplete: ->
    onHideComplete: ->
  return) jQuery
