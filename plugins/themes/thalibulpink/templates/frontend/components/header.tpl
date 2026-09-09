{strip}
	{assign var="showingLogo" value=$displayPageHeaderLogo}
	{assign var="pageTitleTranslated" value=$pageTitleTranslated|default:$pageTitle}
{/strip}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
{include file="frontend/components/headerHead.tpl"}
<body class="page_{$requestedPage|escape|default:"index"} op_{$requestedOp|escape|default:"index"}" dir="{$currentLocaleLangDir|escape|default:"ltr"}">
