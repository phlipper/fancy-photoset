# Fancy Photoset

The Fancy Photoset plugin utilizes the power of [jQuery](http://jquery.com) and [Fancybox](http://fancybox.net) to dynamically create photo galleries from your [Flickr](http://flickr.com) Photosets.


## Requirements

This plugin requires the latest version of the  [jQuery](http://jquery.com) library. It has been tested on 1.4.2 but should work on 1.3.2+.

This plugin depends on the [Fancybox](http://fancybox.net) plugin. It has been tested on version 1.3.1.

You will also need a [Flickr](http://flickr.com) account and a Flickr [API Key](http://www.flickr.com/services/api/misc.api_keys.html) to use this plugin.

## Usage

The `fancyPhotoset` method is called on a jQuery selector and takes an options hash as the only argument. A Flickr API Key and Photoset ID are the only required options.

Typical usage:

    <div id="gallery"></div>

    <script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
      // create a gallery with the default options
      $('#gallery').fancyPhotoset({apiKey: 'xxx', photosetId: 'xxx'});
    });
    </script>

The plugin supports multiple photoset galleries per page:

    <div id="gallery1"></div>
    <div id="gallery2"></div>

    <script type="text/javascript" charset="utf-8">
    $(document).ready(function() {
      // create a gallery with custom options
      var options1 = {
        apiKey: 'xxx',
        photosetId: 'xxx',
        captions: true,
        small: 'thumbnail',
        large: 'medium'
      };

      var options2 = {
        apiKey: 'xxx',
        photosetId: 'yyy',
        captions: false,
        small: 'square',
        large: 'original'
      };

      $('#gallery1').fancyPhotoset(options1);

      $('#gallery2').fancyPhotoset(options2);
    });
    </script>


### Options

* apiKey - Your Flickr API Key.
* photosetId - The ID of the photoset you want to load.
* small - The smaller thumbnail version of the image to show. This corresponds to one of the following Flickr sizes: square, thumbnail, small, medium and original.
* large - The larger version of the image link to and display in the Fancybox. This corresponds to one of the following Flickr sizes: square, thumbnail, small, medium and original.
* captions - true or false: This will create a <span class="caption"> with the photo title if set to true.
* firstOnly - true or false: Setting true will only display the first image in the photoset on the webpage. All images will still be available to the Fancybox gallery.

## Demo

See the demo.html file in the demo folder for an example of how to use the script. All you will need to run the demo is your API Key and a Photoset ID.

## Version

The current version is 0.3.0

## License

The Fancy Photoset plugin is dual licensed *(just like jQuery)* under the MIT (MIT\_LICENSE.txt) and GPL Version 2 (GPL\_LICENSE.txt) licenses.

Copyright (c) 2010 [Phil Cohen](http://phlippers.net)