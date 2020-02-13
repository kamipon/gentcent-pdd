<!-- File Button -->
<div class="control-group">
	<label class="control-label" for="<%- id %>">
		<%- label %>
	</label>

	<div class="controls">
		<a data-toggle="modal" class="btn btn-primary" href="javascript:void(0)" onclick="showImg('<%- id %>')">选择图片</a>
		<img src="" name="<%- id %>" id="<%- id %>" style="height: 50px; width: 50px;">
	</div>
</div>

