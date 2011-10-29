###!
 * Project: fancy-photoset
 * Description: A jQuery plugin for viewing Flickr Photostreams in a Fancybox gallery
 * Author: Phil Cohen
 * License: MIT
 * Copyright: (c) 2010-2011 Phil Cohen (http://phlippers.net)
 *
 * Version: 0.5.0
 * Requires jQuery 1.4.2+, Fancybox 1.3.1+
 * Docs: http://phlippers.net/code/fancy-photoset
 ###

# the semi-colon before function invocation is a safety net against concatenated
# scripts and/or other plugins which may not be closed properly.
``
# Note that when compiling with coffeescript, the plugin is wrapped in another
# anonymous function. We do not need to pass in undefined as well, since
# coffeescript uses (void 0) instead.
(($, window, document) ->
  # window and document are passed through as local variables rather than globals
  # as this (slightly) quickens the resolution process and can be more efficiently
  # minified (especially when both are regularly referenced in your plugin).

  # Create the defaults once
  pluginName = "fancyPhotoset"
  defaults =
    apiKey:     ""
    photosetId: ""
    small:      "square"
    large:      "medium"
    captions:   true
    firstOnly:  false
    fancybox:   {}

  # The actual plugin constructor
  class FancyPhotoset
    constructor: (@element, options) ->
      # jQuery has an extend method which merges the contents of two or
      # more objects, storing the result in the first object. The first object
      # is generally empty as we don't want to alter the default options for
      # future instances of the plugin
      @options = $.extend {}, defaults, options

      @_defaults = defaults
      @_name = pluginName

      @init()

    init: ->
      # Place initialization logic here
      # You already have access to the DOM element and the options via the instance,
      # e.g., this.element and this.options
      options = @options
      element = $ @element

      domId   = "fancyPhotoset-#{options.photosetId}"
      jsonUrl = "http://api.flickr.com/services/rest/?" +
                "method=flickr.photosets.getPhotos&" +
                "api_key=#{options.apiKey}&" +
                "photoset_id=#{options.photosetId}&" +
                "extras=url_sq,url_t,url_s,url_m,url_o&" +
                "format=json&jsoncallback=?"

      # build the list element that will be our photoset container
      element.append ($ "<ul/>").attr("id", domId).addClass("fancyPhotoset")

      # fetch results from Flickr
      $.getJSON jsonUrl, (data) ->

        # iterate over the photos in the photoset
        $.each data.photoset.photo, (index, photo) ->

          # build the thumbnail image
          image = ($ "<img/>").attr
            src:   FancyPhotoset::urlFor(photo, {size: options.small})
            title: photo.title
            alt:   photo.title

          # build the link to the large image
          anchor = ($ "<a/>").attr
            href: FancyPhotoset::urlFor(photo, {size: options.large})
            rel:  "flickr-#{options.photosetId}"
            title: photo.title

          # link the thumbnail to the large image and activate fancybox
          anchor.html(image).fancybox options.fancybox

          # optionally build the caption
          if options.captions
            image.after ($ "<span/>").addClass("caption").text(photo.title)

          # add the anchor as an item to our list
          element.find("ul").append ($ "<li/>").html(anchor)

        # optionally hide all except the first image
        element.find("li").not(":first").hide() if options.firstOnly

    # helper method for generating static image url
    urlFor: (photo, options) ->
      {
        square:    photo.url_sq
        thumbnail: photo.url_t
        small:     photo.url_s
        medium:    photo.url_m
        original:  photo.url_o
      }[options.size]

  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      unless $.data @, "plugin_#{pluginName}"
        $.data @, "plugin_#{pluginName}", new FancyPhotoset(@, options)

)(jQuery, window, document)
