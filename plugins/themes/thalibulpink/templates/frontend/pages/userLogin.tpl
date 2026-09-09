{include file="frontend/components/header.tpl" pageTitle="user.login"}

<main class="thalibul-auth min-h-[calc(100vh-8rem)] bg-[#fff8fb] px-4 py-10 lg:px-12 lg:py-16">
	<div class="mx-auto grid max-w-5xl overflow-hidden border border-[#f4dce7] bg-white shadow-[0_20px_60px_rgba(157,57,83,.10)] lg:grid-cols-[.85fr_1.15fr]">
		<section class="relative hidden overflow-hidden bg-[#9d3953] p-10 text-white lg:flex lg:flex-col lg:justify-between">
			<div class="absolute -right-24 -top-24 h-72 w-72 rounded-full bg-[#f4a6c1]/40"></div>
			<div class="relative">
				<a href="{url page="index" router=$smarty.const.ROUTE_PAGE}" class="text-sm font-bold uppercase tracking-[.2em] text-white no-underline">{$currentContext->getLocalizedName()|escape}</a>
				<p class="mt-20 max-w-xs text-4xl font-semibold leading-tight">Continue your research journey.</p>
			</div>
			<p class="relative max-w-xs text-sm leading-6 text-white/75">Access submissions, saved articles, and your journal account from one place.</p>
		</section>
		<section class="p-6 sm:p-10">
			<div class="mb-8 lg:hidden"><a href="{url page="index" router=$smarty.const.ROUTE_PAGE}" class="text-sm font-bold uppercase tracking-[.2em] text-[#9d3953] no-underline">{$currentContext->getLocalizedName()|escape}</a></div>
			<p class="text-[10px] font-bold uppercase tracking-[.2em] text-[#9d3953]">Welcome back</p>
			<h1 class="mt-2 text-3xl font-semibold tracking-tight text-slate-900">{translate key="user.login"}</h1>
			<p class="mt-3 text-sm leading-6 text-slate-500">Sign in to manage your submissions and profile.</p>
			{if $loginMessage}<div class="mt-5 border border-[#f4a6c1] bg-[#fff1f6] p-3 text-sm text-[#81233e]">{translate key=$loginMessage}</div>{/if}
			<form class="thalibul-auth-form mt-7" id="login" method="post" action="{$loginUrl}" role="form">
				{csrf}
				{if $error}<div class="mb-5 border border-red-200 bg-red-50 p-3 text-sm text-red-700">{translate key=$error reason=$reason}</div>{/if}
				<input type="hidden" name="source" value="{$source|default:""|escape}" />
				<div class="auth-field"><label for="username"><span>{translate key="user.usernameOrEmail"} <em>*</em></span><input type="text" name="username" id="username" value="{$username|default:""|escape}" required autocomplete="username"></label></div>
				<div class="auth-field"><label for="password"><span>{translate key="user.password"} <em>*</em></span><input type="password" name="password" id="password" maxlength="32" required autocomplete="current-password"></label><a class="auth-help" href="{url page="login" op="lostPassword"}">{translate key="user.login.forgotPassword"}</a></div>
				<label class="auth-check"><input type="checkbox" name="remember" id="remember" value="1" checked="$remember"><span>{translate key="user.login.rememberUsernameAndPassword"}</span></label>
				{if $recaptchaPublicKey}<div class="mt-5"><div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey|escape}"></div><label for="g-recaptcha-response" hidden>Recaptcha response</label></div>{/if}
				{if $altchaEnabled}<div class="mt-5"><altcha-widget challengejson='{$altchaChallenge|@json_encode}' floating></altcha-widget></div>{/if}
				<button class="auth-submit" type="submit">{translate key="user.login"}</button>
				{if !$disableUserReg}<p class="mt-6 text-center text-sm text-slate-500">{translate key="user.login.registerNewAccount"} <a class="font-semibold text-[#9d3953] no-underline hover:underline" href="{url page="user" op="register" source=$source}">Create account</a></p>{/if}
			</form>
		</section>
	</div>
</main>

<script>
document.addEventListener('DOMContentLoaded', () => {
	const form = document.getElementById('login');
	const button = form?.querySelector('button[type="submit"]');
	if (!form || !button) return;
	form.addEventListener('submit', () => {
		button.disabled = true;
		button.setAttribute('aria-busy', 'true');
		button.innerHTML = '<span class="register-spinner" aria-hidden="true"></span> Signing in...';
	});
});
</script>

{include file="frontend/components/footer.tpl"}
