{if $i->related_data.milestones}
  {include file=$tpl_path|cat:"_bignumbers.tpl"
  milestones=$i->related_data.milestones}
{/if}
