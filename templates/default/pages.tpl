<center><div class="dpad basenavi">
	<div class="bnnavi">
		<div class="navigation paginator">
		{% if (flags.previous_page) %}
			{{ previous_page }}
		{% endif %}

		{{ pages }}

		{% if (flags.next_page) %}
			{{ next_page }}
		{% endif %} 
        </div>
	</div>
</div></center>