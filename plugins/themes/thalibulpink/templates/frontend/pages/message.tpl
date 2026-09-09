{include file="frontend/components/header.tpl"}

<main class="thalibul-auth min-h-[calc(100vh-8rem)] bg-[#fff8fb] px-4 py-10 lg:px-12 lg:py-16">
	<div class="mx-auto grid max-w-5xl overflow-hidden border border-[#f4dce7] bg-white shadow-[0_20px_60px_rgba(157,57,83,.10)] lg:grid-cols-[.85fr_1.15fr]">
		<section class="relative hidden overflow-hidden bg-[#9d3953] p-10 text-white lg:flex lg:flex-col lg:justify-between">
			<div class="absolute -right-24 -top-24 h-72 w-72 rounded-full bg-[#f4a6c1]/40"></div>
			<div class="relative"><a href="{url page="index" router=$smarty.const.ROUTE_PAGE}" class="text-sm font-bold uppercase tracking-[.2em] text-white no-underline">{$currentContext->getLocalizedName()|escape}</a><p class="mt-20 max-w-xs text-4xl font-semibold leading-tight">Your account is almost back in reach.</p></div>
			<p class="relative max-w-xs text-sm leading-6 text-white/75">Follow the instructions in your email to continue securely.</p>
		</section>
		<section class="p-6 sm:p-10">
			<div class="mb-8 lg:hidden"><a href="{url page="index" router=$smarty.const.ROUTE_PAGE}" class="text-sm font-bold uppercase tracking-[.2em] text-[#9d3953] no-underline">{$currentContext->getLocalizedName()|escape}</a></div>
			<div class="grid h-14 w-14 place-items-center rounded-full bg-[#fff1f6] text-2xl text-[#9d3953]" aria-hidden="true">✓</div>
			<p class="mt-7 text-[10px] font-bold uppercase tracking-[.2em] text-[#9d3953]">Account recovery</p>
			<h1 class="mt-2 text-3xl font-semibold tracking-tight text-slate-900">{translate key=$pageTitle}</h1>
			<div class="mt-4 text-sm leading-7 text-slate-600">{if $messageTranslated}{$messageTranslated}{else}{translate key=$message}{/if}</div>
			{if $backLink}<a class="mt-8 inline-flex bg-[#9d3953] px-5 py-3 text-[10px] font-bold uppercase tracking-wider text-white no-underline hover:bg-[#81233e]" href="{$backLink}">{translate key=$backLinkLabel}</a>{/if}
		</section>
	</div>
</main>

{include file="frontend/components/footer.tpl"}
