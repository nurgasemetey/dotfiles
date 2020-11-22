const json2md = require("json2md")
var moment = require('moment');
var fs = require('fs-extra');

$(() => {

  $('#save').bind('click', function() {
    console.log($('#code').val());
    var docArray = [
      {
        h3: $('#title').val()
      },
      {
        p: $('#link').val() 
      },
      {
        p: $('#description').val() 
      },
      {
        code: {
          language: $('#language').val(),
          content: [
            $('#code').val()
          ]
        } 
      }
    ]
    var mdContent = json2md(docArray); 
    console.log(mdContent);
    var filename = `/mnt/fd68f224-e30e-4ea0-8bd8-7f2a4c4d5ab0/nurgasemetey-environment/personal-notes/wiki-overviews/${moment().format('YYYY-MM-DD')}/${$('#title').val()}.md`;
    fs.outputFile(filename, mdContent, (err) => {
      if (err) console.log(err);
      console.log("Successfully Written to File.");
    });
  });

  $('#clear').bind('click', function() {
    $('#title').val('');
    $('#link').val('');
    $('#description').val('');
    $('#language').val('');
    $('#code').val('');
  });
  jQuery.fn.extend({
    autoHeight: function () {
      function autoHeight_(element) {
        return jQuery(element).css({
          'height': 'auto',
          'overflow-y': 'hidden'
        }).height(element.scrollHeight);
      }
      return this.each(function () {
        autoHeight_(this).on('input', function () {
          autoHeight_(this);
        });
      });
    }
  });
  $('#code').autoHeight();
})
