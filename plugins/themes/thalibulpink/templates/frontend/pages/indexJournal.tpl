{assign var="issueTitle" value=""}
{assign var="issueSeries" value=""}
{assign var="issueDate" value=""}
{assign var="issueDescription" value=""}
{assign var="issueCover" value=""}
{if $issue}
	{if $issue->getShowTitle()}{assign var="issueTitle" value=$issue->getLocalizedTitle()}{/if}
	{assign var="issueSeries" value=$issue->getIssueSeries()}
	{if $issue->getDatePublished()}{assign var="issueDate" value=$issue->getDatePublished()|date_format:$dateFormatLong}{/if}
	{if $issue->getLocalizedDescription()}{assign var="issueDescription" value=$issue->getLocalizedDescription()|strip_unsafe_html}{/if}
	{assign var="issueCover" value=$issue->getLocalizedCoverImageUrl()}
{/if}
{capture assign="homeUrl"}{url page="index" router=$smarty.const.ROUTE_PAGE}{/capture}
{capture assign="searchUrl"}{url page="search"}{/capture}
{capture assign="archivesUrl"}{url page="issue" op="archive"}{/capture}
{capture assign="aboutUrl"}{url page="about"}{/capture}
{capture assign="aboutSubmissionsUrl"}{url page="about" op="submissions"}{/capture}
{capture assign="aboutContactUrl"}{url page="about" op="contact"}{/capture}
{capture assign="submissionsUrl"}{url page="submissions"}{/capture}
{capture assign="loginUrl"}{url page="login"}{/capture}
{capture assign="registerUrl"}{url page="user" op="register"}{/capture}
{capture assign="profileUrl"}{url page="user" op="profile"}{/capture}
{capture assign="dashboardUrl"}{url page="dashboard"}{/capture}
{capture assign="logoutUrl"}{url page="login" op="signOut"}{/capture}
{capture assign="notificationUrl"}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="notification" op="fetchNotification"}{/capture}
{capture assign="notificationMarkNewUrl"}{url router=PKP\core\PKPApplication::ROUTE_COMPONENT component="grid.notifications.NotificationsGridHandler" op="markNew"}{/capture}
{capture assign="notificationMarkReadUrl"}{url router=PKP\core\PKPApplication::ROUTE_COMPONENT component="grid.notifications.NotificationsGridHandler" op="markRead"}{/capture}
{capture assign="notificationDeleteUrl"}{url router=PKP\core\PKPApplication::ROUTE_COMPONENT component="grid.notifications.NotificationsGridHandler" op="deleteNotifications"}{/capture}
{if $issue}{capture assign="issueUrl"}{url page="issue" op="view" path=$issue->getBestIssueId()}{/capture}{else}{assign var="issueUrl" value=$archivesUrl}{/if}
{assign var="logoUrl" value="{$baseUrl}/plugins/themes/thalibulpink/logo_small.png"}
{assign var="issn" value=$currentJournal->getData('onlineIssn')|default:$currentJournal->getData('printIssn')}
{assign var="journalDescription" value=$currentJournal->getLocalizedDescription()|default:''|strip_unsafe_html}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}
<main id="main">
	<div id="thalibul-pink-current-issue"></div>
	<script type="application/json" id="thalibul-pink-current-issue-data">
	{
		"journalName": {$currentJournal->getLocalizedName()|json_encode nofilter},
		"logo": {$logoUrl|json_encode nofilter},
		"homeUrl": {$homeUrl|json_encode nofilter},
		"searchUrl": {$searchUrl|json_encode nofilter},
		"archivesUrl": {$archivesUrl|json_encode nofilter},
		"aboutUrl": {$aboutUrl|json_encode nofilter},
		"aboutSubmissionsUrl": {$aboutSubmissionsUrl|json_encode nofilter},
		"aboutContactUrl": {$aboutContactUrl|json_encode nofilter},
		"submissionsUrl": {$submissionsUrl|json_encode nofilter},
		"issueUrl": {$issueUrl|json_encode nofilter},
		"loginUrl": {$loginUrl|json_encode nofilter},
		"registerUrl": {$registerUrl|json_encode nofilter},
		"profileUrl": {$profileUrl|json_encode nofilter},
		"dashboardUrl": {$dashboardUrl|json_encode nofilter},
		"logoutUrl": {$logoutUrl|json_encode nofilter},
		"loggedIn": {if $isUserLoggedIn}true{else}false{/if},
		"notificationUrl": {$notificationUrl|json_encode nofilter},
		"notificationMarkNewUrl": {$notificationMarkNewUrl|json_encode nofilter},
		"notificationMarkReadUrl": {$notificationMarkReadUrl|json_encode nofilter},
		"notificationDeleteUrl": {$notificationDeleteUrl|json_encode nofilter},
		"csrfToken": {csrf type="json"},
		"notificationCount": {$unreadNotificationCount|default:0|intval},
		"username": {$loggedInUsername|default:''|json_encode nofilter},
		"issn": {$issn|default:''|json_encode nofilter},
		"journalDescription": {$journalDescription|strip_tags|json_encode nofilter},
		"title": {$issueTitle|json_encode nofilter},
		"series": {$issueSeries|json_encode nofilter},
		"date": {$issueDate|json_encode nofilter},
		"description": {$issueDescription|json_encode nofilter},
		"cover": {$issueCover|json_encode nofilter},
		"sections": [
		{foreach name=sections from=$publishedSubmissions item=section}
			{if $section.articles}{if !$smarty.foreach.sections.first},{/if}
			{
				"title": {$section.title|json_encode nofilter},
				"articles": [
				{foreach name=articles from=$section.articles item=article}
					{assign var="publication" value=$article->getCurrentPublication()}
					{assign var="articlePath" value=$publication->getData('urlPath')|default:$article->getId()}
					{assign var="articleStats" value=$thalibulPinkStats[$article->getId()]|default:[]}
					{assign var="articleDoiObject" value=$publication->getData('doiObject')}
					{capture assign="articleUrl"}{url page="article" op="view" path=$articlePath}{/capture}
					{if !$smarty.foreach.articles.first},{/if}{
						"title": {$publication->getLocalizedFullTitle(null, 'html')|strip_unsafe_html|json_encode nofilter},
						"section": {$section.title|default:''|json_encode nofilter},
						"stats": {$articleStats|json_encode nofilter},
						"doi": {if $articleDoiObject}{$articleDoiObject->getData('resolvingUrl')|default:''|json_encode nofilter}{else}""{/if},
						"authors": {$publication->getAuthorString($authorUserGroups)|escape|json_encode nofilter},
						"abstract": {$publication->getLocalizedData('abstract')|strip_unsafe_html|strip_tags|truncate:520|json_encode nofilter},
						"date": {$publication->getData('datePublished')|date_format:$dateFormatLong|json_encode nofilter},
						"url": {$articleUrl|json_encode nofilter}
					}
				{/foreach}
				]
			}
			{/if}
		{/foreach}
		]
	}
	</script>
</main>
{include file="frontend/components/footer.tpl"}
