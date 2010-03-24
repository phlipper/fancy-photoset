/*! Copyright (c) 2010 Phil Cohen (http://phlippers.net)
 * Dual licensed under the MIT (MIT_LICENSE.txt)
 * and GPL Version 2 (GPL_LICENSE.txt) licenses.
 *
 * Version: 0.2.0
 * Requires jQuery 1.4.2+, Fancybox 1.3.1+
 * Docs: http://phlippers.net/code/fancy-photoset
 */
(function($) {
 $.fn.fancyPhotoset = function(options) {
   var opts    = $.extend($.fn.fancyPhotoset.defaults, options);
   var domId   = 'fancyPhotoset-' + opts.photosetId;
   var jsonUrl = 'http://api.flickr.com/services/rest/?&method=flickr.photosets.getPhotos&api_key={apiKey}&photoset_id={photosetId}&format=json&jsoncallback=?'.replace(/\{\w+\}/g, function(match) {
     return opts[match.replace(/\{|\}/g, '')];
   });

   // Create a fancyPhotoset for each selector
   return this.each(function() {
     var obj = $(this);
     $(obj).append(
       $('<ul/>').attr('id', domId).addClass('fancyPhotoset')
     );

     $.getJSON(jsonUrl, function(data) {
       $.each(data.photoset.photo, function(index, photo) {
         $(obj).find('ul').append(
           $('<li/>').html(
             $('<a/>').attr({'href': $.fn.fancyPhotoset.urlFor(photo, {size: opts.large}), 'rel': 'flickr-' + opts.photosetId, 'title': photo.title}).html(
               $('<img/>').attr({'src': $.fn.fancyPhotoset.urlFor(photo, {size: opts.small}), 'title': photo.title, 'alt': photo.title}).after(
                 (opts.captions ? $('<span/>').addClass('caption').text(photo.title) : '')
               )
             ).fancybox()
           )
         );
       });

       // Hide all except the first image
       if (opts.firstOnly) {
         $(obj).find('li').not(':first').hide();
       }
     });
   });
 };

 // generate static image url
 $.fn.fancyPhotoset.urlFor = function(photo, options) {
   var url   = 'http://farm{farm}.static.flickr.com/{server}/{id}_{secret}{size}.{format}';
   var opts  = $.extend({size: 'square', format: 'jpg'}, options);
   var sizes = {
     'small'     : '_m',
     'original'  : '_o',
     'medium'    : '',
     'large'     : '_b',
     'thumbnail' : '_t',
     'square'    : '_s'
   };

   return url.replace(/\{\w+\}/g, function(match) {
     match = match.replace(/\{|\}/g, '');
     switch (match) {
       case 'size':
        return sizes[opts.size];
        break;
       case 'format':
        return opts.format;
        break;
       default:
        return photo[match];
     }
   });
 };

 // default options
 $.fn.fancyPhotoset.defaults = {
   apiKey     : '',
   photosetId : '',
   small      : 'square',
   large      : 'medium',
   captions   : true,
   firstOnly  : false
 };
})(jQuery);