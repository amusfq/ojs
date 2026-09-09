{include file="frontend/components/header.tpl"}

<main class="thalibul-auth min-h-[calc(100vh-8rem)] bg-[#fff8fb] px-4 py-10 lg:px-12 lg:py-16">
	<div class="mx-auto max-w-md border border-[#f4dce7] bg-white p-6 text-center shadow-[0_20px_60px_rgba(157,57,83,.10)] sm:p-10">
		<div class="register-success-icon" aria-hidden="true">✓</div>
		<p class="mt-6 text-[10px] font-bold uppercase tracking-[.2em] text-[#9d3953]">Registration complete</p>
		<h1 class="mt-2 text-3xl font-semibold tracking-tight text-slate-900">{translate key=$pageTitle}</h1>
		<p class="mt-4 text-sm leading-6 text-slate-500">{translate key="user.login.registrationComplete.instructions"}</p>
		<div class="mt-8 flex flex-col gap-3 text-left">
			{if array_intersect(array(PKP\security\Role::ROLE_ID_MANAGER, PKP\security\Role::ROLE_ID_SUB_EDITOR, PKP\security\Role::ROLE_ID_ASSISTANT, PKP\security\Role::ROLE_ID_REVIEWER), (array)$userRoles)}
				<a class="auth-submit text-center no-underline" href="{url page="submissions"}">{translate key="user.login.registrationComplete.manageSubmissions"}</a>
			{/if}
			{if $currentContext}<a class="auth-submit text-center no-underline" href="{url page="submission"}">{translate key="user.login.registrationComplete.newSubmission"}</a>{/if}
			<a class="register-step-button text-center no-underline" href="{url router=PKP\core\PKPApplication::ROUTE_PAGE page="user" op="profile"}">{translate key="user.editMyProfile"}</a>
			<a class="register-step-button text-center no-underline" href="{url page="index"}">{translate key="user.login.registrationComplete.continueBrowsing"}</a>
		</div>
	</div>
</main>

{include file="frontend/components/footer.tpl"}
