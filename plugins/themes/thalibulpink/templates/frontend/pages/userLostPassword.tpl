{include file="frontend/components/header.tpl" pageTitle="user.login.resetPassword"}

<main class="thalibul-auth min-h-[calc(100vh-8rem)] bg-[#fff8fb] px-4 py-10 lg:px-12 lg:py-16">
	<div class="mx-auto grid max-w-5xl overflow-hidden border border-[#f4dce7] bg-white shadow-[0_20px_60px_rgba(157,57,83,.10)] lg:grid-cols-[.85fr_1.15fr]">
		<section class="relative hidden overflow-hidden bg-[#9d3953] p-10 text-white lg:flex lg:flex-col lg:justify-between">
			<div class="absolute -right-24 -top-24 h-72 w-72 rounded-full bg-[#f4a6c1]/40"></div>
			<div class="relative"><a href="{url page="index" router=$smarty.const.ROUTE_PAGE}" class="text-sm font-bold uppercase tracking-[.2em] text-white no-underline">{$currentContext->getLocalizedName()|escape}</a><p class="mt-20 max-w-xs text-4xl font-semibold leading-tight">Get back to your research journey.</p></div>
			<p class="relative max-w-xs text-sm leading-6 text-white/75">Enter your registered email and we’ll send instructions to reset your password.</p>
		</section>
		<section class="p-6 sm:p-10">
			<div class="mb-8 lg:hidden"><a href="{url page="index" router=$smarty.const.ROUTE_PAGE}" class="text-sm font-bold uppercase tracking-[.2em] text-[#9d3953] no-underline">{$currentContext->getLocalizedName()|escape}</a></div>
			<p class="text-[10px] font-bold uppercase tracking-[.2em] text-[#9d3953]">Account recovery</p>
			<h1 class="mt-2 text-3xl font-semibold tracking-tight text-slate-900">{translate key="user.login.resetPassword"}</h1>
			<p class="mt-3 text-sm leading-6 text-slate-500">{translate key="user.login.resetPasswordInstructions"}</p>
			<form class="thalibul-auth-form mt-7" id="lostPasswordForm" action="{url page="login" op="requestResetPassword"}" method="post" role="form">
				{csrf}
				{if $error}<div class="mb-5 border border-red-200 bg-red-50 p-3 text-sm text-red-700">{translate key=$error reason=$reason}</div>{/if}
				<div class="auth-field"><label for="email"><span>{translate key="user.login.registeredEmail"} <em>*</em></span><input type="email" name="email" id="email" value="{$email|escape}" required aria-required="true" autocomplete="email"></label></div>
				{if $recaptchaPublicKey}<div class="mt-5"><div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey|escape}"></div><label for="g-recaptcha-response" hidden>Recaptcha response</label></div>{/if}
				{if $altchaEnabled}<div class="mt-5"><altcha-widget challengejson='{$altchaChallenge|@json_encode}' floating></altcha-widget></div>{/if}
				<button class="auth-submit mt-6" type="submit">{translate key="user.login.resetPassword"}</button>
				<p class="mt-6 text-center text-sm text-slate-500"><a class="font-semibold text-[#9d3953] no-underline hover:underline" href="{url page="login"}">Back to login</a></p>
			</form>
		</section>
	</div>
</main>

<script>
document.addEventListener('DOMContentLoaded', () => {
	const form = document.getElementById('lostPasswordForm');
	const button = form?.querySelector('button[type="submit"]');
	if (!form || !button) return;
	form.addEventListener('submit', () => {
		button.disabled = true;
		button.setAttribute('aria-busy', 'true');
		button.innerHTML = '<span class="register-spinner" aria-hidden="true"></span> Sending...';
	});
});
</script>

{include file="frontend/components/footer.tpl"}
