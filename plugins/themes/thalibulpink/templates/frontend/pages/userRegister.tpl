{include file="frontend/components/header.tpl" pageTitle="user.register"}
{assign var="siteContextId" value=PKP\core\PKPApplication::SITE_CONTEXT_ID|intval}

<main class="thalibul-auth min-h-[calc(100vh-8rem)] bg-[#fff8fb] px-4 py-10 lg:px-12 lg:py-16">
	<div class="mx-auto grid max-w-5xl overflow-hidden border border-[#f4dce7] bg-white shadow-[0_20px_60px_rgba(157,57,83,.10)] lg:grid-cols-[.85fr_1.15fr]">
		<section class="relative hidden overflow-hidden bg-[#9d3953] p-10 text-white lg:flex lg:flex-col lg:justify-between">
			<div class="absolute -right-24 -top-24 h-72 w-72 rounded-full bg-[#f4a6c1]/40"></div>
			<div class="relative"><a href="{url page="index" router=$smarty.const.ROUTE_PAGE}" class="text-sm font-bold uppercase tracking-[.2em] text-white no-underline">{$currentContext->getLocalizedName()|escape}</a><p class="mt-20 max-w-xs text-4xl font-semibold leading-tight">Join a community of researchers.</p></div>
			<p class="relative max-w-xs text-sm leading-6 text-white/75">Create your account to submit work, review articles, and stay connected to the journal.</p>
		</section>
		<section class="p-6 sm:p-10">
		<div class="max-w-2xl"><a href="{url page="index" router=$smarty.const.ROUTE_PAGE}" class="text-sm font-bold uppercase tracking-[.2em] text-[#9d3953] no-underline">{$currentContext->getLocalizedName()|escape}</a><p class="mt-10 text-[10px] font-bold uppercase tracking-[.2em] text-[#9d3953]">Join the journal</p><h1 class="mt-2 text-3xl font-semibold tracking-tight text-slate-900">{translate key="user.register"}</h1><p class="mt-3 text-sm leading-6 text-slate-500">Create an account to submit, review, and follow scholarly work.</p></div>
		<form class="thalibul-auth-form register mt-8" id="register" method="post" action="{url op="register"}" role="form" novalidate>
			{if $orcidEnabled}{include file="form/orcidProfile.tpl"}{/if}
			{csrf}
			{if $source}<input type="hidden" name="source" value="{$source|escape}" />{/if}
			{include file="common/formErrors.tpl"}
			<div class="register-step-fields" data-register-fields>
			{include file="frontend/components/registrationForm.tpl"}
			{if $currentContext}
				<fieldset class="auth-options"><legend>{translate key="user.register.form.privacyConsentLabel"}</legend>
					{if $currentContext->getData('privacyStatement')}<label class="auth-check"><input type="checkbox" name="privacyConsent" value="1"{if $privacyConsent} checked="checked"{/if}>{capture assign="privacyUrl"}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}{/capture}<span>{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}</span></label>{/if}
					<label class="auth-check"><input type="checkbox" name="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}><span>{translate key="user.register.form.emailConsent"}</span></label>
				</fieldset>
				{assign var=contextId value=$currentContext->getId()}{assign var=userCanRegisterReviewer value=0}{foreach from=$reviewerUserGroups[$contextId] item=userGroup}{if $userGroup->permitSelfRegistration}{assign var=userCanRegisterReviewer value=$userCanRegisterReviewer+1}{/if}{/foreach}
				{if $userCanRegisterReviewer}<fieldset class="auth-options"><legend>{translate key="user.reviewerPrompt"}</legend><div class="auth-checks">{foreach from=$reviewerUserGroups[$contextId] item=userGroup}{if $userGroup->permitSelfRegistration}{assign var="userGroupId" value=$userGroup->id}<label class="auth-check"><input type="checkbox" name="reviewerGroup[{$userGroupId}]" value="1"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}><span>{translate key="user.reviewerPrompt.optin"}</span></label>{/if}{/foreach}</div><div class="auth-field"><label for="interests"><span>{translate key="user.interests"}</span><input type="text" name="interests" id="interests" value="{$interests|default:""|escape}"></label></div></fieldset>{/if}
			{else}
				{include file="frontend/components/registrationFormContexts.tpl"}
				<div class="auth-field"><label for="interests"><span>{translate key="user.register.noContextReviewerInterests"}</span><input type="text" name="interests" id="interests" value="{$interests|default:""|escape}"></label></div>
				{if $siteWidePrivacyStatement}<label class="auth-check"><input type="checkbox" name="privacyConsent[{$siteContextId}]" value="1"{if $privacyConsent[$siteContextId]} checked="checked"{/if}>{capture assign="privacyUrl"}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}{/capture}<span>{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}</span></label>{/if}
				<label class="auth-check"><input type="checkbox" name="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}><span>{translate key="user.register.form.emailConsent"}</span></label>
			{/if}
			{if $currentContext}{include file="frontend/components/registrationFormContexts.tpl"}{/if}
			</div>
			<div data-register-verification>{if $recaptchaPublicKey}<div class="mt-5"><div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey|escape}"></div><label for="g-recaptcha-response" hidden>Recaptcha response</label></div>{/if}{if $altchaEnabled}<div class="mt-5"><altcha-widget challengejson='{$altchaChallenge|@json_encode}' floating></altcha-widget></div>{/if}</div>
			<div class="register-step-nav" data-register-nav></div>
			<div class="register-submit-actions mt-8 flex flex-wrap items-center gap-4"><button class="auth-submit" type="submit">{translate key="user.register"}</button></div>
		</form>
		</section>
	</div>
