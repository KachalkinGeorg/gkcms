<script>
function onlineHintInit() {
    $(".ionline").mouseleave(function(){
        $("#ionline_vis").hide();
    });
    $(".ionline a").hover(function(){
        if(!($("#ionline_vis").is(":visible"))) {
            $("#ionline_vis").show();
        }
        var postop = $(this).position().top - 105;
        var posleft = $(this).position().right - 245;
        var uhint = $(this).attr('udata');
        var uhint = uhint.replace(/\[\[quot\]\]/g, '"');
        $("#ionline_vis").stop().html(uhint).animate({
            top:postop,
            left:posleft
        }, 'normal');
    });
}
$(function(){
    onlineHintInit();
});
var hidecomm = [], rateval = 0, oright = 0, otop = 0;
</script>
<div class="module">
	<div class="title">
		В СЕТИ - <text style="color: #6d6737;">{sum_count}</text>
		<span></span>
	</div>
	<div class="content">
		<div class="ionline">
		<div id="ionline_vis"></div>
		<center><i class="fa fa-users" title="Гости"></i> {guest_count} | <i class="fa fa-user-secret" title="Роботы"></i> {bot_count} | <i class="fa fa-user-circle-o" title="Пользователи"></i> {user_count}</center>
		<br />
		<text style="filter: alpha(opacity=70);color: #888 !important;font-weight: bold;opacity: .7;">Пользователи:</text> {online_user}<br />
		<text style="filter: alpha(opacity=70);color: #888 !important;font-weight: bold;opacity: .7;">Гости:</text> {online_guest}<br />
		<text style="filter: alpha(opacity=70);color: #888 !important;font-weight: bold;opacity: .7;">Роботы:</text> {online_bot}<br />
		</div>
	</div>
</div>