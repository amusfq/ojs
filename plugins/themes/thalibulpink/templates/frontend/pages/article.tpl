{assign var="doiUrl" value=""}
{assign var="issueTitle" value=""}
{assign var="issueUrl" value=""}
{assign var="sectionTitle" value=""}
{if $issue}
	{assign var="issueTitle" value=$issue->getIssueIdentification()}
	{capture assign="issueUrl"}{url page="issue" op="view" path=$issue->getBestIssueId()}{/capture}
{/if}
{if $section}{assign var="sectionTitle" value=$section->getLocalizedTitle()}{/if}
{assign var="doiObject" value=$publication->getData('doiObject')}
{if $doiObject}{assign var="doiUrl" value=$doiObject->getData('resolvingUrl')}{/if}
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
{assign var="logoUrl" value="{$baseUrl}/plugins/themes/thalibulpink/logo_small.png"}
{include file="frontend/components/header.tpl" pageTitleTranslated=$publication->getLocalizedFullTitle(null, 'html')|strip_unsafe_html}
<main id="thalibul-pink-article"></main>
<script type="application/json" id="thalibul-pink-article-data">
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
	"title": {$publication->getLocalizedFullTitle(null, 'html')|strip_unsafe_html|strip_tags|json_encode nofilter},
	"subtitle": {$publication->getLocalizedSubTitle(null, 'html')|default:''|strip_unsafe_html|strip_tags|json_encode nofilter},
	"abstract": {$publication->getLocalizedData('abstract')|default:''|strip_unsafe_html|strip_tags|json_encode nofilter},
	"authors": [{foreach name=authors from=$publication->getData('authors') item=author}{if !$smarty.foreach.authors.first},{/if}{$author->getFullName()|escape|json_encode nofilter}{/foreach}],
	"date": {$publication->getData('datePublished')|date_format:$dateFormatLong|json_encode nofilter},
	"issue": {$issueTitle|json_encode nofilter},
	"issueUrl": {$issueUrl|json_encode nofilter},
	"section": {$sectionTitle|json_encode nofilter},
	"doi": {$doiUrl|json_encode nofilter},
	"licenseUrl": {$publication->getData('licenseUrl')|default:''|json_encode nofilter},
	"pages": {$publication->getData('pages')|default:''|json_encode nofilter},
	"stats": {$thalibulPinkArticleStats|default:[]|json_encode nofilter},
	"galleys": [{foreach name=galleys from=$primaryGalleys item=galley}{if !$smarty.foreach.galleys.first},{/if}{assign var="galleyPath" value=$publication->getData('urlPath')|default:$article->getId()|to_array:$galley->getBestGalleyId()}{capture assign="galleyUrl"}{url page="article" op="view" path=$galleyPath}{/capture}{ldelim}"label": {$galley->getGalleyLabel()|escape|json_encode nofilter}, "url": {$galleyUrl|json_encode nofilter}, "isPdf": {if $galley->isPdfGalley()}true{else}false{/if}{rdelim}{/foreach}]
}
</script>
{include file="frontend/components/footer.tpl"}
