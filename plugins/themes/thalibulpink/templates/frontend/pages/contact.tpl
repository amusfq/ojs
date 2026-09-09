{include file="frontend/components/header.tpl" pageTitle="about.contact"}

<main class="thalibul-contact min-h-[calc(100vh-8rem)] bg-[#fff8fb] px-4 py-10 lg:px-12 lg:py-16">
	<div class="mx-auto max-w-5xl">
		<nav class="mb-8 flex items-center gap-2 text-[10px] font-bold uppercase tracking-[.16em] text-slate-400"><a class="text-[#9d3953] no-underline" href="{url page="index" router=$smarty.const.ROUTE_PAGE}">Home</a><span>/</span><span>{translate key="about.contact"}</span></nav>
		<section class="contact-hero"><div><p class="text-[10px] font-bold uppercase tracking-[.2em] text-[#9d3953]">Editorial office</p><h1 class="mt-2 text-4xl font-semibold tracking-tight text-slate-900 lg:text-5xl">{translate key="about.contact"}</h1><p class="mt-4 max-w-2xl text-base leading-7 text-slate-600">Connect with {$currentContext->getLocalizedName()|escape} for editorial, submission, and technical questions.</p></div><div class="contact-hero-mark" aria-hidden="true">@</div></section>
		<div class="contact-grid">
			<section class="contact-main">
				{if $mailingAddress}<article class="contact-card"><div class="contact-card-heading"><span>01</span><h2>Mailing address</h2></div><address>{$mailingAddress|nl2br|strip_unsafe_html}</address></article>{/if}
			{if $contactTitle || $contactName || $contactAffiliation || $contactPhone || $contactEmail}<article class="contact-card"><div class="contact-card-heading"><span>02</span><h2>{translate key="about.contact.principalContact"}</h2></div>{if $contactName}<p class="contact-name">{$contactName|escape}</p>{/if}{if $contactTitle}<p class="contact-meta">{$contactTitle|escape}</p>{/if}{if $contactAffiliation}<p class="contact-meta">{$contactAffiliation|strip_unsafe_html}</p>{/if}{if $contactPhone}<p class="contact-detail"><strong>{translate key="about.contact.phone"}</strong>{$contactPhone|escape}</p>{/if}{if $contactEmail}<p class="contact-detail"><strong>Email</strong><span>{mailto address=$contactEmail encode='javascript'}</span></p>{/if}</article>{/if}
			{if $supportName || $supportPhone || $supportEmail}<article class="contact-card"><div class="contact-card-heading"><span>03</span><h2>{translate key="about.contact.supportContact"}</h2></div>{if $supportName}<p class="contact-name">{$supportName|escape}</p>{/if}{if $supportPhone}<p class="contact-detail"><strong>{translate key="about.contact.phone"}</strong>{$supportPhone|escape}</p>{/if}{if $supportEmail}<p class="contact-detail"><strong>Email</strong><span>{mailto address=$supportEmail encode='javascript'}</span></p>{/if}</article>{/if}
			{if !$mailingAddress && !$contactTitle && !$contactName && !$contactAffiliation && !$contactPhone && !$contactEmail && !$supportName && !$supportPhone && !$supportEmail}<article class="contact-card"><p class="contact-meta">Contact details have not been published yet.</p></article>{/if}
			</section>
			<aside class="contact-sidebar"><div class="contact-side-card"><p class="contact-eyebrow">How can we help?</p><h2>Choose the right contact</h2><ul><li><strong>Editorial questions</strong><span>Ask about peer review, decisions, and publication.</span></li><li><strong>Submission support</strong><span>Get help with your account or online submission.</span></li><li><strong>Technical support</strong><span>Report problems accessing the journal website.</span></li></ul></div><div class="contact-side-card contact-side-card-soft"><p class="contact-eyebrow">Author portal</p><h2>Ready to submit?</h2><p>Review the requirements before starting your submission.</p><a class="contact-link" href="{url page="about" op="submissions"}">View submission guidelines <span aria-hidden="true">→</span></a></div></aside>
		</div>
	</div>
</main>

{include file="frontend/components/footer.tpl"}
