{include file="_header.tpl"}
{include file="_navigation.tpl"}

<div class="container">
  {if $message_header}
    <div class="no-insights">
    {$message_header}
    {$message_body}
    </div>
  {/if}
  <div class="stream{if count($insights) eq 1} stream-permalink{/if}">

    <div class="date-group{if $i->date|relative_day eq "today"} today{/if}">
        <div class="date-marker">

            <div class="relative"></div>
            <div class="absolute"></div>
        </div>

<div class="panel panel-default insight insight-default insight-{$i->slug|replace:'_':'-'}
  {if $i->emphasis > '1'}insight-hero{/if} insight-{$color|strip} {if
  isset($i->related_data.hero_image) and $i->emphasis > '1'}insight-wide{/if}" id="insight-{$i->id}">
  <div class="panel-heading ">
    <h2 class="panel-title">
        {if $smarty.get.c eq 'posts'}Are these the posts you were looking for?{/if}
        {if $smarty.get.c eq 'followers'}Looks like there are some folks answering to "{$smarty.get.q}".{/if}
    </h2>
    <p class="panel-subtitle">
        Here are the {if $current_page eq 1}first {$posts|@count} {/if}results
    </p>
    {if $i->header_image neq ''}
    <img src="{$i->header_image|use_https}" alt="" width="50" height="50" class="img-circle userpic userpic-featured">
    {/if}
  </div>
  <div class="panel-desktop-right">
    <div class="panel-body">
      <div class="panel-body-inner">
        {if $smarty.get.c eq 'posts'}
            {if $posts|@count > 0}
            {foreach from=$posts key=pid item=post name=bar}
                {include file=$tpl_path|cat:"_post.tpl" post=$post hide_insight_header='1'}
            {/foreach}
            {else}
             <h2>No posts found.</h2>
            {/if}
        {/if}

        {if $smarty.get.c eq 'searches'}
            {if $posts|@count > 0}
            {foreach from=$posts key=pid item=post name=bar}
                {include file=$tpl_path|cat:"_post.tpl" post=$post hide_insight_header='1'}
            {/foreach}
            {else}
             <h2>No posts found.</h2>
            {/if}
        {/if}

        {if $smarty.get.c eq 'followers'}
            {if $users|@count > 0}
                {include file=$tpl_path|cat:"_users.tpl" users=$users }
            {else}
                <h2>No followers found.</h2>
            {/if}
        {/if}

      </div>
    </div>
    <div class="panel-footer">
      <div class="insight-metadata">
        <i class="fa fa-{$u->network}-square icon icon-network"></i>
        <a class="permalink" href="{$permalink}">{$i->date|date_format:"%b %e"}</a>
      </div>
      <div class="share-menu">
        {if $i->instance->is_public eq 1}
        <a class="share-button-open" href="#"><i class="fa fa-share-square-o icon icon-share"></i></a>
        <ul class="share-services">
        <li class="share-service"><a href="https://twitter.com/intent/tweet?related=thinkup&amp;text={$i->headline|strip_tags:true|strip|truncate:100}&amp;url={$permalink|escape:'url'}&amp;via=thinkup"><i class="fa fa-twitter icon icon-share"></i></a></li>
        <li class="share-service"><a href="https://www.facebook.com/sharer.php?u={$permalink|escape:'url'}" target="_blank"><i class="fa fa-facebook icon icon-share"></i></a></li>
        <li class="share-service"><a href="{$permalink}"><i class="fa fa-link icon icon-share"></i></a></li>
        </ul>
        <a class="share-button-close" href="#"><i class="fa fa-times-circle icon icon-share"></i></a>
        {else}
        <i class="fa fa-lock icon icon-share text-muted" title="This {$i->instance->network} account and its insights are private."></i>
        {/if}
      </div>
    </div>
  </div>
</div>


    </div><!-- end date-group -->


    <div class="stream-pagination-control">
      <ul class="pager">
      {if $next_page}
        <li class="previous">
          <a href="{$site_root_path}insights.php?{if $smarty.get.v}v={$smarty.get.v}&amp;{/if}{if $smarty.get.u}u={$smarty.get.u}&amp;{/if}{if $smarty.get.n}n={$smarty.get.n|urlencode}&amp;{/if}page={$next_page}" id="next_page" class="pull-left btn btn-small"><i class="fa fa-arrow-left"></i> Older</a>
        </li>
      {/if}
      {if $last_page}
        <li class="next">
          <a href="{$site_root_path}insights.php?{if $smarty.get.v}v={$smarty.get.v}&amp;{/if}{if $smarty.get.u}u={$smarty.get.u}&amp;{/if}{if $smarty.get.n}n={$smarty.get.n|urlencode}&amp;{/if}page={$last_page}" id="last_page" class="pull-right btn btn-small">Newer <i class="fa fa-arrow-right"></i></a>
        </li>
      {/if}
      </ul>
    </div>

  </div><!-- end stream -->
</div><!-- end container -->

{include file="_footer.tpl" linkify=1}