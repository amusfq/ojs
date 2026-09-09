{if $requestedPage != 'index' && $requestedPage != 'article'}
	<footer class="border-t border-slate-200 bg-[#eef1fb] px-4 py-10 text-xs text-slate-500 lg:px-12">
		<div class="mx-auto grid max-w-[1440px] gap-8 md:grid-cols-4">
			<div><strong class="text-sm text-slate-900">{$currentContext->getLocalizedName()|escape}</strong><p class="mt-3 leading-6">A peer-reviewed scholarly journal publishing accessible research and meaningful academic exchange.</p></div>
			<div><strong class="uppercase tracking-wider text-slate-900">Editorial policies</strong><p class="mt-3 leading-6"><a href="{url page="submissions"}">Author guidelines</a><br><a href="{url page="about"}">About the journal</a></p></div>
			<div><strong class="uppercase tracking-wider text-slate-900">Indexing &amp; archiving</strong><p class="mt-3 leading-6">Discoverability, persistent identifiers, and long-term preservation.</p></div>
			<div><strong class="uppercase tracking-wider text-slate-900">Feeds &amp; metadata</strong><p class="mt-3 leading-6">Subscribe to issue updates and machine-readable metadata.</p></div>
		</div>
		<div class="mx-auto mt-8 flex max-w-[1440px] flex-col justify-between gap-2 border-t border-slate-200 pt-4 text-xs text-slate-500 sm:flex-row">
			<span>© {$smarty.now|date_format:"%Y"} {$currentContext->getLocalizedName()|escape}</span>
			<span class="inline-flex items-center gap-1">Made with <svg aria-label="love" class="h-3.5 w-3.5 text-red-600" fill="currentColor" viewBox="0 0 24 24" role="img"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78L12 21.23l8.84-8.84a5.5 5.5 0 0 0 0-7.78Z"></path></svg> by <a class="font-semibold text-[#9d3953] no-underline" href="https://amusfq.dev" target="_blank" rel="noreferrer">amusfq.dev</a></span>
		</div>
	</footer>
{/if}
{load_script context="frontend"}
{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
