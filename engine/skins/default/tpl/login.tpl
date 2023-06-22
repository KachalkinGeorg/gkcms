<!DOCTYPE html>
<html lang="{{ lang['langcode'] }}">

<head>
	<meta charset="{{ lang['encoding'] }}">
	<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
	<title>{{ home_title }} - {{ lang['admin_panel'] }}</title>

	<link href="{{ skins_url }}/public/css/login.css" rel="stylesheet">

	<script src="{{ skins_url }}/public/js/manifest.js"></script>
	<script src="{{ skins_url }}/public/js/vendor.js"></script>
	<script src="{{ skins_url }}/public/js/login.js"></script>
</head>

<body>
	<div class="container">
		<div class="row">
			<div class="col-12 col-md-6 col-lg-4 mx-auto mt-5">
				<div class="card">
					<form name="login" method="post" action="{{ php_self }}">
						<input type="hidden" name="redirect" value="{{ redirect }}">
						<input type="hidden" name="action" value="login">

						<h5 class="card-header text-center">
							{{ lang['admin_panel'] }}
						</h5>

						<div class="card-body">
							<div class="form-group">
								<div class="input-group mb-3">
									<div class="input-group-prepend input-group-append">
										<label class="input-group-text"><i class="fa fa-user text-muted"></i></label>
									</div>
									<input id="username" name="username" type="text" placeholder="{{ lang['name'] }}..." class="form-control" required>
								</div>
							</div>

							<div class="form-group mb-5">
								<div class="input-group mb-3">
									<div class="input-group-prepend input-group-append">
										<label class="input-group-text"><i class="fa fa-lock text-muted"></i></label>
									</div>
									<input id="password" name="password" type="password" placeholder="{{ lang['password'] }}..." class="form-control" required>
								</div>
							</div>

							<div class="form-group">
								<button type="submit" class="btn btn-success btn-block">{{ lang['login'] }} <i class="fa fa-sign-in"></i></button>
							</div>
						</div>

						<div class="card-footer">
							<div class="text-center text-muted">2008-{{ year }} © <a href="http://ngcms.ru" target="_blank">Next Generation CMS</a></div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>

</html>