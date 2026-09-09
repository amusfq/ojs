{assign var="issueTitle" value=""}
{assign var="issueSeries" value=""}
{assign var="issueDate" value=""}
{assign var="issueDescription" value=""}
{assign var="issueCover" value=""}
{assign var="issueCoverAlt" value=""}
{assign var="issueDoi" value=""}
{if $issue}
  {if $issue->getShowTitle()}{assign var="issueTitle" value=$issue->getLocalizedTitle()}{/if}
  {assign var="issueSeries" value=$issue->getIssueSeries()}
  {assign var="issueDate" value=$issue->getDatePublished()|date_format:$dateFormatLong}
  {assign var="issueDescription" value=$issue->getLocalizedDescription()|default:''|strip_unsafe_html}
  {assign var="issueCover" value=$issue->getLocalizedCoverImageUrl()}
  {assign var="issueCoverAlt" value=$issue->getLocalizedCoverImageAltText()}
  {assign var="issueDoiObject" value=$issue->getData('doiObject')}
  {if $issueDoiObject}{assign var="issueDoi" value=$issueDoiObject->getData('resolvingUrl')}{/if}
{/if}
{capture assign="homeUrl"}{url page="index" router=$smarty.const.ROUTE_PAGE}{/capture}
{capture assign="searchUrl"}{url page="search"}{/capture}
{capture assign="archivesUrl"}{url page="issue" op="archive"}{/capture}
{capture assign="aboutUrl"}{url page="about"}{/capture}
{capture assign="aboutSubmissionsUrl"}{url page="about" op="submissions"}{/capture}
{capture assign="aboutContactUrl"}{url page="about" op="contact"}{/capture}
{capture assign="submissionsUrl"}{url page="submissions"}{/capture}
{capture assign="loginUrl"}{url page="login"}{/capture}
{capture assign="profileUrl"}{url page="user" op="profile"}{/capture}
{capture assign="dashboardUrl"}{url page="dashboard"}{/capture}
{capture assign="logoutUrl"}{url page="login" op="signOut"}{/capture}
{capture assign="notificationUrl"}{url router=PKP\core\PKPApplication::ROUTE_PAGE page="notification" op="fetchNotification"}{/capture}
{capture assign="notificationMarkNewUrl"}{url router=PKP\core\PKPApplication::ROUTE_COMPONENT component="grid.notifications.NotificationsGridHandler" op="markNew"}{/capture}
{capture assign="notificationMarkReadUrl"}{url router=PKP\core\PKPApplication::ROUTE_COMPONENT component="grid.notifications.NotificationsGridHandler" op="markRead"}{/capture}
{capture assign="notificationDeleteUrl"}{url router=PKP\core\PKPApplication::ROUTE_COMPONENT component="grid.notifications.NotificationsGridHandler" op="deleteNotifications"}{/capture}
{capture assign="issueUrl"}{url page="issue" op="view" path=$issue->getBestIssueId()}{/capture}
{if $issueGalleys}{assign var="issueGalley" value=$issueGalleys|@reset}{capture assign="issueGalleyUrl"}{url page="issue" op="download" path=$issue->getBestIssueId()|to_array:$issueGalley->getBestGalleyId()}{/capture}{/if}
{assign var="logoUrl" value="{$baseUrl}/plugins/themes/thalibulpink/logo_small.png"}
{include file="frontend/components/header.tpl" pageTitleTranslated=$issueIdentification}
<main id="thalibul-pink-issue"></main>
<script type="application/json" id="thalibul-pink-issue-data">
{ldelim}
"journalName": {$currentJournal->getLocalizedName()|json_encode nofilter},
"logo": {$logoUrl|json_encode nofilter},
"homeUrl": {$homeUrl|json_encode nofilter}, "searchUrl": {$searchUrl|json_encode nofilter}, "archivesUrl": {$archivesUrl|json_encode nofilter}, "aboutUrl": {$aboutUrl|json_encode nofilter}, "aboutSubmissionsUrl": {$aboutSubmissionsUrl|json_encode nofilter}, "aboutContactUrl": {$aboutContactUrl|json_encode nofilter}, "submissionsUrl": {$submissionsUrl|json_encode nofilter}, "loginUrl": {$loginUrl|json_encode nofilter}, "profileUrl": {$profileUrl|json_encode nofilter}, "dashboardUrl": {$dashboardUrl|json_encode nofilter}, "logoutUrl": {$logoutUrl|json_encode nofilter},
"loggedIn": {if $isUserLoggedIn}true{else}false{/if}, "notificationCount": {$unreadNotificationCount|default:0|intval}, "notificationUrl": {$notificationUrl|json_encode nofilter}, "notificationMarkNewUrl": {$notificationMarkNewUrl|json_encode nofilter}, "notificationMarkReadUrl": {$notificationMarkReadUrl|json_encode nofilter}, "notificationDeleteUrl": {$notificationDeleteUrl|json_encode nofilter}, "csrfToken": {csrf type="json"}, "username": {$loggedInUsername|default:''|json_encode nofilter},
"identification": {$issueIdentification|default:''|escape|json_encode nofilter}, "title": {$issueTitle|json_encode nofilter}, "series": {$issueSeries|json_encode nofilter}, "date": {$issueDate|json_encode nofilter}, "description": {$issueDescription|json_encode nofilter}, "headerSubtitle": {$issueDescription|strip_tags|truncate:110|json_encode nofilter}, "cover": {$issueCover|json_encode nofilter}, "coverAlt": {$issueCoverAlt|json_encode nofilter}, "doi": {$issueDoi|json_encode nofilter}, "issueUrl": {$issueUrl|json_encode nofilter}, "issueGalleyUrl": {$issueGalleyUrl|default:''|json_encode nofilter}, "published": {if $issue && $issue->getPublished()}true{else}false{/if},
"popularArticle": {if $thalibulPinkPopularIssueArticle}{assign var="popularPublication" value=$thalibulPinkPopularIssueArticle->getCurrentPublication()}{capture assign="popularArticleUrl"}{url page="article" op="view" path=$thalibulPinkPopularIssueArticle->getBestId()}{/capture}{ldelim}"title": {$popularPublication->getLocalizedFullTitle(null, 'html')|strip_unsafe_html|strip_tags|json_encode nofilter}, "authors": {$popularPublication->getAuthorString($authorUserGroups)|escape|json_encode nofilter}, "abstract": {$popularPublication->getLocalizedData('abstract')|default:''|strip_unsafe_html|strip_tags|truncate:520|json_encode nofilter}, "url": {$popularArticleUrl|json_encode nofilter}, "doi": {$thalibulPinkIssueDois[$thalibulPinkPopularIssueArticle->getId()]|default:''|json_encode nofilter}, "stats": {$thalibulPinkIssueStats[$thalibulPinkPopularIssueArticle->getId()]|default:[]|json_encode nofilter}{rdelim}{else}null{/if},
"articleStats": {$thalibulPinkIssueStats|default:[]|json_encode nofilter}, "articleDois": {$thalibulPinkIssueDois|default:[]|json_encode nofilter},
"sections": [
{foreach name=sections from=$publishedSubmissions item=section}{if $section.articles}{if !$smarty.foreach.sections.first},{/if}{ldelim}"title": {$section.title|default:''|escape|json_encode nofilter}, "articles": [{foreach name=articles from=$section.articles item=article}{assign var="publication" value=$article->getCurrentPublication()}{capture assign="articleUrl"}{url page="article" op="view" path=$article->getBestId()}{/capture}{if !$smarty.foreach.articles.first},{/if}{ldelim}"id": {$article->getId()|intval}, "title": {$publication->getLocalizedFullTitle(null, 'html')|strip_unsafe_html|strip_tags|json_encode nofilter}, "authors": {$publication->getAuthorString($authorUserGroups)|escape|json_encode nofilter}, "abstract": {$publication->getLocalizedData('abstract')|default:''|strip_unsafe_html|strip_tags|truncate:520|json_encode nofilter}, "date": {$publication->getData('datePublished')|date_format:$dateFormatLong|json_encode nofilter}, "pages": {$publication->getData('pages')|default:''|escape|json_encode nofilter}, "url": {$articleUrl|json_encode nofilter}{rdelim}{/foreach}]{rdelim}{/if}{/foreach}
]
{rdelim}
</script>
{include file="frontend/components/footer.tpl"}
