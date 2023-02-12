<script>
function fileChange(){
var file = document.getElementById('input_img');
var form = new FormData();
form.append("image", file.files[0])

 
var settings = {
  "url": "https://api.imgbb.com/1/upload?key={{ scrinkey }}&name={{ home }}_{{ alt_name }}",
  "method": "POST",
  "timeout": 0,
  "processData": false,
  "mimeType": "multipart/form-data",
  "contentType": false,
  "data": form
};
 
$.ajax(settings).done(function (response) {
  console.log(response);
  var jx = JSON.parse(response);
  $('textarea.form-scrin').val($.trim('[img='+jx.data.url+']{{ alt_name }}[/img]' + '\n' + $('textarea.form-scrin').val()));
  $('div.form-img').val($.trim('[img]'+jx.data.url+'[/img]' + '&nbsp;' + $('img.form-img').val()));
  document.getElementById("input_img").value = null;
 
});
 
}
</script>
