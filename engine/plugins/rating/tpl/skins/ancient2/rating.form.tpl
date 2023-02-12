<div id="ratingdiv_{{ item }}_{{ itemID }}" class="ani-rating">
	<script>
		var ajax = new sack();
		function rating(rating, item, itemID){
			ngShowLoading();
			ajax.onShow('');
			ajax.setVar('rating', rating);
			ajax.setVar('item', item);
			ajax.setVar('itemID', itemID);
			ajax.requestFile = '{{ ajax_url }}';
			ajax.method = 'GET';
			ajax.element = 'ratingdiv_'+item+'_'+itemID;
			ajax.onComplete = function () {
				ngHideLoading();
			}
			ajax.runAJAX();
			
		}
	</script>
	<div style="float:left;" class="rating">
		<ul class="uRating">
		<li class="r{{ rating }}">{{ rating }}</li>
			<li><a href="#" title="{{ lang['rating_1'] }}" class="r1u" onclick="rating('1', '{{ item }}', '{{ itemID }}'); return false;"></a></li>
			<li><a href="#" title="{{ lang['rating_2'] }}" class="r2u" onclick="rating('2', '{{ item }}', '{{ itemID }}'); return false;"></a></li>
			<li><a href="#" title="{{ lang['rating_3'] }}" class="r3u" onclick="rating('3', '{{ item }}', '{{ itemID }}'); return false;"></a></li>
			<li><a href="#" title="{{ lang['rating_4'] }}" class="r4u" onclick="rating('4', '{{ item }}', '{{ itemID }}'); return false;"></a></li>
			<li><a href="#" title="{{ lang['rating_5'] }}" class="r5u" onclick="rating('5', '{{ item }}', '{{ itemID }}'); return false;"></a></li>
		</ul>
	</div>
<!-- 	<div class="uRating_num"><a title="{{ lang['rating_votes'] }} {{ votes }}" class="uRating_res">(&nbsp;{{ votes }}&nbsp;)</a></div> -->
</div>