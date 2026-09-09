{capture assign="homeUrl"}{url page="index" router=$smarty.const.ROUTE_PAGE}{/capture}
{capture assign="searchUrl"}{url page="search"}{/capture}
{capture assign="archivesUrl"}{url page="issue" op="archive"}{/capture}
{capture assign="aboutUrl"}{url page="about"}{/capture}
{capture assign="aboutSubmissionsUrl"}{url page="about" op="submissions"}{/capture}
{capture assign="aboutContactUrl"}{url page="about" op="contact"}{/capture}
{capture assign="submissionUrl"}{url page="submission"}{/capture}
{capture assign="loginUrl"}{url page="login"}{/capture}
{capture assign="registerUrl"}{url page="user" op="register"}{/capture}
{capture assign="viewSubmissionsUrl"}{url page="submissions"}{/capture}
{capture assign="profileUrl"}{url page="user" op="profile"}{/capture}
{capture assign="dashboardUrl"}{url page="dashboard"}{/capture}
{capture assign="logoutUrl"}{url page="login" op="signOut"}{/capture}
{capture assign="notificationUrl"}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="notification" op="fetchNotification"}{/capture}
{capture assign="notificationMarkNewUrl"}{url router=PKP\core\PKPApplication::ROUTE_COMPONENT component="grid.notifications.NotificationsGridHandler" op="markNew"}{/capture}
{capture assign="notificationMarkReadUrl"}{url router=PKP\core\PKPApplication::ROUTE_COMPONENT component="grid.notifications.NotificationsGridHandler" op="markRead"}{/capture}
{capture assign="notificationDeleteUrl"}{url router=PKP\core\PKPApplication::ROUTE_COMPONENT component="grid.notifications.NotificationsGridHandler" op="deleteNotifications"}{/capture}
{assign var="logoUrl" value="{$baseUrl}/plugins/themes/thalibulpink/logo_small.png"}
{include file="frontend/components/header.tpl" pageTitle="about.submissions"}

<div id="thalibul-pink-navbar"></div>
<script type="application/json" id="thalibul-pink-navbar-data">
{ldelim}"journalName": {$currentContext->getLocalizedName()|json_encode nofilter}, "logo": {$logoUrl|json_encode nofilter}, "homeUrl": {$homeUrl|json_encode nofilter}, "searchUrl": {$searchUrl|json_encode nofilter}, "archivesUrl": {$archivesUrl|json_encode nofilter}, "aboutUrl": {$aboutUrl|json_encode nofilter}, "aboutSubmissionsUrl": {$aboutSubmissionsUrl|json_encode nofilter}, "aboutContactUrl": {$aboutContactUrl|json_encode nofilter}, "submissionsUrl": {$viewSubmissionsUrl|json_encode nofilter}, "loginUrl": {$loginUrl|json_encode nofilter}, "profileUrl": {$profileUrl|json_encode nofilter}, "dashboardUrl": {$dashboardUrl|json_encode nofilter}, "logoutUrl": {$logoutUrl|json_encode nofilter}, "loggedIn": {if $isUserLoggedIn}true{else}false{/if}, "notificationCount": {$unreadNotificationCount|default:0|intval}, "notificationUrl": {$notificationUrl|json_encode nofilter}, "notificationMarkNewUrl": {$notificationMarkNewUrl|json_encode nofilter}, "notificationMarkReadUrl": {$notificationMarkReadUrl|json_encode nofilter}, "notificationDeleteUrl": {$notificationDeleteUrl|json_encode nofilter}, "csrfToken": {csrf type="json"}, "username": {$loggedInUsername|default:''|json_encode nofilter}{rdelim}
</script>

