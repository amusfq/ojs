{include file="frontend/components/header.tpl" pageTitle="user.login.resetPassword"}

<main class="thalibul-auth min-h-[calc(100vh-8rem)] bg-[#fff8fb] px-4 py-10 lg:px-12 lg:py-16">
	<div class="mx-auto grid max-w-5xl overflow-hidden border border-[#f4dce7] bg-white shadow-[0_20px_60px_rgba(157,57,83,.10)] lg:grid-cols-[.85fr_1.15fr]">
		<section class="relative hidden overflow-hidden bg-[#9d3953] p-10 text-white lg:flex lg:flex-col lg:justify-between">
			<div class="absolute -right-24 -top-24 h-72 w-72 rounded-full bg-[#f4a6c1]/40"></div>
			<div class="relative"><a href="{url page="index" router=$smarty.const.ROUTE_PAGE}" class="text-sm font-bold uppercase tracking-[.2em] text-white no-underline">{$currentContext->getLocalizedName()|escape}</a><p class="mt-20 max-w-xs text-4xl font-semibold leading-tight">Choose a new password.</p></div>
			<p class="relative max-w-xs text-sm leading-6 text-white/75">Create a secure password to continue using your journal account.</p>
		</section>
		<section class="p-6 sm:p-10">
			<div class="mb-8 lg:hidden"><a href="{url page="index" router=$smarty.const.ROUTE_PAGE}" class="text-sm font-bold uppercase tracking-[.2em] text-[#9d3953] no-underline">{$currentContext->getLocalizedName()|escape}</a></div>
			<p class="text-[10px] font-bold uppercase tracking-[.2em] text-[#9d3953]">Account recovery</p>
			<h1 class="mt-2 text-3xl font-semibold tracking-tight text-slate-900">{translate key="user.login.resetPassword"}</h1>
			<p class="mt-3 text-sm leading-6 text-slate-500">{translate key="user.login.passwordResetProcessInstructions"}</p>
			<form class="thalibul-auth-form mt-7" id="updateResetPassword" method="post" action="{url page="login" op="updateResetPassword"}">
				{csrf}
				{include file="common/formErrors.tpl"}
				{if !$passwordLengthRestrictionLocaleKey}{assign var="passwordLengthRestrictionLocaleKey" value="user.register.form.passwordLengthRestriction"}{/if}
				<div class="auth-field password"><label for="password"><span>{translate key="user.profile.newPassword"} <em>*</em></span><input type="password" name="password" id="password" value="{$password|default:""|escape}" maxlength="32" required autocomplete="new-password"></label><p class="mt-2 text-xs leading-5 text-slate-500">{translate key=$passwordLengthRestrictionLocaleKey length=$minPasswordLength}</p></div>
				<div class="auth-field password"><label for="password2"><span>{translate key="user.profile.repeatNewPassword"} <em>*</em></span><input type="password" name="password2" id="password2" value="{$password2|default:""|escape}" maxlength="32" required autocomplete="new-password"></label></div>
				<input type="hidden" name="username" value="{$username|escape}">
				<input type="hidden" name="hash" value="{$hash|escape}">
				<p class="mt-6 text-xs leading-6 text-slate-500">{capture assign="privacyUrl"}{url router=$smarty.const.ROUTE_PAGE page="about" op="privacy"}{/capture}{translate key="user.privacyLink" privacyUrl=$privacyUrl}</p>
				<p class="mt-3 text-xs text-slate-500"><em>*</em> {translate key="common.requiredField"}</p>
				<button class="auth-submit mt-6" type="submit">{translate key="common.save"}</button>
			</form>
		</section>
	</div>
</main>

<script>
document.addEventListener('DOMContentLoaded', () => {
	const form = document.getElementById('updateResetPassword');
	const button = form?.querySelector('button[type="submit"]');
	if (!form || !button) return;
	form.addEventListener('submit', () => {
		button.disabled = true;
		button.setAttribute('aria-busy', 'true');
		button.innerHTML = '<span class="register-spinner" aria-hidden="true"></span> Saving...';
	});
});
</script>

{include file="frontend/components/footer.tpl"}
