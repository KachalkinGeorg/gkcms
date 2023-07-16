/*
* Project: Bootstrap Notify = v3.1.5
* Description: Turns standard Bootstrap alerts into "Growl-like" notifications.
* Author: Mouse0270 aka Robert McIntosh
* License: MIT License
* Website: https://github.com/mouse0270/bootstrap-growl
*/
!function(t){"function"==typeof define&&define.amd?define(["jquery"],t):t("object"==typeof exports?require("jquery"):jQuery)}(function(t){function e(e,s,n){var a={content:{message:"object"==typeof s?s.message:s,title:s.title?s.title:""}};n=t.extend(!0,{},a,n),this.settings=t.extend(!0,{},i,n),this._defaults=i,this.animations={start:"webkitAnimationStart oanimationstart MSAnimationStart animationstart",end:"webkitAnimationEnd oanimationend MSAnimationEnd animationend"},"number"==typeof this.settings.offset&&(this.settings.offset={x:this.settings.offset,y:this.settings.offset}),this.init()}var i={element:"body",type:"info",offset:{x:15,y:66},spacing:15,z_index:1031,delay:5000,timer:1000,template:'<div data-notify="container" class="col-xs-11 col-sm-4 alert alert-{0}" role="alert"><button type="button" aria-hidden="true" class="close" data-notify="dismiss">&times;</button><span data-notify="icon"></span><span data-notify="title">{1}</span><span data-notify="message">{2}</span></div>'};String.format=function(){var t=arguments;return arguments[0].replace(/(\{\{\d\}\}|\{\d\})/g,function(e){if("{{"===e.substring(0,2))return e;var i=parseInt(e.match(/\d/)[0]);return t[i+1]})},t.extend(e.prototype,{init:function(){var t=this;this.buildNotify(),this.styleDismiss(),this.placement(),this.bind(),this.notify={$ele:this.$ele,update:function(e,i){var s={};"string"==typeof e?s[e]=i:s=e;for(var n in s)switch(n){case"type":this.$ele.removeClass("alert-"+t.settings.type),t.settings.type=s[n],this.$ele.addClass("alert-"+s[n]);break;default:this.$ele.find('[data-notify="'+n+'"]').html(s[n])}var a=this.$ele.outerHeight()+parseInt(t.settings.spacing)+parseInt(t.settings.offset.y);t.reposition(a)},close:function(){t.close()}}},buildNotify:function(){var e=this.settings.content;this.$ele=t(String.format(this.settings.template,this.settings.type,e.title,e.message)),this.$ele.attr("data-notify-position","top-right")},styleDismiss:function(){this.$ele.find('[data-notify="dismiss"]').css({position:"absolute",right:"10px",top:"5px",zIndex:this.settings.z_index+2})},placement:function(){var e=this,i=this.settings.offset.y,s={display:"inline-block",margin:"0px auto",position:"fixed",transition:"all .5s ease-in-out",zIndex:this.settings.z_index},n=this.settings;t('[data-notify-position="top-right"]:not([data-closing="true"])').each(function(){i=Math.max(i,parseInt(t(this).css("top"))+parseInt(t(this).outerHeight())+parseInt(n.spacing))}),s.top=i+"px",s.right=this.settings.offset.x+"px",this.$ele.css(s).addClass("animated fadeInDown"),t.each(Array("webkit-","moz-","o-","ms-",""),function(t,i){e.$ele[0].style[i+"AnimationIterationCount"]=1}),t(this.settings.element).append(this.$ele),this.$ele.one(this.animations.end,function(){e.$ele.removeClass("animated fadeInDown")})},bind:function(){var e=this;if(this.$ele.find('[data-notify="dismiss"]').on("click",function(){e.close()}),this.$ele.mouseover(function(){t(this).data("data-hover","true")}).mouseout(function(){t(this).data("data-hover","false")}),this.$ele.data("data-hover","false"),this.settings.delay>0){e.$ele.data("notify-delay",e.settings.delay);var i=setInterval(function(){var t=parseInt(e.$ele.data("notify-delay"))-e.settings.timer;e.$ele.data("notify-delay",t),t<=-e.settings.timer&&(clearInterval(i),e.close())},e.settings.timer)}},close:function(){var e=this,i=parseInt(this.$ele.css("top"));this.$ele.attr("data-closing","true").addClass("animated fadeOutUp"),e.reposition(i),this.$ele.one(this.animations.end,function(){t(this).remove()})},reposition:function(e){var i=this;this.$ele.nextAll('[data-notify-position="top-right"]:not([data-closing="true"])').each(function(){t(this).css("top",e),e=parseInt(e)+parseInt(i.settings.spacing)+t(this).outerHeight()})}}),t.notify=function(t,i){return new e(this,t,i).notify}});