<main class="thalibul-submissions min-h-[calc(100vh-8rem)] bg-[#fff8fb] px-4 py-10 lg:px-12 lg:py-16">
	<div class="mx-auto max-w-5xl">
		<nav class="mb-8 flex items-center gap-2 text-[10px] font-bold uppercase tracking-[.16em] text-slate-400"><a class="text-[#9d3953] no-underline" href="{$homeUrl}">Home</a><span>/</span><span>{translate key="about.submissions"}</span></nav>
		<section class="submission-hero">
			<div><p class="text-[10px] font-bold uppercase tracking-[.2em] text-[#9d3953]">Author portal</p><h1 class="mt-2 text-4xl font-semibold tracking-tight text-slate-900 lg:text-5xl">{translate key="about.submissions"}</h1><p class="mt-4 max-w-2xl text-base leading-7 text-slate-600">Prepare and submit your research to {$currentContext->getLocalizedName()|escape}. Registration is required to begin a submission and follow its progress.</p></div>
			<div class="submission-hero-mark" aria-hidden="true">✦</div>
		</section>

		{if $sections|@count == 0 || $currentContext->getData('disableSubmissions')}
			<div class="submission-notice submission-notice-muted">{translate key="author.submit.notAccepting"}</div>
		{elseif $isUserLoggedIn}
			<div class="submission-notice"><div><p class="submission-eyebrow">Ready when you are</p><h2>Start or manage a submission</h2><p>{capture assign="newSubmission"}<a href="{$submissionUrl}">{translate key="about.onlineSubmissions.newSubmission"}</a>{/capture}{capture assign="viewSubmissions"}<a href="{$viewSubmissionsUrl}">{translate key="about.onlineSubmissions.viewSubmissions"}</a>{/capture}{translate key="about.onlineSubmissions.submissionActions" newSubmission=$newSubmission viewSubmissions=$viewSubmissions}</p></div><a class="submission-primary" href="{$submissionUrl}">Make a submission</a></div>
		{else}
			<div class="submission-notice"><div><p class="submission-eyebrow">Account required</p><h2>Sign in to submit your work</h2><p>{capture assign="login"}<a href="{$loginUrl}">{translate key="about.onlineSubmissions.login"}</a>{/capture}{capture assign="register"}<a href="{$registerUrl}">{translate key="about.onlineSubmissions.register"}</a>{/capture}{translate key="about.onlineSubmissions.registrationRequired" login=$login register=$register}</p></div><a class="submission-primary" href="{$registerUrl}">Create account</a></div>
		{/if}

		<div class="submission-grid">
			<section class="submission-content">
				{if $currentContext->getLocalizedData('authorGuidelines')}<article class="submission-panel" id="authorGuidelines"><div class="submission-panel-heading"><span>01</span><h2>{translate key="about.authorGuidelines"}</h2></div>{$currentContext->getLocalizedData('authorGuidelines')}</article>{/if}
				{if $submissionChecklist}<article class="submission-panel"><div class="submission-panel-heading"><span>02</span><h2>{translate key="about.submissionPreparationChecklist"}</h2></div>{$submissionChecklist}</article>{/if}
				{foreach from=$sections item="section"}<article class="submission-panel">{if $section->getLocalizedPolicy()}<div class="submission-panel-heading"><span>03</span><h2>{$section->getLocalizedTitle()|escape}</h2></div>{$section->getLocalizedPolicy()}{if $isUserLoggedIn}{capture assign="sectionSubmissionUrl"}{url page="submission" sectionId=$section->getId()}{/capture}<div class="submission-action-row"><a class="submission-inline-link" href="{$sectionSubmissionUrl}">Submit to this section <span aria-hidden="true">→</span></a></div>{/if}{/if}</article>{/foreach}
				{if $currentContext->getLocalizedData('copyrightNotice')}<article class="submission-panel"><div class="submission-panel-heading"><span>04</span><h2>{translate key="about.copyrightNotice"}</h2></div>{$currentContext->getLocalizedData('copyrightNotice')}</article>{/if}
				{if $currentContext->getLocalizedData('privacyStatement')}<article class="submission-panel"><div class="submission-panel-heading"><span>05</span><h2>{translate key="about.privacyStatement"}</h2></div>{$currentContext->getLocalizedData('privacyStatement')}</article>{/if}
			</section>
			<aside class="submission-sidebar"><div class="submission-side-card"><p class="submission-eyebrow">Before you begin</p><h2>Have these ready</h2><ul><li>Manuscript files and supplementary material</li><li>Author names, affiliations, and email addresses</li><li>Abstract, keywords, and conflict disclosures</li></ul></div><div class="submission-side-card submission-side-card-soft"><p class="submission-eyebrow">Need help?</p><h2>Questions about your submission?</h2><p>Review the journal policies above or contact the editorial office for guidance.</p><a class="submission-inline-link" href="{url page="about" op="contact"}">Contact the journal →</a></div></aside>
		</div>
	</div>
</main>

{include file="frontend/components/footer.tpl"}
