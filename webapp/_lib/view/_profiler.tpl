
<div class="table-responsive col-xs-6" style="position: absolute; top: 48px; right: 4px; border: 1px solid #ccc; width: 33%; height: 1000px; background-color: #ffc; opacity: 0.8; overflow: scroll;">

{if $i}

<script type="text/javascript">

	var insightsArray = {$insights|@json_encode};

</script>

<div id="instance_tree"><div>


<pre style="background-color: transparent; border: none;">
{$insights|@print_r}
</pre>

{/if}

{foreach from=$profile_items key=tid item=t name=foo}

{if $smarty.foreach.foo.index == 0}

<h5 {if $t.time > 0.5}class="text-danger"{/if}>{$t.time} seconds {$t.action}</h5>
<table class="table table-condensed table-hover">
	<thead>
	<tr>
	    <th>Time</th>
	    <th>Rows</th>
	    <th>Action</th>
	    <th>Class and method</th>
	</tr>
	</thead>

	<tbody>
{else}
	<tr>
	    <td style="vertical-align: top;" {if $t.time > 0.5}class="danger"{/if}>{$t.time}s</td>
	    <td style="vertical-align: top;">{if $t.is_query}{$t.num_rows}{/if}</td>
	    <td>{$t.action}</td>
	    <td style="vertical-align: top;">{$t.dao_method}</td>
	</tr>
{/if}
{/foreach}
	</tbody>
</table>
</div>