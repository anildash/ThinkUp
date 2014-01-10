{*
Renders an insight with an array of post objects in related_data.

Parameters:
$i (required) Insight object
*}

<ul class="body-list tweet-list" style="">
{foreach from=$i->related_data.posts key=uid item=post name=bar}

    <li class="list-item">
      {include file=$tpl_path|cat:"_post.tpl" post=$post}
    </li>

{if isset($i->related_data.posts[1])}
<button class="btn btn-default btn-block btn-see-all" data-text="Actually, please hide them"><span class="btn-text">See all tweets</span> <i class="fa fa-chevron-down icon"></i></button>

{/if}

    {assign var="prev_post_year" value=$p->adj_pub_date|date_format:"%Y"}
{/foreach}
</ul>