</main>

<div id="register-confirm-modal" class="register-confirm-modal" hidden role="dialog" aria-modal="true" aria-labelledby="register-confirm-title">
	<div class="register-confirm-card">
		<p class="register-step-count">Almost there</p>
		<h2 id="register-confirm-title">Create your account?</h2>
		<p>Please confirm that you want to submit this registration.</p>
		<div class="register-confirm-actions"><button type="button" class="register-step-button" data-register-cancel>Cancel</button><button type="button" class="register-step-button register-step-next" data-register-confirm>Register</button></div>
	</div>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
	const form = document.getElementById('register');
	const fields = form?.querySelector('[data-register-fields]');
	const nav = form?.querySelector('[data-register-nav]');
	if (!form || !fields || !nav) return;
	const nodes = [...fields.children];
	const groups = [nodes.slice(0, 1), nodes.slice(1, 2), nodes.slice(2)];
	const titles = ['Profile', 'Account', 'Preferences'];
	const steps = groups.map((group, index) => {
		const step = document.createElement('section');
		step.className = 'register-step';
		step.innerHTML = '<p class="register-step-count">Step ' + (index + 1) + ' of ' + groups.length + '</p><h2 class="register-step-title">' + titles[index] + '</h2>';
		group.forEach((node) => step.appendChild(node));
		if (index === 0) step.insertAdjacentHTML('beforeend', '<p class="register-login-hint">Already have an account? <a href="{url page="login"}">Log in</a></p>');
		fields.appendChild(step);
		return step;
	});
		let current = 0;
		const submit = form.querySelector('.register-submit-actions');
		const submitButton = submit?.querySelector('button[type="submit"]');
		const verification = form.querySelector('[data-register-verification]');
		const render = () => {
			steps.forEach((step, index) => { step.hidden = index !== current; });
			if (submitButton && submitButton.parentElement !== submit) submit.append(submitButton);
			nav.innerHTML = (current > 0 ? '<button type="button" class="register-step-button register-step-prev">Back</button>' : '') + (current < steps.length - 1 ? '<button type="button" class="register-step-button register-step-next">Continue</button>' : '');
			if (submit) submit.style.display = 'none';
			if (current === steps.length - 1 && submitButton) { submitButton.className = 'register-step-button register-step-next auth-submit'; nav.append(submitButton); }
			if (verification) verification.hidden = current !== steps.length - 1;
		nav.querySelector('.register-step-prev')?.addEventListener('click', () => { current -= 1; render(); });
		nav.querySelector('button[type="button"].register-step-next')?.addEventListener('click', async () => { const valid = window.thalibulRegisterValidate ? await window.thalibulRegisterValidate(steps[current]) : [...steps[current].querySelectorAll('input, select, textarea')].every((input) => input.checkValidity()); if (!valid) return; current += 1; render(); });
	};
	render();
});
</script>

{include file="frontend/components/footer.tpl"}
