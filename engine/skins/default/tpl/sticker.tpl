<script>$(function() {$.notify({title: '{{title}}',message: '{{message}} {{info}}',},{type: '{{type}}',});});</script>
 <noscript><div id="alert-{{ id }}" class="alert alert-{{type}} alert-dismissible"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button><b>{{title}}</b>{{message}}</div>
 </noscript>